# bound_string/string_types

"""
    StringCustomBound{T<:AbstractString,B} <: BoundString{T}
    StringCustomBound{T,B}(x::AbstractString)

A string constraint for a value `x` of type `T` using custom function `B`.
Function `B` should only accept object `x` and return `true` or `false` (or throw a custom [`ConstraintError`](@ref)).

## Examples
```julia-repl
julia> StringCustomBound{String,x -> length(x) > 5}("abcdef")
"abcdef"

julia> StringCustomBound{String,x -> length(x) > 5}("abc")
ERROR: ConstraintError: constraints of type StringCustomBound violated.
Wrong value: Custom constraint '#5' violated for value "abc" of type String.
[...]
```
"""
struct StringCustomBound{T<:AbstractString,B} <: BoundString{T}
    value::T

    function StringCustomBound{T,B}(x::AbstractString) where {T<:AbstractString,B}
        !B(x) && throw(ConstraintError{StringCustomBound}("Custom constraint '$B' violated for value \"$x\" of type $T."))
        return new{T,B}(x)
    end

    function StringCustomBound{T,B}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString,B}
        return StringCustomBound{T,B}(String(x))
    end
end

"""
    StringLowerCase{T<:AbstractString} <: BoundString{T}
    StringLowerCase{T}(x::AbstractString)

A string constraint for a value `x` of type `T` which characters must be in lowercase.

## Examples
```jldoctest
julia> StringLowerCase{String}("abcdef")
"abcdef"

julia> StringLowerCase{String}("aBcdEf")
ERROR: ConstraintError: constraints of type StringLowerCase violated.
Wrong value: some caharacters of "aBcdEf" must be in lowercase (B,E).
[...]
```
"""
struct StringLowerCase{T<:AbstractString} <: BoundString{T}
    value::T

    function StringLowerCase{T}(x::AbstractString) where {T<:AbstractString}
        !all(x -> islowercase(x) || !isletter(x), x) && throw(ConstraintError{StringLowerCase}(
            "some caharacters of \"$x\" must be in lowercase ($(join(x[findall(isuppercase, x)], ","))).")
        )
        return new{T}(x)
    end

    function StringLowerCase{T}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString}
        return StringLowerCase{T}(String(x))
    end
end

"""
    StringUpperCase{T<:AbstractString} <: BoundString{T}
    StringUpperCase{T}(x::AbstractString)

A string constraint for a value `x` of type `T` which characters must be in uppercase.

## Examples
```jldoctest
julia> StringUpperCase{String}("ABCDEF")
"ABCDEF"

julia> StringUpperCase{String}("AbCDeF")
ERROR: ConstraintError: constraints of type StringUpperCase violated.
Wrong value: some caharacters of "AbCDeF" must be in upercase (b,e).
[...]
```
"""
struct StringUpperCase{T<:AbstractString} <: BoundString{T}
    value::T

    function StringUpperCase{T}(x::AbstractString) where {T<:AbstractString}
        !all(x -> isuppercase(x) || !isletter(x), x) && throw(ConstraintError{StringUpperCase}(
            "some caharacters of \"$x\" must be in upercase ($(join(x[findall(islowercase, x)], ","))).")
        )
        return new{T}(x)
    end

    function StringUpperCase{T}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString}
        return StringUpperCase{T}(String(x))
    end
end

"""
    StringMinLength{T<:AbstractString,V} <: BoundString{T}
    StringMinLength{T,V}(x::AbstractString)

A string constraint for a value `x` of type `T` which length must be at least `V` characters.

## Examples
```jldoctest
julia> StringMinLength{String,5}("abcdef")
"abcdef"

julia> StringMinLength{String,5}("abc")
ERROR: ConstraintError: constraints of type StringMinLength violated.
Wrong value: length of the "abc" must be at least 5 characters (3).
[...]
```
"""
struct StringMinLength{T<:AbstractString,V} <: BoundString{T}
    value::T

    function StringMinLength{T,V}(x::AbstractString) where {T<:AbstractString,V}
        length(x) < V && throw(ConstraintError{StringMinLength}(
            "length of the \"$x\" must be at least $V characters ($(length(x))).")
        )
        return new{T,V}(x)
    end

    function StringMinLength{T,V}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString,V}
        return StringMinLength{T,V}(String(x))
    end
