![animation](assets/animation.gif)

# BoundTypes.jl

The BoundTypes library helps you to seamlessly design and set rules for data types in your code, making it safer and more reliable.

## Installation
To install BoundTypes, simply use the Julia package manager:

```julia
] add BoundTypes
```

## Usage

Demonstrate value validation during object construction:

```julia
using BoundTypes

struct CoinInfo
    asset::StringPattern{String,pattern"^([A-Z]+)$"}
    network::StringMinLength{String,3}
    address::StringFixedLength{StringPattern{String,pattern"^0x([abcdef0-9]+)$"},40}
    deposit_fee::NumberNonNegative{Float64}
    withdrawal_fee::NumberPositive{Float64}
end

julia> CoinInfo("ETH", "Ethereum", "0xc0ffee254729296a45a3885639ac7e10f9d549", 0.0, 0.01)
CoinInfo("ETH", "Ethereum", "0xc0ffee254729296a45a3885639ac7e10f9d549", 0.0, 0.01)

julia> CoinInfo("eth!", "EM", "0xc0FFE12A2", -1.0, 0.0)
Wrong value: "eth!" must match to regex pattern ^([A-Z]+)$.
```

Using BoundTypes for serialization and deserialization with [Serde.jl](https://github.com/bhftbootcamp/Serde.jl):

```julia
using Serde
using BoundTypes

struct User
    name::StringMinLength{String,5}
    pass::StringMaxLength{StringMinLength{StringPattern{String,pattern"^[\w@]+$"},10},20}
end

julia> Serde.deser_json(User, """ {"name": "Julia", "pass": "MyBestP@ssw0rdEv3r"} """)
User("Julia", "MyBestP@ssw0rdEv3r")

julia> Serde.deser_json(User, """ {"name": "Julia", "pass": "2ShrtP@ss"} """)
Wrong value: length of the "2ShrtP@ss" must be at least 10 characters (9).

julia> Serde.deser_json(User, """ {"name": "Julia", "pass": "Bad/Password#"} """)
Wrong value: "Bad/Password#" must match to regex pattern ^[\w@]+$.

julia> Serde.to_json(User("Julia", "MyBestP@ssw0rdEv3r"))
"{\"name\":\"Julia\",\"pass\":\"MyBestP@ssw0rdEv3r\"}"
```
