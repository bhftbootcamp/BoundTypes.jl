# bound_time/time_types

"""
    TimeCustomBound{T<:TimeType,B} <: BoundTime{T}
    TimeCustomBound{T,B}(x::TimeType)

A time constraint for a value `x` of type `T` using custom function `B`.
Function `B` should only accept object `x` and return `true` or `false` (or throw a custom [`ConstraintError`](@ref)).

## Examples
```julia-repl
julia> using Dates

julia> TimeCustomBound{DateTime,isleapyear}(DateTime(2024))
2024-01-01T00:00:00

julia> TimeCustomBound{DateTime,isleapyear}(DateTime(2023))
ERROR: ConstraintError: constraints of type TimeCustomBound violated.
Wrong value: Custom constraint 'isleapyear' violated for value "2023-01-01T00:00:00" of type DateTime.
[...]
```
"""
struct TimeCustomBound{T<:TimeType,B} <: BoundTime{T}
    value::T

    function TimeCustomBound{T,B}(x::TimeType) where {T<:TimeType,B}
        !B(x) && throw(ConstraintError{TimeCustomBound}("Custom constraint '$B' violated for value \"$x\" of type $T."))
        return new{T,B}(x)
    end
end

"""
    TimeAfter{T<:TimeType,V} <: BoundTime{T}
    TimeAfter{T,V}(x::TimeType)

A time constraint for a value `x` of type `T` which must exceed the time `V`.

## Examples
```jldoctest
julia> using Dates

julia> TimeAfter{DateTime,DateTime(2023)}(DateTime(2024))
2024-01-01T00:00:00

julia> TimeAfter{DateTime,DateTime(2023)}(DateTime(2022))
ERROR: ConstraintError: constraints of type TimeAfter violated.
Wrong value: 2022-01-01T00:00:00 must exceed 2023-01-01T00:00:00.
[...]
```
"""
struct TimeAfter{T<:TimeType,V} <: BoundTime{T}
    value::T

    function TimeAfter{T,V}(x::TimeType) where {T<:TimeType,V}
        t = convert(typeof(x), V)
        x <= t && throw(ConstraintError{TimeAfter}("$x must exceed $t."))
        return new{T,V}(x)
    end
end

"""
    TimeAfterNow{T<:TimeType} <: BoundTime{T}
    TimeAfterNow{T}(x::TimeType)

A time constraint for a value `x` of type `T` which must exceed the current time.

## Examples
```julia-repl
julia> using Dates

julia> TimeAfterNow{DateTime}(DateTime(2030))
2030-01-01T00:00:00

julia> TimeAfterNow{DateTime}(DateTime(2020))
ERROR: ConstraintError: constraints of type TimeAfterNow violated.
Wrong value: 2020-01-01T00:00:00 must exceed 2024-05-03T11:25:26.689.
[...]
```
"""
struct TimeAfterNow{T<:TimeType} <: BoundTime{T}
    value::T

    function TimeAfterNow{T}(x::TimeType) where {T<:TimeType}
        t = convert(typeof(x), now())
        x <= t && throw(ConstraintError{TimeAfterNow}("$x must exceed $t."))
        return new{T}(x)
    end
end

"""
    TimePeriodAfterNow{T<:TimeType,P} <: BoundTime{T}
    TimePeriodAfterNow{T,P}(x::TimeType)

A time constraint for a value `x` of type `T` which must exceed the current time during period `P`.

## Examples
```julia-repl
julia> using Dates

julia> TimePeriodAfterNow{DateTime,Year(10)}(DateTime(2030))
2030-01-01T00:00:00

julia> TimePeriodAfterNow{DateTime,Year(10)}(DateTime(2050))
ERROR: ConstraintError: constraints of type TimePeriodAfterNow violated.
Wrong value: 2050-01-01T00:00:00 must be in interval between 2024-05-03T11:29:14 and 2034-05-03T11:29:14.
[...]
```
"""
struct TimePeriodAfterNow{T<:TimeType,P} <: BoundTime{T}
    value::T

    function TimePeriodAfterNow{T,P}(x::TimeType) where {T<:TimeType,P}
        t = convert(typeof(x), now())
        (x < t || x > t + P) && throw(ConstraintError{TimePeriodAfterNow}("$x must be in interval between $t and $(t + P)."))
        return new{T,P}(x)
    end
