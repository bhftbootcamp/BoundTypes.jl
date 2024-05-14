# bound_time/bound_time

"""
    BoundTime{T<:TimeType} <: TimeType

Abstract type for time constraints.
"""
abstract type BoundTime{T<:TimeType} <: TimeType end

bound_type(::Type{<:BoundTime{T}}) where {T<:TimeType} = T
bound_type(::Type{<:BoundTime{T}}) where {T<:BoundTime} = bound_type(T)
bound_type(x::BoundTime) = bound_type(typeof(x))

bound_value(x::BoundTime) = x.value
bound_value(x::BoundTime{T}) where {T<:BoundTime} = bound_value(x.value)

Base.eltype(::Type{<:BoundTime{T}}) where {T} = T
Base.eltype(x::BoundTime) = eltype(typeof(x))

Base.promote_rule(::Type{T1}, ::Type{BoundTime{T2}}) where {T1<:TimeType,T2<:TimeType} = T1
Base.promote_rule(::Type{BoundTime{T1}}, ::Type{T2}) where {T1<:TimeType,T2<:TimeType} = T2

Base.convert(::Type{T}, x::BoundTime) where {T<:BoundTime} = T(bound_value(x))
Base.convert(::Type{T}, x::TimeType) where {T<:BoundTime} = T(x)
Base.convert(::Type{T}, x::BoundTime) where {T<:TimeType} = convert(T, bound_value(x))
Base.convert(::Type{T}, x::BoundTime{T}) where {T<:TimeType} = bound_value(x)
Base.convert(::Type{Time}, x::BoundTime{T}) where {T<:DateTime} = Time(bound_value(x))
Base.convert(::Type{Date}, x::BoundTime{T}) where {T<:DateTime} = Date(bound_value(x))

for op in [:+, :-]
    @eval Base.$op(x::BoundTime, y::Period) = $op(bound_value(x), y)
end

for op in [:isless, :isequal, :(==)]
    @eval Base.$op(x::BoundTime, y::BoundTime) = $op(bound_value(x), bound_value(y))
    @eval Base.$op(x::TimeType, y::BoundTime) = $op(x, bound_value(y))
    @eval Base.$op(x::BoundTime, y::TimeType) = $op(bound_value(x), y)
end

for op in [:year, :month, :week, :day, :hour, :minute, :second, :millisecond, :microsecond, :nanosecond]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:Year, :Quarter, :Month, :Week, :Day, :Hour, :Minute, :Second, :Millisecond, :Microsecond, :Nanosecond]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:yearmonth, :monthday, :yearmonthday]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:dayofyear, :dayofquarter, :quarterofyear]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:dayofmonth, :dayofweek, :dayofweekofmonth, :daysofweekinmonth]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:monthname, :monthabbr, :dayname, :dayabbr]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:firstdayofweek, :firstdayofmonth, :firstdayofquarter, :firstdayofyear]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:lastdayofweek, :lastdayofmonth, :lastdayofquarter, :lastdayofyear]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

for op in [:eps, :daysinmonth, :daysinyear, :isleapyear, :value]
    @eval Dates.$op(x::BoundTime) = $op(bound_value(x))
end

function Base.show(io::IO, x::BoundTime)
    print(io, bound_value(x))
end

include("time_types.jl")
