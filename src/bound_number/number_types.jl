# bound_number/number_types

"""
    NumberCustomBound{T<:Number,B} <: BoundNumber{T}
    NumberCustomBound{T,B}(x::Number)

A number constraint for a value `x` of type `T` using custom function `B`.
Function `B` should only accept object `x` and return `true` or `false` (or throw a custom [`ConstraintError`](@ref)).

## Examples
```julia-repl
julia> NumberCustomBound{Float64,x -> x % 2 == 0}(10.0)
10.0

julia> NumberCustomBound{Float64,x -> x % 2 == 0}(13.0)
ERROR: ConstraintError: constraints of type NumberCustomBound violated.
Wrong value: Custom constraint '#7' violated for value "13.0" of type Float64.
[...]
```
"""
struct NumberCustomBound{T<:Number,B} <: BoundNumber{T}
    value::T

    function NumberCustomBound{T,B}(x::Number) where {T<:Number,B}
        !B(x) && throw(ConstraintError{NumberCustomBound}("Custom constraint '$B' violated for value \"$x\" of type $T."))
        return new{T,B}(x)
    end
end

"""
    NumberPositive{T<:Number} <: BoundNumber{T}
    NumberPositive{T}(x::Number)

A number constraint that enforces `x > 0` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberPositive{Float64}(10.0)
10.0

julia> NumberPositive{Float64}(-10.0)
ERROR: ConstraintError: constraints of type NumberPositive violated.
Wrong value: number -10.0 must be a positive (x > 0).
[...]
```
"""
struct NumberPositive{T<:Number} <: BoundNumber{T}
    value::T

    function NumberPositive{T}(x::Number) where {T<:Number}
        x <= 0 && throw(ConstraintError{NumberPositive}("number $x must be a positive (x > 0)."))
        return new{T}(x)
    end
end

"""
    NumberNonPositive{T<:Number} <: BoundNumber{T}
    NumberNonPositive{T}(x::Number)

A number constraint that enforces `x ≤ 0` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberNonPositive{Float64}(-10.0)
-10.0

julia> NumberNonPositive{Float64}(10.0)
ERROR: ConstraintError: constraints of type NumberNonPositive violated.
Wrong value: number 10.0 must be a negative or zero (x ≤ 0).
[...]
```
"""
struct NumberNonPositive{T<:Number} <: BoundNumber{T}
    value::T

    function NumberNonPositive{T}(x::Number) where {T<:Number}
        x > 0 && throw(ConstraintError{NumberNonPositive}("number $x must be a negative or zero (x ≤ 0)."))
        return new{T}(x)
    end
end

"""
    NumberNegative{T<:Number} <: BoundNumber{T}
    NumberNegative{T}(x::Number)

A number constraint that enforces `x < 0` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberNegative{Float64}(-10.0)
-10.0

julia> NumberNegative{Float64}(10.0)
ERROR: ConstraintError: constraints of type NumberNegative violated.
Wrong value: 10.0 must be a negative (x < 0).
[...]
```
"""
struct NumberNegative{T<:Number} <: BoundNumber{T}
    value::T

    function NumberNegative{T}(x::Number) where {T<:Number}
        x >= 0 && throw(ConstraintError{NumberNegative}("$x must be a negative (x < 0)."))
        return new{T}(x)
    end
end

"""
    NumberNonNegative{T<:Number} <: BoundNumber{T}
    NumberNonNegative{T}(x::Number)

A number constraint that enforces `x ≥ 0` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberNonNegative{Float64}(10.0)
10.0

julia> NumberNonNegative{Float64}(-10.0)
ERROR: ConstraintError: constraints of type NumberNonNegative violated.
Wrong value: -10.0 must be a positive or zero (x ≥ 0).
[...]
```
"""
struct NumberNonNegative{T<:Number} <: BoundNumber{T}
    value::T

    function NumberNonNegative{T}(x::Number) where {T<:Number}
        x < 0 && throw(ConstraintError{NumberNonNegative}("$x must be a positive or zero (x ≥ 0)."))
        return new{T}(x)
    end
end

"""
    NumberGreater{T<:Number,V} <: BoundNumber{T}
    NumberGreater{T,V}(x::Number)

A number constraint that enforces `x > V` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberGreater{Float64,10.0}(20.0)
20.0

julia> NumberGreater{Float64,10.0}(5.0)
ERROR: ConstraintError: constraints of type NumberGreater violated.
Wrong value: 5.0 must be greater than 10.0.
[...]
```
"""
struct NumberGreater{T<:Number,V} <: BoundNumber{T}
    value::T

    function NumberGreater{T,V}(x::Number) where {T<:Number,V}
        x <= V && throw(ConstraintError{NumberGreater}("$x must be greater than $V."))
        return new{T,V}(x)
    end
end