end

"""
    TimeAfterOrEqual{T<:TimeType,V} <: BoundTime{T}
    TimeAfterOrEqual{T,V}(x::TimeType)

A time constraint for a value `x` of type `T` which must exceed or be equal to the time `V`.

## Examples
```jldoctest
julia> using Dates

julia> TimeAfterOrEqual{DateTime,DateTime(2023)}(DateTime(2024))
2024-01-01T00:00:00

julia> TimeAfterOrEqual{DateTime,DateTime(2023)}(DateTime(2023))
2023-01-01T00:00:00

julia> TimeAfterOrEqual{DateTime,DateTime(2023)}(DateTime(2022))
ERROR: ConstraintError: constraints of type TimeAfterOrEqual violated.
Wrong value: 2022-01-01T00:00:00 must exceed or be equal to 2023-01-01T00:00:00.
[...]
```
"""
struct TimeAfterOrEqual{T<:TimeType,V} <: BoundTime{T}
    value::T

    function TimeAfterOrEqual{T,V}(x::TimeType) where {T<:TimeType,V}
        t = convert(typeof(x), V)
        x < t && throw(ConstraintError{TimeAfterOrEqual}("$x must exceed or be equal to $t."))
        return new{T,V}(x)
    end
end

"""
    TimeBefore{T<:TimeType,V} <: BoundTime{T}
    TimeBefore{T,V}(x::TimeType)

A time constraint for a value `x` of type `T` which must precede the time `V`.

## Examples
```jldoctest
julia> using Dates

julia> TimeBefore{DateTime,DateTime(2023)}(DateTime(2022))
2022-01-01T00:00:00

julia> TimeBefore{DateTime,DateTime(2023)}(DateTime(2024))
ERROR: ConstraintError: constraints of type TimeBefore violated.
Wrong value: 2024-01-01T00:00:00 must precede 2023-01-01T00:00:00.
[...]
```
"""
struct TimeBefore{T<:TimeType,V} <: BoundTime{T}
    value::T

    function TimeBefore{T,V}(x::TimeType) where {T<:TimeType,V}
        t = convert(typeof(x), V)
        x >= t && throw(ConstraintError{TimeBefore}("$x must precede $t."))
        return new{T,V}(x)
    end
end

"""
    TimeBeforeNow{T<:TimeType} <: BoundTime{T}
    TimeBeforeNow{T}(x::TimeType)

A time constraint for a value `x` of type `T` which must precede the current time.

## Examples
```julia-repl
julia> using Dates

julia> TimeBeforeNow{DateTime}(DateTime(2020))
2020-01-01T00:00:00

julia> TimeBeforeNow{DateTime}(DateTime(2030))
ERROR: ConstraintError: constraints of type TimeBeforeNow violated.
Wrong value: 2030-01-01T00:00:00 must precede 2024-05-03T11:36:37.848.
[...]
```
"""
struct TimeBeforeNow{T<:TimeType} <: BoundTime{T}
    value::T

    function TimeBeforeNow{T}(x::TimeType) where {T<:TimeType}
        t = convert(typeof(x), now())
        x >= t && throw(ConstraintError{TimeBeforeNow}("$x must precede $t."))
        return new{T}(x)
    end
end

