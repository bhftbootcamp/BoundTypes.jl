# test/numbers

@testset verbose = true "BoundNumber" begin
    @testset "Case №1: NumberPositive constructor" begin
        @test NumberPositive{Float64}(10.0) == 10.0
        @test NumberPositive{Float64}(10)   == 10.0

        @test_throws ConstraintError{<:NumberPositive} NumberPositive{Float64}(-10.0)
        @test_throws ConstraintError{<:NumberPositive} NumberPositive{Float64}(-10)
        @test_throws ConstraintError{<:NumberPositive} NumberPositive{Float64}(0)
    end

    @testset "Case №2: NumberNonPositive constructor" begin
        @test NumberNonPositive{Float64}(-10.0) == -10.0
        @test NumberNonPositive{Float64}(-10)   == -10.0
        @test NumberNonPositive{Float64}(0)     == 0.0

        @test_throws ConstraintError{<:NumberNonPositive} NumberNonPositive{Float64}(10.0)
        @test_throws ConstraintError{<:NumberNonPositive} NumberNonPositive{Float64}(10)
    end

    @testset "Case №3: NumberNegative constructor" begin
        @test NumberNegative{Float64}(-10.0) == -10.0
        @test NumberNegative{Float64}(-10)   == -10.0

        @test_throws ConstraintError{<:NumberNegative} NumberNegative{Float64}(10.0)
        @test_throws ConstraintError{<:NumberNegative} NumberNegative{Float64}(10)
        @test_throws ConstraintError{<:NumberNegative} NumberNegative{Float64}(0)
    end

    @testset "Case №4: NumberNonNegative constructor" begin
        @test NumberNonNegative{Float64}(10.0) == 10.0
        @test NumberNonNegative{Float64}(10)   == 10.0
        @test NumberNonNegative{Float64}(0)    == 0.0

        @test_throws ConstraintError{<:NumberNonNegative} NumberNonNegative{Float64}(-10.0)
        @test_throws ConstraintError{<:NumberNonNegative} NumberNonNegative{Float64}(-10)
    end

    @testset "Case №5: NumberGreater constructor" begin
        @test NumberGreater{Float64,5}(10.0) == 10.0
        @test NumberGreater{Float64,5.0}(10) == 10.0

        @test_throws ConstraintError{<:NumberGreater} NumberGreater{Float64,5}(-10.0)
        @test_throws ConstraintError{<:NumberGreater} NumberGreater{Float64,5}(-10)
        @test_throws ConstraintError{<:NumberGreater} NumberGreater{Float64,5}(5)
    end

    @testset "Case №6: NumberGreaterOrEqual constructor" begin
        @test NumberGreaterOrEqual{Float64,5}(10.0) == 10.0
        @test NumberGreaterOrEqual{Float64,5.0}(10) == 10.0
        @test NumberGreaterOrEqual{Float64,5}(5.0)  == 5.0

        @test_throws ConstraintError{<:NumberGreaterOrEqual} NumberGreaterOrEqual{Float64,5}(-10.0)
        @test_throws ConstraintError{<:NumberGreaterOrEqual} NumberGreaterOrEqual{Float64,5}(-10)
    end

    @testset "Case №7: NumberLess constructor" begin
        @test NumberLess{Float64,5}(-10.0) == -10.0
        @test NumberLess{Float64,5.0}(-10) == -10.0

        @test_throws ConstraintError{<:NumberLess} NumberLess{Float64,5}(10.0)
        @test_throws ConstraintError{<:NumberLess} NumberLess{Float64,5}(10)
        @test_throws ConstraintError{<:NumberLess} NumberLess{Float64,5}(5)
    end

    @testset "Case №8: NumberLessOrEqual constructor" begin
        @test NumberLessOrEqual{Float64,5}(-10.0) == -10.0
        @test NumberLessOrEqual{Float64,5.0}(-10) == -10.0
        @test NumberLessOrEqual{Float64,5}(5.0)   == 5.0

        @test_throws ConstraintError{<:NumberLessOrEqual} NumberLessOrEqual{Float64,5}(10.0)
        @test_throws ConstraintError{<:NumberLessOrEqual} NumberLessOrEqual{Float64,5}(10)
    end

    @testset "Case №9: NumberInterval constructor" begin
        @test NumberInterval{Float64,5,<,<,15}(10.0) == 10.0
        @test NumberInterval{Float64,5,<,<,15}(10)   == 10.0

        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<,15}(5.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<,15}(15)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<,15}(0.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<,15}(20)

        @test NumberInterval{Float64,5,<,<=,15}(10.0) == 10.0
        @test NumberInterval{Float64,5,<,<=,15}(10)   == 10.0
        @test NumberInterval{Float64,5,<,<=,15}(15)   == 15.0

        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<=,15}(5.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<=,15}(0.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<,<=,15}(20)

        @test NumberInterval{Float64,5,<=,<,15}(10.0) == 10.0
        @test NumberInterval{Float64,5,<=,<,15}(10)   == 10.0
        @test NumberInterval{Float64,5,<=,<,15}(5)    == 5.0

        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<=,<,15}(15.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<=,<,15}(0.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<=,<,15}(20)

        @test NumberInterval{Float64,5,<=,<=,15}(10.0) == 10.0
        @test NumberInterval{Float64,5,<=,<=,15}(10)   == 10.0
        @test NumberInterval{Float64,5,<=,<=,15}(5.0)  == 5.0
        @test NumberInterval{Float64,5,<=,<=,15}(15)   == 15.0

        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<=,<=,15}(0.0)
        @test_throws ConstraintError{<:NumberInterval} NumberInterval{Float64,5,<=,<=,15}(20)
    end

    @testset "Case №10: NumberOdd constructor" begin
        @test NumberOdd{Float64}(3.0) == 3.0
        @test NumberOdd{Float64}(9)   == 9.0

        @test_throws ConstraintError{<:NumberOdd} NumberOdd{Float64}(4.0)
        @test_throws ConstraintError{<:NumberOdd} NumberOdd{Float64}(10)
    end

    @testset "Case №11: NumberEven constructor" begin
        @test NumberEven{Float64}(2.0) == 2.0
        @test NumberEven{Float64}(4)   == 4.0

        @test_throws ConstraintError{<:NumberEven} NumberEven{Float64}(3.0)
        @test_throws ConstraintError{<:NumberEven} NumberEven{Float64}(5)
    end

    @testset "Case №12: Nesting constructor" begin
        @test NumberOdd{NumberPositive{NumberLess{Float64,10}}}(7) == 7.0

        @test_throws ConstraintError{<:NumberLess} NumberOdd{NumberPositive{NumberLess{Float64,10}}}(29)
        @test_throws ConstraintError{<:NumberPositive} NumberOdd{NumberPositive{NumberLess{Float64,10}}}(-7)
        @test_throws ConstraintError{<:NumberOdd} NumberOdd{NumberPositive{NumberLess{Float64,10}}}(6)

        @test NumberEven{NumberInterval{Int64,4,<,<,10}}(8) == 8

        @test_throws ConstraintError{<:NumberInterval}  NumberEven{NumberInterval{Int64,4,<,<,10}}(4)
        @test_throws ConstraintError{<:NumberInterval}  NumberEven{NumberInterval{Int64,4,<,<,10}}(10.0)
        @test_throws ConstraintError{<:NumberEven}  NumberEven{NumberInterval{Int64,4,<,<,10}}(9)
    end

    @testset "Case №13: Custom constructor" begin
        @test NumberCustomBound{Float64,x -> x % 2 == 0 && x < 10}(6) == 6.0

        @test_throws ConstraintError{<:NumberCustomBound} NumberCustomBound{Float64,x -> x % 2 == 0 && x < 10}(5)
        @test_throws ConstraintError{<:NumberCustomBound} NumberCustomBound{Float64,x -> x % 2 == 0 && x < 10}(15)

        @test NumberCustomBound{Int64,iseven}(4) == 4

        @test_throws ConstraintError{<:NumberCustomBound} NumberCustomBound{Int64,iseven}(3)
    end

    @testset "Case №14: Basic methods" begin
        a = NumberPositive{Float64}(10.0)
        b = NumberGreater{Float64,0.0}(2.0)

        @test a + a    == 20.0
        @test a + 10.0 == 20.0
        @test a + b    == 12.0

        @test a - a    == 0.0
        @test a - 10.0 == 0.0
        @test a - b    == 8.0

        @test a * a    == 100.0
        @test a * 10.0 == 100.0
        @test a * b    == 20.0

        @test a / a    == 1.0
        @test a / 10.0 == 1.0
        @test a / b    == 5.0

        @test a ^ a    == 10000000000.0
        @test a ^ 10.0 == 10000000000.0
        @test a ^ b    == 100.0

        @test a == a
        @test a == 10.0
        @test a != b
        @test a > b
        @test b <= a

        @test div(a, b)  == 5.0
        @test fld(a, b)  == 5.0
        @test rem(a, b)  == 0.0
        @test mod(a, b)  == 0.0
        @test mod1(a, b) == 2.0

        @test atan(a, b)  == atan(10.0, 2.0)
        @test atand(a, b) == atand(10.0, 2.0)

        @test isinf(a)   == false
        @test isnan(a)   == false
        @test iszero(a)  == false
        @test isreal(a)  == true
        @test isempty(a) == false
        @test isodd(a)   == false
        @test iseven(a)  == true
        @test ispow2(a)  == false

        @test sqrt(a) == sqrt(10.0)
        @test abs(a)  == abs(10.0)
        @test abs2(a) == abs2(10.0)
        @test sign(a) == sign(10.0)
        @test one(a)  == one(10.0)
        @test zero(a) == zero(10.0)

        @test log(a)     == log(10.0)
        @test log2(a)    == log2(10.0)
        @test log1p(a)   == log1p(10.0)
        @test log10(a)   == log10(10.0)
        @test exp(a)     == exp(10.0)
        @test exp2(a)    == exp2(10.0)
        @test rad2deg(a) == rad2deg(10.0)
        @test deg2rad(a) == deg2rad(10.0)
    end
end
