# bound_string/bound_string

"""
    BoundString{T<:AbstractString} <: AbstractString

Abstract type for string constraints.
"""
abstract type BoundString{T<:AbstractString} <: AbstractString end

bound_type(::Type{<:BoundString{T}}) where {T<:AbstractString} = T
bound_type(::Type{<:BoundString{T}}) where {T<:BoundString} = bound_type(T)
bound_type(x::BoundString) = bound_type(typeof(x))

bound_value(x::BoundString) = x.value
bound_value(x::BoundString{T}) where {T<:BoundString} = bound_value(x.value)

Base.convert(::Type{T}, x::BoundString) where {T<:AbstractString} = T(bound_value(x))

Base.ncodeunits(x::BoundString) = ncodeunits(bound_value(x))
Base.isvalid(x::BoundString, i::Integer) = isvalid(bound_value(x), i)
Base.iterate(x::BoundString, i::Integer = firstindex(bound_value(x))) = iterate(bound_value(x), i)
Base.codeunit(x::BoundString) = codeunit(bound_value(x))
Base.codeunit(x::BoundString, i::Integer) = codeunit(bound_value(x), i)

function Base.print(io::IO, x::BoundString)
    print(io, bound_value(x))
end

function Base.show(io::IO, x::BoundString)
    show(io, bound_value(x))
end

include("string_types.jl")
