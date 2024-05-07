# BoundTypes.jl

The BoundTypes library helps you to seemlessly design and set rules for data types in your code, making it safer and more reliable.

## Quickstart

Here's how you can use BoundTypes to validate Coin information on Ethereum blockchain.

```julia
using BoundTypes

struct CoinInfo
    asset::StringPattern{String,pattern"^([A-Z]+)$"}
    network::StringMinLength{String,3}
    address::StringFixedLength{StringPattern{String,pattern"^0x([abcdef0-9]+)$"},40}
    deposit_fee::NumberNonNegative{Float64}
    withdrawal_fee::NumberPositive{Float64}
end

# Valid example
CoinInfo("ETH", "Ethereum", "0xc0ffee254729296a45a3885639ac7e10f9d549", 0.0, 0.01)

# Invalid example: 'asset' should only contain uppercase letters
CoinInfo("eth!", "EM", "0xc0FFE12A2", -1.0, 0.0)
```
