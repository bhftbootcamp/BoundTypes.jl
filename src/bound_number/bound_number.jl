# bound_number/bound_number

"""
    BoundNumber{N<:Number} <: Number

Abstract type for number constraints.
"""
abstract type BoundNumber{N<:Number} <: Number end

bound_type(::Type{<:BoundNumber{T}}) where {T<:Number} = T
bound_type(::Type{<:BoundNumber{T}}) where {T<:BoundNumber} = bound_type(T)
bound_type(x::BoundNumber) = bound_type(typeof(x))

bound_value(x::BoundNumber) = x.value
bound_value(x::BoundNumber{T}) where {T<:BoundNumber} = bound_value(x.value)

Base.eltype(::Type{<:BoundNumber{T}}) where {T} = T
Base.eltype(x::BoundNumber) = eltype(typeof(x))

Base.convert(::Type{T}, x::BoundNumber) where {T<:Number} = T(bound_value(x))

Base.tryparse(::Type{T}, x::String) where {T<:BoundNumber} = convert(T, (tryparse(bound_type(T), x)))

for op in [:+, :-, :/, :*, :^]
    @eval Base.$op(x::BoundNumber, y::BoundNumber) = $op(bound_value(x), bound_value(y))
    @eval Base.$op(x::Number, y::BoundNumber) = $op(x, bound_value(y))
    @eval Base.$op(x::BoundNumber, y::Number) = $op(bound_value(x), y)
end

for op in [:isless, :isequal, :(==)]
    @eval Base.$op(x::BoundNumber, y::BoundNumber) = $op(bound_value(x), bound_value(y))
    @eval Base.$op(x::Number, y::BoundNumber) = $op(x, bound_value(y))
    @eval Base.$op(x::BoundNumber, y::Number) = $op(bound_value(x), y)
end

for op in [:div, :fld, :rem, :mod, :mod1, :atan, :atand]
    @eval Base.$op(x::BoundNumber, y::BoundNumber) = $op(bound_value(x), bound_value(y))
    @eval Base.$op(x::Number, y::BoundNumber) = $op(x, bound_value(y))
    @eval Base.$op(x::BoundNumber, y::Number) = $op(bound_value(x), y)
end

for op in [:isinf, :isnan, :iszero, :isreal, :isempty, :isodd, :iseven, :ispow2]
    @eval Base.$op(x::BoundNumber) = $op(bound_value(x))
end

for op in [:sqrt, :abs, :abs2, :sign, :one, :zero]
    @eval Base.$op(x::BoundNumber) = $op(bound_value(x))
end

for op in [:log, :log2, :log1p, :log10, :exp, :exp2, :rad2deg, :deg2rad]
    @eval Base.$op(x::BoundNumber) = $op(bound_value(x))
end

for op in [:sin, :sinh, :asin, :asinh, :sec, :asec, :sech, :asech, :sinc, :secd, :sind, :asecd, :asind, :sinpi]
    @eval Base.$op(x::BoundNumber) = $op(bound_value(x))
end

for op in [:cos, :cosh, :acos, :acosh, :csc, :acsc, :csch, :acsch, :cosc, :cotd, :cscd, :acosd, :acscd, :cospi]
    @eval Base.$op(x::BoundNumber) = $op(bound_value(x))
end

for op in [:tan, :tanh, :atan, :atanh, :cot, :acot, :coth, :acoth, :atand, :tand, :acotd]
    @eval Base.$op(x::BoundNumber) = $op(bound_value(x))
end

function Base.print(io::IO, x::BoundNumber)
    print(io, bound_value(x))
end

function Base.show(io::IO, x::BoundNumber)
    print(io, bound_value(x))
end

include("number_types.jl")
