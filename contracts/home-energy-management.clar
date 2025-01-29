;; Home Energy Management Contract

(define-map home-energy-systems
  { home-id: uint }
  {
    owner: principal,
    smart-meter-id: (string-ascii 50),
    battery-capacity: uint,
    current-battery-level: uint,
    solar-panel-capacity: uint,
    last-updated: uint
  }
)

(define-data-var home-id-nonce uint u0)

(define-public (register-home-energy-system
  (smart-meter-id (string-ascii 50))
  (battery-capacity uint)
  (solar-panel-capacity uint)
)
  (let
    ((new-home-id (+ (var-get home-id-nonce) u1)))
    (map-set home-energy-systems
      { home-id: new-home-id }
      {
        owner: tx-sender,
        smart-meter-id: smart-meter-id,
        battery-capacity: battery-capacity,
        current-battery-level: u0,
        solar-panel-capacity: solar-panel-capacity,
        last-updated: block-height
      }
    )
    (var-set home-id-nonce new-home-id)
    (ok new-home-id)
  )
)

(define-public (update-battery-level (home-id uint) (new-battery-level uint))
  (let
    ((home-system (unwrap! (map-get? home-energy-systems { home-id: home-id }) ERR_HOME_NOT_FOUND)))
    (asserts! (is-eq tx-sender (get owner home-system)) ERR_UNAUTHORIZED)
    (asserts! (<= new-battery-level (get battery-capacity home-system)) ERR_INVALID_BATTERY_LEVEL)
    (ok (map-set home-energy-systems
      { home-id: home-id }
      (merge home-system {
        current-battery-level: new-battery-level,
        last-updated: block-height
      })
    ))
  )
)

(define-read-only (get-home-energy-system (home-id uint))
  (map-get? home-energy-systems { home-id: home-id })
)

(define-constant ERR_HOME_NOT_FOUND (err u404))
(define-constant ERR_UNAUTHORIZED (err u401))
(define-constant ERR_INVALID_BATTERY_LEVEL (err u400))