"""
    NumberGreaterOrEqual{T<:Number,V} <: BoundNumber{T}
    NumberGreaterOrEqual{T,V}(x::Number)

A number constraint that enforces `x ≥ V` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberGreaterOrEqual{Float64,10.0}(20.0)
20.0

julia> NumberGreaterOrEqual{Float64,10.0}(5.0)
ERROR: ConstraintError: constraints of type NumberGreaterOrEqual violated.
Wrong value: 5.0 must be greater or equal than 10.0.
[...]
```
"""
struct NumberGreaterOrEqual{T<:Number,V} <: BoundNumber{T}
    value::T

    function NumberGreaterOrEqual{T,V}(x::Number) where {T<:Number,V}
        x < V && throw(ConstraintError{NumberGreaterOrEqual}("$x must be greater or equal than $V."))
        return new{T,V}(x)
    end
end

"""
    NumberLess{T<:Number,V} <: BoundNumber{T}
    NumberLess{T,V}(x::Number)

A number constraint that enforces `x < V` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberLess{Float64,10.0}(5.0)
5.0

julia> NumberLess{Float64,10.0}(20.0)
ERROR: ConstraintError: constraints of type NumberLess violated.
Wrong value: 20.0 must be less than 10.0.
[...]
```
"""
struct NumberLess{T<:Number,V} <: BoundNumber{T}
    value::T

    function NumberLess{T,V}(x::Number) where {T<:Number,V}
        x >= V && throw(ConstraintError{NumberLess}("$x must be less than $V."))
        return new{T,V}(x)
    end
end

"""
    NumberLessOrEqual{T<:Number,V} <: BoundNumber{T}
    NumberLessOrEqual{T,V}(x::Number)

A number constraint that enforces `x ≤ V` for value `x` of type `T`.

## Examples
```jldoctest
julia> NumberLessOrEqual{Float64,10.0}(5.0)
5.0

julia> NumberLessOrEqual{Float64,10.0}(20.0)
ERROR: ConstraintError: constraints of type NumberLessOrEqual violated.
Wrong value: 20.0 must be less or equal than 10.0.
[...]
```
"""
struct NumberLessOrEqual{T<:Number,V} <: BoundNumber{T}
    value::T

    function NumberLessOrEqual{T,V}(x::Number) where {T<:Number,V}
        x > V && throw(ConstraintError{NumberLessOrEqual}("$x must be less or equal than $V."))
        return new{T,V}(x)
    end
end

"""
    NumberOdd{T<:Number} <: BoundNumber{T}
    NumberOdd{T}(x::Number)

A numeric constraint to ensure that the value `x` of type `T` is odd.

## Examples
```jldoctest
julia> NumberOdd{Float64}(5.0)
5.0

julia> NumberOdd{Float64}(4.0)
ERROR: ConstraintError: constraints of type NumberOdd violated.
Wrong value: 4.0 must be odd.
[...]
```
"""
struct NumberOdd{T<:Number} <: BoundNumber{T}
    value::T

    function NumberOdd{T}(x::Number) where {T<:Number}
        !isodd(x) && throw(ConstraintError{NumberOdd}("$x must be odd."))
        return new{T}(x)
    end
end

"""
    NumberEven{T<:Number} <: BoundNumber{T}
    NumberEven{T}(x::Number)

A numeric constraint to ensure that the value `x` of type `T` is even.

## Examples
```jldoctest
julia> NumberEven{Float64}(4.0)
4.0

julia> NumberEven{Float64}(5.0)
ERROR: ConstraintError: constraints of type NumberEven violated.
Wrong value: 5.0 must be even.
[...]
```
"""
struct NumberEven{T<:Number} <: BoundNumber{T}
    value::T

    function NumberEven{T}(x::Number) where {T<:Number}
        !iseven(x) && throw(ConstraintError{NumberEven}("$x must be even."))
        return new{T}(x)
    end
end

"""
    NumberInterval{T<:Number,A,L,R,B} <: BoundNumber{T}
    NumberInterval{T,A,L,R,B}(x::Number)

A numeric constraint for a value `x` of type `T` which belongs to an interval between `A` and `B`.
Parameters `L` and `R` are the comparison functions e.g `<` or `<=` which determine whether interval boundaries are included.

## Examples
```jldoctest
julia> NumberInterval{Float64,5,<,<=,10}(7.0)
7.0

julia> NumberInterval{Float64,5,<,<=,10}(10.0)
10.0

julia> NumberInterval{Float64,5,<,<=,10}(15.0)
ERROR: ConstraintError: constraints of type NumberInterval violated.
Wrong value: 15.0 must be in interval between 5 and 10.
[...]
```
"""
struct NumberInterval{T<:Number,A,L,R,B} <: BoundNumber{T}
    value::T

    function NumberInterval{T,A,L,R,B}(x::Number) where {T<:Number,A,L,R,B}
        !(A <= B) && throw(ArgumentError("Wrong interval: A = $A must be less or equal than B = $B."))
        !L(zero(x), one(x)) && throw(ArgumentError("Wrong left comparison function: $L must be one of '<' or '<='."))
        !R(zero(x), one(x)) && throw(ArgumentError("Wrong right comparison function: $R must be one of '<' or '<='."))
        (!L(A, x) || !R(x, B)) && throw(ConstraintError{NumberInterval}("$x must be in interval between $A and $B."))
        return new{T,A,L,R,B}(x)
    end
end
