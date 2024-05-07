module BoundTypes

export ConstraintError

export BoundNumber,
    NumberCustomBound,
    NumberPositive,
    NumberNonPositive,
    NumberNegative,
    NumberNonNegative,
    NumberGreater,
    NumberGreaterOrEqual,
    NumberLess,
    NumberLessOrEqual,
    NumberOdd,
    NumberEven,
    NumberInterval

export BoundString,
    StringCustomBound,
    StringLowerCase,
    StringUpperCase,
    StringMinLength,
    StringMaxLength,
    StringFixedLength,
    StringPattern

export BoundTime,
    TimeCustomBound,
    TimeAfter,
    TimeAfterNow,
    TimeAfterOrEqual,
    TimePeriodAfterNow,
    TimeBefore,
    TimeBeforeNow,
    TimeBeforeOrEqual,
    TimePeriodBeforeNow,
    TimeInterval

export bound_value,
    bound_type

export @pattern_str

using Dates

"""
    ConstraintError

Exception thrown when a constraint is violated on bound type creation.

## Fields
- `message::String`: The error message.
"""
struct ConstraintError{T} <: Exception
    message::String
end

function Base.showerror(io::IO, exception::ConstraintError{T}) where {T}
    print(io, "ConstraintError: constraints of type $T violated.\n")
    print(io, "Wrong value: $(exception.message)")
end

"""
    bound_value(x) -> value

Getter function for the underlying value from the bound type object `x`.

## Examples

```jldoctest
julia> val = StringFixedLength{String,3}("abc")
"abc"

julia> typeof(val)
StringFixedLength{String, 3}

julia> inner_val = bound_value(val)
"abc"

julia> typeof(inner_val)
String
```
"""
function bound_value end

"""
    bound_type(x) -> type

Returns the type of the internal object of `x`.

## Examples
```jldoctest
julia> bound_type(NumberPositive{Float64}(1.0))
Float64

julia> bound_type(NumberLess{NumberGreater{Int64,2},8}(6))
Int64
```
"""
function bound_type end

include("bound_number/bound_number.jl")
include("bound_string/bound_string.jl")
include("bound_time/bound_time.jl")

end
