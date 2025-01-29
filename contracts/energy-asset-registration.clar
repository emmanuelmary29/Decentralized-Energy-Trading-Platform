;; Energy Asset Registration Contract

(define-non-fungible-token energy-asset uint)

(define-map energy-producers
  { producer-id: uint }
  {
    owner: principal,
    energy-type: (string-ascii 20),
    capacity: uint,
    location: (string-ascii 100)
  }
)

(define-data-var producer-id-nonce uint u0)

(define-public (register-energy-producer
  (energy-type (string-ascii 20))
  (capacity uint)
  (location (string-ascii 100))
)
  (let
    ((new-producer-id (+ (var-get producer-id-nonce) u1)))
    (try! (nft-mint? energy-asset new-producer-id tx-sender))
    (map-set energy-producers
      { producer-id: new-producer-id }
      {
        owner: tx-sender,
        energy-type: energy-type,
        capacity: capacity,
        location: location
      }
    )
    (var-set producer-id-nonce new-producer-id)
    (ok new-producer-id)
  )
)

(define-read-only (get-energy-producer (producer-id uint))
  (map-get? energy-producers { producer-id: producer-id })
)

(define-public (update-energy-capacity (producer-id uint) (new-capacity uint))
  (let
    ((producer (unwrap! (map-get? energy-producers { producer-id: producer-id }) ERR_PRODUCER_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get owner producer)) ERR_UNAUTHORIZED)
    (ok (map-set energy-producers
      { producer-id: producer-id }
      (merge producer { capacity: new-capacity })
    ))
  )
)

(define-constant ERR_PRODUCER_NOT_FOUND (err u404))
(define-constant ERR_UNAUTHORIZED (err u401))

