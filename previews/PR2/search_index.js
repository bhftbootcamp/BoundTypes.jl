var documenterSearchIndex = {"docs":
[{"location":"pages/bound_number/#BoundNumber","page":"BoundNumber","title":"BoundNumber","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"BoundNumber","category":"page"},{"location":"pages/bound_number/#BoundTypes.BoundNumber","page":"BoundNumber","title":"BoundTypes.BoundNumber","text":"BoundNumber{N<:Number} <: Number\n\nAbstract type for number constraints.\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberCustomBound","page":"BoundNumber","title":"NumberCustomBound","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberCustomBound","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberCustomBound","page":"BoundNumber","title":"BoundTypes.NumberCustomBound","text":"NumberCustomBound{T<:Number,B} <: BoundNumber{T}\nNumberCustomBound{T,B}(x::Number)\n\nA number constraint for a value x of type T using custom function B. Function B should only accept object x and return true or false (or throw a custom ConstraintError).\n\nExamples\n\njulia> NumberCustomBound{Float64,x -> x % 2 == 0}(10.0)\n10.0\n\njulia> NumberCustomBound{Float64,x -> x % 2 == 0}(13.0)\nERROR: ConstraintError: constraints of type NumberCustomBound violated.\nWrong value: Custom constraint '#7' violated for value \"13.0\" of type Float64.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberPositive","page":"BoundNumber","title":"NumberPositive","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberPositive","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberPositive","page":"BoundNumber","title":"BoundTypes.NumberPositive","text":"NumberPositive{T<:Number} <: BoundNumber{T}\nNumberPositive{T}(x::Number)\n\nA number constraint that enforces x > 0 for value x of type T.\n\nExamples\n\njulia> NumberPositive{Float64}(10.0)\n10.0\n\njulia> NumberPositive{Float64}(-10.0)\nERROR: ConstraintError: constraints of type NumberPositive violated.\nWrong value: number -10.0 must be a positive (x > 0).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberNegative","page":"BoundNumber","title":"NumberNegative","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberNegative","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberNegative","page":"BoundNumber","title":"BoundTypes.NumberNegative","text":"NumberNegative{T<:Number} <: BoundNumber{T}\nNumberNegative{T}(x::Number)\n\nA number constraint that enforces x < 0 for value x of type T.\n\nExamples\n\njulia> NumberNegative{Float64}(-10.0)\n-10.0\n\njulia> NumberNegative{Float64}(10.0)\nERROR: ConstraintError: constraints of type NumberNegative violated.\nWrong value: 10.0 must be a negative (x < 0).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberNonPositive","page":"BoundNumber","title":"NumberNonPositive","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberNonPositive","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberNonPositive","page":"BoundNumber","title":"BoundTypes.NumberNonPositive","text":"NumberNonPositive{T<:Number} <: BoundNumber{T}\nNumberNonPositive{T}(x::Number)\n\nA number constraint that enforces x ≤ 0 for value x of type T.\n\nExamples\n\njulia> NumberNonPositive{Float64}(-10.0)\n-10.0\n\njulia> NumberNonPositive{Float64}(10.0)\nERROR: ConstraintError: constraints of type NumberNonPositive violated.\nWrong value: number 10.0 must be a negative or zero (x ≤ 0).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberNonNegative","page":"BoundNumber","title":"NumberNonNegative","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberNonNegative","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberNonNegative","page":"BoundNumber","title":"BoundTypes.NumberNonNegative","text":"NumberNonNegative{T<:Number} <: BoundNumber{T}\nNumberNonNegative{T}(x::Number)\n\nA number constraint that enforces x ≥ 0 for value x of type T.\n\nExamples\n\njulia> NumberNonNegative{Float64}(10.0)\n10.0\n\njulia> NumberNonNegative{Float64}(-10.0)\nERROR: ConstraintError: constraints of type NumberNonNegative violated.\nWrong value: -10.0 must be a positive or zero (x ≥ 0).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberGreater","page":"BoundNumber","title":"NumberGreater","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberGreater","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberGreater","page":"BoundNumber","title":"BoundTypes.NumberGreater","text":"NumberGreater{T<:Number,V} <: BoundNumber{T}\nNumberGreater{T,V}(x::Number)\n\nA number constraint that enforces x > V for value x of type T.\n\nExamples\n\njulia> NumberGreater{Float64,10.0}(20.0)\n20.0\n\njulia> NumberGreater{Float64,10.0}(5.0)\nERROR: ConstraintError: constraints of type NumberGreater violated.\nWrong value: 5.0 must be greater than 10.0.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberGreaterOrEqual","page":"BoundNumber","title":"NumberGreaterOrEqual","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberGreaterOrEqual","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberGreaterOrEqual","page":"BoundNumber","title":"BoundTypes.NumberGreaterOrEqual","text":"NumberGreaterOrEqual{T<:Number,V} <: BoundNumber{T}\nNumberGreaterOrEqual{T,V}(x::Number)\n\nA number constraint that enforces x ≥ V for value x of type T.\n\nExamples\n\njulia> NumberGreaterOrEqual{Float64,10.0}(20.0)\n20.0\n\njulia> NumberGreaterOrEqual{Float64,10.0}(5.0)\nERROR: ConstraintError: constraints of type NumberGreaterOrEqual violated.\nWrong value: 5.0 must be greater or equal than 10.0.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberLess","page":"BoundNumber","title":"NumberLess","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberLess","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberLess","page":"BoundNumber","title":"BoundTypes.NumberLess","text":"NumberLess{T<:Number,V} <: BoundNumber{T}\nNumberLess{T,V}(x::Number)\n\nA number constraint that enforces x < V for value x of type T.\n\nExamples\n\njulia> NumberLess{Float64,10.0}(5.0)\n5.0\n\njulia> NumberLess{Float64,10.0}(20.0)\nERROR: ConstraintError: constraints of type NumberLess violated.\nWrong value: 20.0 must be less than 10.0.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberLessOrEqual","page":"BoundNumber","title":"NumberLessOrEqual","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberLessOrEqual","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberLessOrEqual","page":"BoundNumber","title":"BoundTypes.NumberLessOrEqual","text":"NumberLessOrEqual{T<:Number,V} <: BoundNumber{T}\nNumberLessOrEqual{T,V}(x::Number)\n\nA number constraint that enforces x ≤ V for value x of type T.\n\nExamples\n\njulia> NumberLessOrEqual{Float64,10.0}(5.0)\n5.0\n\njulia> NumberLessOrEqual{Float64,10.0}(20.0)\nERROR: ConstraintError: constraints of type NumberLessOrEqual violated.\nWrong value: 20.0 must be less or equal than 10.0.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberOdd","page":"BoundNumber","title":"NumberOdd","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberOdd","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberOdd","page":"BoundNumber","title":"BoundTypes.NumberOdd","text":"NumberOdd{T<:Number} <: BoundNumber{T}\nNumberOdd{T}(x::Number)\n\nA numeric constraint to ensure that the value x of type T is odd.\n\nExamples\n\njulia> NumberOdd{Float64}(5.0)\n5.0\n\njulia> NumberOdd{Float64}(4.0)\nERROR: ConstraintError: constraints of type NumberOdd violated.\nWrong value: 4.0 must be odd.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberEven","page":"BoundNumber","title":"NumberEven","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberEven","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberEven","page":"BoundNumber","title":"BoundTypes.NumberEven","text":"NumberEven{T<:Number} <: BoundNumber{T}\nNumberEven{T}(x::Number)\n\nA numeric constraint to ensure that the value x of type T is even.\n\nExamples\n\njulia> NumberEven{Float64}(4.0)\n4.0\n\njulia> NumberEven{Float64}(5.0)\nERROR: ConstraintError: constraints of type NumberEven violated.\nWrong value: 5.0 must be even.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_number/#NumberInterval","page":"BoundNumber","title":"NumberInterval","text":"","category":"section"},{"location":"pages/bound_number/","page":"BoundNumber","title":"BoundNumber","text":"NumberInterval","category":"page"},{"location":"pages/bound_number/#BoundTypes.NumberInterval","page":"BoundNumber","title":"BoundTypes.NumberInterval","text":"NumberInterval{T<:Number,A,L,R,B} <: BoundNumber{T}\nNumberInterval{T,A,L,R,B}(x::Number)\n\nA numeric constraint for a value x of type T which belongs to an interval between A and B. Parameters L and R are the comparison functions e.g < or <= which determine whether interval boundaries are included.\n\nExamples\n\njulia> NumberInterval{Float64,5,<,<=,10}(7.0)\n7.0\n\njulia> NumberInterval{Float64,5,<,<=,10}(10.0)\n10.0\n\njulia> NumberInterval{Float64,5,<,<=,10}(15.0)\nERROR: ConstraintError: constraints of type NumberInterval violated.\nWrong value: 15.0 must be in interval between 5 and 10.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#BoundTime","page":"BoundTime","title":"BoundTime","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"BoundTime","category":"page"},{"location":"pages/bound_time/#BoundTypes.BoundTime","page":"BoundTime","title":"BoundTypes.BoundTime","text":"BoundTime{T<:TimeType} <: TimeType\n\nAbstract type for time constraints.\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeCustomBound","page":"BoundTime","title":"TimeCustomBound","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeCustomBound","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeCustomBound","page":"BoundTime","title":"BoundTypes.TimeCustomBound","text":"TimeCustomBound{T<:TimeType,B} <: BoundTime{T}\nTimeCustomBound{T,B}(x::TimeType)\n\nA time constraint for a value x of type T using custom function B. Function B should only accept object x and return true or false (or throw a custom ConstraintError).\n\nExamples\n\njulia> using Dates\n\njulia> TimeCustomBound{DateTime,isleapyear}(DateTime(2024))\n2024-01-01T00:00:00\n\njulia> TimeCustomBound{DateTime,isleapyear}(DateTime(2023))\nERROR: ConstraintError: constraints of type TimeCustomBound violated.\nWrong value: Custom constraint 'isleapyear' violated for value \"2023-01-01T00:00:00\" of type DateTime.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeAfter","page":"BoundTime","title":"TimeAfter","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeAfter","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeAfter","page":"BoundTime","title":"BoundTypes.TimeAfter","text":"TimeAfter{T<:TimeType,V} <: BoundTime{T}\nTimeAfter{T,V}(x::TimeType)\n\nA time constraint for a value x of type T which must exceed the time V.\n\nExamples\n\njulia> using Dates\n\njulia> TimeAfter{DateTime,DateTime(2023)}(DateTime(2024))\n2024-01-01T00:00:00\n\njulia> TimeAfter{DateTime,DateTime(2023)}(DateTime(2022))\nERROR: ConstraintError: constraints of type TimeAfter violated.\nWrong value: 2022-01-01T00:00:00 must exceed 2023-01-01T00:00:00.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeAfterNow","page":"BoundTime","title":"TimeAfterNow","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeAfterNow","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeAfterNow","page":"BoundTime","title":"BoundTypes.TimeAfterNow","text":"TimeAfterNow{T<:TimeType} <: BoundTime{T}\nTimeAfterNow{T}(x::TimeType)\n\nA time constraint for a value x of type T which must exceed the current time.\n\nExamples\n\njulia> using Dates\n\njulia> TimeAfterNow{DateTime}(DateTime(2030))\n2030-01-01T00:00:00\n\njulia> TimeAfterNow{DateTime}(DateTime(2020))\nERROR: ConstraintError: constraints of type TimeAfterNow violated.\nWrong value: 2020-01-01T00:00:00 must exceed 2024-05-03T11:25:26.689.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeAfterOrEqual","page":"BoundTime","title":"TimeAfterOrEqual","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeAfterOrEqual","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeAfterOrEqual","page":"BoundTime","title":"BoundTypes.TimeAfterOrEqual","text":"TimeAfterOrEqual{T<:TimeType,V} <: BoundTime{T}\nTimeAfterOrEqual{T,V}(x::TimeType)\n\nA time constraint for a value x of type T which must exceed or be equal to the time V.\n\nExamples\n\njulia> using Dates\n\njulia> TimeAfterOrEqual{DateTime,DateTime(2023)}(DateTime(2024))\n2024-01-01T00:00:00\n\njulia> TimeAfterOrEqual{DateTime,DateTime(2023)}(DateTime(2023))\n2023-01-01T00:00:00\n\njulia> TimeAfterOrEqual{DateTime,DateTime(2023)}(DateTime(2022))\nERROR: ConstraintError: constraints of type TimeAfterOrEqual violated.\nWrong value: 2022-01-01T00:00:00 must exceed or be equal to 2023-01-01T00:00:00.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimePeriodAfterNow","page":"BoundTime","title":"TimePeriodAfterNow","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimePeriodAfterNow","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimePeriodAfterNow","page":"BoundTime","title":"BoundTypes.TimePeriodAfterNow","text":"TimePeriodAfterNow{T<:TimeType,P} <: BoundTime{T}\nTimePeriodAfterNow{T,P}(x::TimeType)\n\nA time constraint for a value x of type T which must exceed the current time during period P.\n\nExamples\n\njulia> using Dates\n\njulia> TimePeriodAfterNow{DateTime,Year(10)}(DateTime(2030))\n2030-01-01T00:00:00\n\njulia> TimePeriodAfterNow{DateTime,Year(10)}(DateTime(2050))\nERROR: ConstraintError: constraints of type TimePeriodAfterNow violated.\nWrong value: 2050-01-01T00:00:00 must be in interval between 2024-05-03T11:29:14 and 2034-05-03T11:29:14.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeBefore","page":"BoundTime","title":"TimeBefore","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeBefore","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeBefore","page":"BoundTime","title":"BoundTypes.TimeBefore","text":"TimeBefore{T<:TimeType,V} <: BoundTime{T}\nTimeBefore{T,V}(x::TimeType)\n\nA time constraint for a value x of type T which must precede the time V.\n\nExamples\n\njulia> using Dates\n\njulia> TimeBefore{DateTime,DateTime(2023)}(DateTime(2022))\n2022-01-01T00:00:00\n\njulia> TimeBefore{DateTime,DateTime(2023)}(DateTime(2024))\nERROR: ConstraintError: constraints of type TimeBefore violated.\nWrong value: 2024-01-01T00:00:00 must precede 2023-01-01T00:00:00.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeBeforeNow","page":"BoundTime","title":"TimeBeforeNow","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeBeforeNow","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeBeforeNow","page":"BoundTime","title":"BoundTypes.TimeBeforeNow","text":"TimeBeforeNow{T<:TimeType} <: BoundTime{T}\nTimeBeforeNow{T}(x::TimeType)\n\nA time constraint for a value x of type T which must precede the current time.\n\nExamples\n\njulia> using Dates\n\njulia> TimeBeforeNow{DateTime}(DateTime(2020))\n2020-01-01T00:00:00\n\njulia> TimeBeforeNow{DateTime}(DateTime(2030))\nERROR: ConstraintError: constraints of type TimeBeforeNow violated.\nWrong value: 2030-01-01T00:00:00 must precede 2024-05-03T11:36:37.848.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeBeforeOrEqual","page":"BoundTime","title":"TimeBeforeOrEqual","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeBeforeOrEqual","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeBeforeOrEqual","page":"BoundTime","title":"BoundTypes.TimeBeforeOrEqual","text":"TimeBeforeOrEqual{T<:TimeType,V} <: BoundTime{T}\nTimeBeforeOrEqual{T,V}(x::TimeType)\n\nA time constraint for a value x of type T which must precede or be equal to the time V.\n\nExamples\n\njulia> using Dates\n\njulia> TimeBeforeOrEqual{DateTime,DateTime(2023)}(DateTime(2022))\n2022-01-01T00:00:00\n\njulia> TimeBeforeOrEqual{DateTime,DateTime(2023)}(DateTime(2023))\n2023-01-01T00:00:00\n\njulia> TimeBeforeOrEqual{DateTime,DateTime(2023)}(DateTime(2024))\nERROR: ConstraintError: constraints of type TimeBeforeOrEqual violated.\nWrong value: 2024-01-01T00:00:00 must precede or be equal to 2023-01-01T00:00:00.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimePeriodBeforeNow","page":"BoundTime","title":"TimePeriodBeforeNow","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimePeriodBeforeNow","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimePeriodBeforeNow","page":"BoundTime","title":"BoundTypes.TimePeriodBeforeNow","text":"TimePeriodBeforeNow{T<:TimeType,P} <: BoundTime{T}\nTimePeriodBeforeNow{T,P}(x::TimeType)\n\nA time constraint for a value x of type T which must precede the current time during period P.\n\nExamples\n\njulia> using Dates\n\njulia> TimePeriodBeforeNow{DateTime,Year(10)}(DateTime(2020))\n2020-01-01T00:00:00\n\njulia> TimePeriodBeforeNow{DateTime,Year(10)}(DateTime(2030))\nERROR: ConstraintError: constraints of type TimePeriodBeforeNow violated.\nWrong value: 2030-01-01T00:00:00 must be in interval between 2014-05-03T11:38:35.124 and 2024-05-03T11:38:35.124.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_time/#TimeInterval","page":"BoundTime","title":"TimeInterval","text":"","category":"section"},{"location":"pages/bound_time/","page":"BoundTime","title":"BoundTime","text":"TimeInterval","category":"page"},{"location":"pages/bound_time/#BoundTypes.TimeInterval","page":"BoundTime","title":"BoundTypes.TimeInterval","text":"TimeInterval{T<:TimeType,A,L,R,B} <: BoundTime{T}\nTimeInterval{T,A,L,R,B}(x::TimeType)\n\nA time constraint for a value x of type T which belongs to an interval between times A and B. Parameters L and R are the comparison functions e.g < or <= which determine whether interval boundaries are included.\n\nExamples\n\njulia> using Dates\n\njulia> TimeInterval{DateTime,DateTime(2023),<,<,DateTime(2025)}(DateTime(2024))\n2024-01-01T00:00:00\n\njulia> TimeInterval{DateTime,DateTime(2023),<,<=,DateTime(2025)}(DateTime(2025))\n2025-01-01T00:00:00\n\njulia> TimeInterval{DateTime,DateTime(2023),<,<,DateTime(2025)}(DateTime(2025))\nERROR: ConstraintError: constraints of type TimeInterval violated.\nWrong value: 2025-01-01T00:00:00 must be in interval between 2023-01-01T00:00:00 and 2025-01-01T00:00:00.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/devs/#For-Developers","page":"For Developers","title":"For Developers","text":"","category":"section"},{"location":"pages/devs/#Define-custom-bound-type","page":"For Developers","title":"Define custom bound type","text":"","category":"section"},{"location":"pages/devs/","page":"For Developers","title":"For Developers","text":"A user can define his own boundary types:","category":"page"},{"location":"pages/devs/","page":"For Developers","title":"For Developers","text":"struct SomeBound{T<:ElType} <: SomeExistingBoundType{T}\n    value::T\n\n    function SomeBound{T}(x::AbstractString) where {T<:AbstractString}\n        !condition_1(x) && throw(ConstraintError{SomeBound}(\"Error message 1\"))\n        !condition_2(x) && throw(ConstraintError{SomeBound}(\"Error message 2\"))\n        # other conditions ...\n\n        return new{T}(x)\n    end\nend","category":"page"},{"location":"pages/devs/","page":"For Developers","title":"For Developers","text":"Here are some guidelines for defining your own bound types:","category":"page"},{"location":"pages/devs/","page":"For Developers","title":"For Developers","text":"Names of new boundary types should characterize them (for example NumberPositive, StringUpperCase or TimeInterval).\nThe element type and supertype must correspond to the same data class:\nELTYPE must be a Number, AbstractString or TimeType.\nRespectively BOUNDTYPE might be a BoundNumber, BoundString or BoundTime.\nNext, inside the constructor you need to perform a bounds check:\nFormulate simple and easy to understand checks, i.e. if you want to allow numbers that are greater than 0, then you would have an expression like this x <= 0 && throw(...).\nIf any of the conditions are violated then error ConstraintError should be thrown.","category":"page"},{"location":"pages/devs/#Example","page":"For Developers","title":"Example","text":"","category":"section"},{"location":"pages/devs/","page":"For Developers","title":"For Developers","text":"using BoundTypes\n\nstruct StringValidAddress{T<:AbstractString} <: BoundString{T}\n    value::T\n\n    function StringValidAddress{T}(x::AbstractString) where {T<:AbstractString}\n        length(x) != 40 && throw(\n            ConstraintError{StringFixedLength}(\n                \"length of the \\\"$x\\\" must be equal to 40 characters ($(length(x))).\",\n            ),\n        )\n        isnothing(match(r\"^0x([abcdef0-9])+$\", x)) && throw(\n            ConstraintError{StringPattern}(\n                \"\\\"$x\\\" must match to regex pattern /^0x([abcdef0-9])+\\$./\",\n            ),\n        )\n        return new{T}(x)\n    end\nend","category":"page"},{"location":"pages/devs/","page":"For Developers","title":"For Developers","text":"julia> StringValidAddress{String}(\"0xf343a817e5f5243190d3c52bf347daf876de1d\")\n\"0xf343a817e5f5243190d3c52bf347daf876de1d\"\n\njulia> StringValidAddress{String}(\"0x14__1ylad2g_-as2@>>\")\nWrong value: \"0x14__1ylad2g_-as2@>>\" must match to regex pattern /^0x([abcdef0-9])+$/.","category":"page"},{"location":"pages/utils/#Utils","page":"Utils","title":"Utils","text":"","category":"section"},{"location":"pages/utils/#Getter-functions","page":"Utils","title":"Getter functions","text":"","category":"section"},{"location":"pages/utils/","page":"Utils","title":"Utils","text":"bound_type\nbound_value","category":"page"},{"location":"pages/utils/#BoundTypes.bound_type","page":"Utils","title":"BoundTypes.bound_type","text":"bound_type(x) -> type\n\nReturns the type of the internal object of x.\n\nExamples\n\njulia> bound_type(NumberPositive{Float64}(1.0))\nFloat64\n\njulia> bound_type(NumberLess{NumberGreater{Int64,2},8}(6))\nInt64\n\n\n\n\n\n","category":"function"},{"location":"pages/utils/#BoundTypes.bound_value","page":"Utils","title":"BoundTypes.bound_value","text":"bound_value(x) -> value\n\nGetter function for the underlying value from the bound type object x.\n\nExamples\n\njulia> val = StringFixedLength{String,3}(\"abc\")\n\"abc\"\n\njulia> typeof(val)\nStringFixedLength{String, 3}\n\njulia> inner_val = bound_value(val)\n\"abc\"\n\njulia> typeof(inner_val)\nString\n\n\n\n\n\n","category":"function"},{"location":"pages/utils/#Errors","page":"Utils","title":"Errors","text":"","category":"section"},{"location":"pages/utils/","page":"Utils","title":"Utils","text":"ConstraintError","category":"page"},{"location":"pages/utils/#BoundTypes.ConstraintError","page":"Utils","title":"BoundTypes.ConstraintError","text":"ConstraintError\n\nException thrown when a constraint is violated on bound type creation.\n\nFields\n\nmessage::String: The error message.\n\n\n\n\n\n","category":"type"},{"location":"#BoundTypes.jl","page":"Home","title":"BoundTypes.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The BoundTypes library helps you to seamlessly design and set rules for data types in your code, making it safer and more reliable.","category":"page"},{"location":"#Quickstart","page":"Home","title":"Quickstart","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Here's how you can use BoundTypes to validate Coin information on Ethereum blockchain.","category":"page"},{"location":"","page":"Home","title":"Home","text":"using BoundTypes\n\nstruct CoinInfo\n    asset::StringPattern{String,pattern\"^([A-Z]+)$\"}\n    network::StringMinLength{String,3}\n    address::StringFixedLength{StringPattern{String,pattern\"^0x([abcdef0-9]+)$\"},40}\n    deposit_fee::NumberNonNegative{Float64}\n    withdrawal_fee::NumberPositive{Float64}\nend\n\n# Valid example\nCoinInfo(\"ETH\", \"Ethereum\", \"0xc0ffee254729296a45a3885639ac7e10f9d549\", 0.0, 0.01)\n\n# Invalid example: 'asset' should only contain uppercase letters\nCoinInfo(\"eth!\", \"EM\", \"0xc0FFE12A2\", -1.0, 0.0)","category":"page"},{"location":"pages/bound_string/#BoundString","page":"BoundString","title":"BoundString","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"BoundString","category":"page"},{"location":"pages/bound_string/#BoundTypes.BoundString","page":"BoundString","title":"BoundTypes.BoundString","text":"BoundString{T<:AbstractString} <: AbstractString\n\nAbstract type for string constraints.\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringCustomBound","page":"BoundString","title":"StringCustomBound","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringCustomBound","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringCustomBound","page":"BoundString","title":"BoundTypes.StringCustomBound","text":"StringCustomBound{T<:AbstractString,B} <: BoundString{T}\nStringCustomBound{T,B}(x::AbstractString)\n\nA string constraint for a value x of type T using custom function B. Function B should only accept object x and return true or false (or throw a custom ConstraintError).\n\nExamples\n\njulia> StringCustomBound{String,x -> length(x) > 5}(\"abcdef\")\n\"abcdef\"\n\njulia> StringCustomBound{String,x -> length(x) > 5}(\"abc\")\nERROR: ConstraintError: constraints of type StringCustomBound violated.\nWrong value: Custom constraint '#5' violated for value \"abc\" of type String.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringLowerCase","page":"BoundString","title":"StringLowerCase","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringLowerCase","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringLowerCase","page":"BoundString","title":"BoundTypes.StringLowerCase","text":"StringLowerCase{T<:AbstractString} <: BoundString{T}\nStringLowerCase{T}(x::AbstractString)\n\nA string constraint for a value x of type T which characters must be in lowercase.\n\nExamples\n\njulia> StringLowerCase{String}(\"abcdef\")\n\"abcdef\"\n\njulia> StringLowerCase{String}(\"aBcdEf\")\nERROR: ConstraintError: constraints of type StringLowerCase violated.\nWrong value: some characters of \"aBcdEf\" must be in lowercase (B,E).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringUpperCase","page":"BoundString","title":"StringUpperCase","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringUpperCase","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringUpperCase","page":"BoundString","title":"BoundTypes.StringUpperCase","text":"StringUpperCase{T<:AbstractString} <: BoundString{T}\nStringUpperCase{T}(x::AbstractString)\n\nA string constraint for a value x of type T which characters must be in uppercase.\n\nExamples\n\njulia> StringUpperCase{String}(\"ABCDEF\")\n\"ABCDEF\"\n\njulia> StringUpperCase{String}(\"AbCDeF\")\nERROR: ConstraintError: constraints of type StringUpperCase violated.\nWrong value: some characters of \"AbCDeF\" must be in uppercase (b,e).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringMinLength","page":"BoundString","title":"StringMinLength","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringMinLength","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringMinLength","page":"BoundString","title":"BoundTypes.StringMinLength","text":"StringMinLength{T<:AbstractString,V} <: BoundString{T}\nStringMinLength{T,V}(x::AbstractString)\n\nA string constraint for a value x of type T which length must be at least V characters.\n\nExamples\n\njulia> StringMinLength{String,5}(\"abcdef\")\n\"abcdef\"\n\njulia> StringMinLength{String,5}(\"abc\")\nERROR: ConstraintError: constraints of type StringMinLength violated.\nWrong value: length of the \"abc\" must be at least 5 characters (3).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringMaxLength","page":"BoundString","title":"StringMaxLength","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringMaxLength","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringMaxLength","page":"BoundString","title":"BoundTypes.StringMaxLength","text":"StringMaxLength{T<:AbstractString,V} <: BoundString{T}\nStringMaxLength{T,V}(x::AbstractString)\n\nA string constraint for a value x of type T which length must be no more than V characters.\n\nExamples\n\njulia> StringMaxLength{String,5}(\"abc\")\n\"abc\"\n\njulia> StringMaxLength{String,5}(\"abcdef\")\nERROR: ConstraintError: constraints of type StringMaxLength violated.\nWrong value: length of the \"abcdef\" must be no more than 5 characters (6).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringFixedLength","page":"BoundString","title":"StringFixedLength","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringFixedLength","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringFixedLength","page":"BoundString","title":"BoundTypes.StringFixedLength","text":"StringFixedLength{T<:AbstractString,V} <: BoundString{T}\nStringFixedLength{T,V}(x::AbstractString)\n\nA string constraint for a value x of type T which length must be equal to V characters.\n\nExamples\n\njulia> StringFixedLength{String,5}(\"abcde\")\n\"abcde\"\n\njulia> StringFixedLength{String,5}(\"abc\")\nERROR: ConstraintError: constraints of type StringFixedLength violated.\nWrong value: length of the \"abc\" must be equal to 5 characters (3).\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#StringPattern","page":"BoundString","title":"StringPattern","text":"","category":"section"},{"location":"pages/bound_string/","page":"BoundString","title":"BoundString","text":"StringPattern\n@pattern_str","category":"page"},{"location":"pages/bound_string/#BoundTypes.StringPattern","page":"BoundString","title":"BoundTypes.StringPattern","text":"StringPattern{T<:AbstractString,P} <: BoundString{T}\nStringPattern{T,P}(x::AbstractString)\n\nA string constraint for a value x of type T which must match regex pattern P.\n\nnote: Note\nUse a helper function @pattern_str to pass a regex expression.\n\nExamples\n\njulia> StringPattern{String,pattern\"^[a-zA-Z0-9_]+$\"}(\"abcde\")\n\"abcde\"\n\njulia> StringPattern{String,pattern\"^[a-zA-Z0-9_]+$\"}(\"abc+def\")\nERROR: ConstraintError: constraints of type StringPattern violated.\nWrong value: \"abc+def\" must match to regex pattern /^[a-zA-Z0-9_]+$/.\n[...]\n\n\n\n\n\n","category":"type"},{"location":"pages/bound_string/#BoundTypes.@pattern_str","page":"BoundString","title":"BoundTypes.@pattern_str","text":"@pattern_str -> Symbol\n\nAn auxiliary function that allows you to pass a regex string to StringPattern parameters, turning it into a Symbol.\n\n\n\n\n\n","category":"macro"}]
}
