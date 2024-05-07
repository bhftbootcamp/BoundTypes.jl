using BoundTypes

# YES
NumberPositive{Float64}(10)
# NO
NumberPositive{Float64}(-10)

# YES
NumberNonPositive{Float64}(-10)
NumberNonPositive{Float64}(0)
# NO
NumberNonPositive{Float64}(10)

# YES
NumberNegative{Float64}(-10)
# NO
NumberNegative{Float64}(10)

# YES
NumberNonNegative{Float64}(10)
NumberNonNegative{Float64}(0)
# NO
NumberNonNegative{Float64}(-10)

# YES
NumberGreater{Float64,10}(20)
# NO
NumberGreater{Float64,10}(5)

# YES
NumberGreaterOrEqual{Float64,10}(20)
NumberGreaterOrEqual{Float64,10}(10)
# NO
NumberGreaterOrEqual{Float64,10}(5)

# YES
NumberLess{Float64,10}(5)
# NO
NumberLess{Float64,10}(20)

# YES
NumberLessOrEqual{Float64,10}(5)
NumberLessOrEqual{Float64,10}(10)
# NO
NumberLessOrEqual{Float64,10}(20)

# YES
NumberInterval{Float64,10,<=,<,20}(10)
NumberInterval{Float64,10,<=,<,20}(15)
# NO
NumberInterval{Float64,10,<=,<,20}(20)
NumberInterval{Float64,10,<=,<,20}(25)

# YES
NumberOdd{Float64}(3)
# NO
NumberOdd{Float64}(4)

# YES
NumberEven{Float64}(4)
# NO
NumberEven{Float64}(5)

# Nested bounds
# YES
NumberPositive{NumberLessOrEqual{NumberOdd{Float64},10}}(7)
# NO
NumberPositive{NumberLessOrEqual{NumberOdd{Float64},10}}(-7)
NumberPositive{NumberLessOrEqual{NumberOdd{Float64},10}}(70)
NumberPositive{NumberLessOrEqual{NumberOdd{Float64},10}}(6)