"""
    TimePeriodBeforeNow{T<:TimeType,P} <: BoundTime{T}
    TimePeriodBeforeNow{T,P}(x::TimeType)

A time constraint for a value `x` of type `T` which must precede the current time during period `P`.

## Examples
```julia-repl
julia> using Dates

julia> TimePeriodBeforeNow{DateTime,Year(10)}(DateTime(2020))
2020-01-01T00:00:00

julia> TimePeriodBeforeNow{DateTime,Year(10)}(DateTime(2030))
ERROR: ConstraintError: constraints of type TimePeriodBeforeNow violated.
Wrong value: 2030-01-01T00:00:00 must be in interval between 2014-05-03T11:38:35.124 and 2024-05-03T11:38:35.124.
[...]
```
"""
struct TimePeriodBeforeNow{T<:TimeType,P} <: BoundTime{T}
    value::T

    function TimePeriodBeforeNow{T,P}(x::TimeType) where {T<:TimeType,P}
        t = convert(typeof(x), now())
        (x < t - P || x > t) && throw(ConstraintError{TimePeriodBeforeNow}("$x must be in interval between $(t - P) and $t."))
        return new{T,P}(x)
    end
end

"""
    TimeBeforeOrEqual{T<:TimeType,V} <: BoundTime{T}
    TimeBeforeOrEqual{T,V}(x::TimeType)

A time constraint for a value `x` of type `T` which must precede or be equal to the time `V`.

## Examples
```jldoctest
julia> using Dates

julia> TimeBeforeOrEqual{DateTime,DateTime(2023)}(DateTime(2022))
2022-01-01T00:00:00

julia> TimeBeforeOrEqual{DateTime,DateTime(2023)}(DateTime(2023))
2023-01-01T00:00:00

julia> TimeBeforeOrEqual{DateTime,DateTime(2023)}(DateTime(2024))
ERROR: ConstraintError: constraints of type TimeBeforeOrEqual violated.
Wrong value: 2024-01-01T00:00:00 must precede or be equal to 2023-01-01T00:00:00.
[...]
```
"""
struct TimeBeforeOrEqual{T<:TimeType,V} <: BoundTime{T}
    value::T

    function TimeBeforeOrEqual{T,V}(x::TimeType) where {T<:TimeType,V}
        t = convert(typeof(x), V)
        x > t && throw(ConstraintError{TimeBeforeOrEqual}("$x must precede or be equal to $t."))
        return new{T,V}(x)
    end
end

"""
    TimeInterval{T<:TimeType,A,L,R,B} <: BoundTime{T}
    TimeInterval{T,A,L,R,B}(x::TimeType)

A time constraint for a value `x` of type `T` which belongs to an interval between times `A` and `B`.
Parameters `L` and `R` are the comparison functions e.g `<` or `<=` which determine whether interval boundaries are included.

## Examples
```jldoctest
julia> using Dates

julia> TimeInterval{DateTime,DateTime(2023),<,<,DateTime(2025)}(DateTime(2024))
2024-01-01T00:00:00

julia> TimeInterval{DateTime,DateTime(2023),<,<=,DateTime(2025)}(DateTime(2025))
2025-01-01T00:00:00

julia> TimeInterval{DateTime,DateTime(2023),<,<,DateTime(2025)}(DateTime(2025))
ERROR: ConstraintError: constraints of type TimeInterval violated.
Wrong value: 2025-01-01T00:00:00 must be in interval between 2023-01-01T00:00:00 and 2025-01-01T00:00:00.
[...]
```
"""
struct TimeInterval{T<:TimeType,A,L,R,B} <: BoundTime{T}
    value::T

    function TimeInterval{T,A,L,R,B}(x::TimeType) where {T<:TimeType,A,L,R,B}
        !(A <= B) && throw(ArgumentError("Wrong interval: A = $A must be less or equal than B = $B"))
        !L(DateTime(0), DateTime(1)) && throw(ArgumentError("Wrong left comparison function: $L must be one of '<' or '<='"))
        !R(DateTime(0), DateTime(1)) && throw(ArgumentError("Wrong right comparison function: $R must be one of '<' or '<='"))

        (!L(A, x) || !R(x, B)) && throw(ConstraintError{TimeInterval}("$x must be in interval between $A and $B."))
        return new{T,A,L,R,B}(x)
    end
end
