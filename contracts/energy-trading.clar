;; Energy Trading Contract

(define-map energy-offers
  { offer-id: uint }
  {
    seller: principal,
    energy-amount: uint,
    price-per-unit: uint,
    expiration: uint
  }
)

(define-map energy-trades
  { trade-id: uint }
  {
    seller: principal,
    buyer: principal,
    energy-amount: uint,
    total-price: uint,
    timestamp: uint
  }
)

(define-data-var offer-id-nonce uint u0)
(define-data-var trade-id-nonce uint u0)

(define-public (create-energy-offer (energy-amount uint) (price-per-unit uint) (expiration uint))
  (let
    ((new-offer-id (+ (var-get offer-id-nonce) u1)))
    (map-set energy-offers
      { offer-id: new-offer-id }
      {
        seller: tx-sender,
        energy-amount: energy-amount,
        price-per-unit: price-per-unit,
        expiration: expiration
      }
    )
    (var-set offer-id-nonce new-offer-id)
    (ok new-offer-id)
  )
)

(define-public (accept-energy-offer (offer-id uint) (energy-amount uint))
  (let
    ((offer (unwrap! (map-get? energy-offers { offer-id: offer-id }) ERR_OFFER_NOT_FOUND))
     (total-price (* energy-amount (get price-per-unit offer))))
    (asserts! (<= energy-amount (get energy-amount offer)) ERR_INSUFFICIENT_ENERGY)
    (asserts! (< block-height (get expiration offer)) ERR_OFFER_EXPIRED)
    (try! (stx-transfer? total-price tx-sender (get seller offer)))
    (let
      ((new-trade-id (+ (var-get trade-id-nonce) u1)))
      (map-set energy-trades
        { trade-id: new-trade-id }
        {
          seller: (get seller offer),
          buyer: tx-sender,
          energy-amount: energy-amount,
          total-price: total-price,
          timestamp: block-height
        }
      )
      (var-set trade-id-nonce new-trade-id)
      (if (< energy-amount (get energy-amount offer))
        (map-set energy-offers
          { offer-id: offer-id }
          (merge offer { energy-amount: (- (get energy-amount offer) energy-amount) })
        )
        (map-delete energy-offers { offer-id: offer-id })
      )
      (ok new-trade-id)
    )
  )
)

(define-read-only (get-energy-offer (offer-id uint))
  (map-get? energy-offers { offer-id: offer-id })
)

(define-read-only (get-energy-trade (trade-id uint))
  (map-get? energy-trades { trade-id: trade-id })
)

(define-constant ERR_OFFER_NOT_FOUND (err u404))
(define-constant ERR_INSUFFICIENT_ENERGY (err u400))
(define-constant ERR_OFFER_EXPIRED (err u400))

