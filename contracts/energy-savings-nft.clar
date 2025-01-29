;; Energy Savings NFT Contract

(define-non-fungible-token energy-savings-nft uint)

(define-map nft-data
  { token-id: uint }
  {
    owner: principal,
    energy-saved: uint,
    achievement-type: (string-ascii 20),
    timestamp: uint
  }
)

(define-data-var token-id-nonce uint u0)

(define-constant AUTHORIZED_MINTERS
  (list
    'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM
    'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
  )
)

(define-read-only (is-authorized-minter (address principal))
  (is-some (index-of AUTHORIZED_MINTERS address))
)

(define-public (mint-energy-savings-nft (recipient principal) (energy-saved uint) (achievement-type (string-ascii 20)))
  (let
    ((new-token-id (+ (var-get token-id-nonce) u1)))
    (asserts! (is-authorized-minter tx-sender) ERR_UNAUTHORIZED)
    (try! (nft-mint? energy-savings-nft new-token-id recipient))
    (map-set nft-data
      { token-id: new-token-id }
      {
        owner: recipient,
        energy-saved: energy-saved,
        achievement-type: achievement-type,
        timestamp: block-height
      }
    )
    (var-set token-id-nonce new-token-id)
    (ok new-token-id)
  )
)

(define-read-only (get-nft-data (token-id uint))
  (map-get? nft-data { token-id: token-id })
)

(define-constant ERR_UNAUTHORIZED (err u401))