end

"""
    StringMaxLength{T<:AbstractString,V} <: BoundString{T}
    StringMaxLength{T,V}(x::AbstractString)

A string constraint for a value `x` of type `T` which length must be no more than `V` characters.

## Examples
```jldoctest
julia> StringMaxLength{String,5}("abc")
"abc"

julia> StringMaxLength{String,5}("abcdef")
ERROR: ConstraintError: constraints of type StringMaxLength violated.
Wrong value: length of the "abcdef" must be no more than 5 characters (6).
[...]
```
"""
struct StringMaxLength{T<:AbstractString,V} <: BoundString{T}
    value::T

    function StringMaxLength{T,V}(x::AbstractString) where {T<:AbstractString,V}
        length(x) > V && throw(ConstraintError{StringMaxLength}(
            "length of the \"$x\" must be no more than $V characters ($(length(x))).")
        )
        return new{T,V}(x)
    end

    function StringMaxLength{T,V}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString,V}
        return StringMaxLength{T,V}(String(x))
    end
end

"""
    StringFixedLength{T<:AbstractString,V} <: BoundString{T}
    StringFixedLength{T,V}(x::AbstractString)

A string constraint for a value `x` of type `T` which length must be equal to `V` characters.

## Examples
```jldoctest
julia> StringFixedLength{String,5}("abcde")
"abcde"

julia> StringFixedLength{String,5}("abc")
ERROR: ConstraintError: constraints of type StringFixedLength violated.
Wrong value: length of the "abc" must be equal to 5 characters (3).
[...]
```
"""
struct StringFixedLength{T<:AbstractString,V} <: BoundString{T}
    value::T

    function StringFixedLength{T,V}(x::AbstractString) where {T<:AbstractString,V}
        length(x) != V && throw(ConstraintError{StringFixedLength}(
            "length of the \"$x\" must be equal to $V characters ($(length(x))).")
        )
        return new{T,V}(x)
    end

    function StringFixedLength{T,V}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString,V}
        return StringFixedLength{T,V}(String(x))
    end
end

"""
    @pattern_str -> Symbol

An auxiliary function that allows you to pass a regex string to [`StringPattern`](@ref) parameters, turning it into a Symbol.
"""
macro pattern_str(p)
    esc(:(Symbol($p)))
end

"""
    StringPattern{T<:AbstractString,P} <: BoundString{T}
    StringPattern{T,P}(x::AbstractString)

A string constraint for a value `x` of type `T` which must match regex pattern `P`.

!!! note
    Use a helper function [`@pattern_str`](@ref) to pass a regex expression.

## Examples
```jldoctest
julia> StringPattern{String,pattern"^[a-zA-Z0-9_]+\$"}("abcde")
"abcde"

julia> StringPattern{String,pattern"^[a-zA-Z0-9_]+\$"}("abc+def")
ERROR: ConstraintError: constraints of type StringPattern violated.
Wrong value: "abc+def" must match to regex pattern /^[a-zA-Z0-9_]+\$/.
[...]
```
"""
struct StringPattern{T<:AbstractString,P} <: BoundString{T}
    value::T

    function StringPattern{T,P}(x::AbstractString) where {T<:AbstractString,P}
        isnothing(match(Regex(String(P)), x)) && throw(ConstraintError{StringPattern}(
            "\"$x\" must match to regex pattern /$P/.")
        )
        return new{T,P}(x)
    end

    function StringPattern{T,P}(x::AbstractVector{<:Unsigned}) where {T<:AbstractString,P}
        return StringPattern{T,P}(String(x))
    end
end

function Base.show(io::IO, ::Type{StringPattern{T,P}}) where {T,P}
    print(io, "StringPattern{$T,/$P/}")
end
