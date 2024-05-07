# For Developers

## Define custom bound type

A user can define his own boundary types:

```julia
struct SomeBound{T<:ElType} <: SomeExistingBoundType{T}
    value::T

    function SomeBound{T}(x::AbstractString) where {T<:AbstractString}
        !condition_1(x) && throw(ConstraintError{SomeBound}("Error message 1"))
        !condition_2(x) && throw(ConstraintError{SomeBound}("Error message 2"))
        # other conditions ...

        return new{T}(x)
    end
end
```
Here are some guidelines for defining your own bound types:
-  Names of new boundary types should characterize them (for example `NumberPositive`, `StringUpperCase` or `TimeInterval`).
- The element type and supertype must correspond to the same data class:
  - `ELTYPE` must be a `Number`, `AbstractString` or `TimeType`.
  - Respectively `BOUNDTYPE` might be a [`BoundNumber`](@ref), [`BoundString`](@ref) or [`BoundTime`](@ref).
- Next, inside the constructor you need to perform a bounds check:
  - Formulate simple and easy to understand checks, i.e. if you want to allow numbers that are greater than 0, then you would have an expression like this `x <= 0 && throw(...)`.
  - If any of the conditions are violated then error [`ConstraintError`](@ref) should be thrown.

### Example

```julia
using BoundTypes

struct StringValidAddress{T<:AbstractString} <: BoundString{T}
    value::T

    function StringValidAddress{T}(x::AbstractString) where {T<:AbstractString}
        length(x) != 40 && throw(
            ConstraintError{StringFixedLength}(
                "length of the \"$x\" must be equal to 40 characters ($(length(x))).",
            ),
        )
        isnothing(match(r"^0x([abcdef0-9])+$", x)) && throw(
            ConstraintError{StringPattern}(
                "\"$x\" must match to regex pattern /^0x([abcdef0-9])+\$./",
            ),
        )
        return new{T}(x)
    end
end
```

```@julia-repl
julia> StringValidAddress{String}("0xf343a817e5f5243190d3c52bf347daf876de1d")
"0xf343a817e5f5243190d3c52bf347daf876de1d"

julia> StringValidAddress{String}("0x14__1ylad2g_-as2@>>")
Wrong value: "0x14__1ylad2g_-as2@>>" must match to regex pattern /^0x([abcdef0-9])+$/.
```
