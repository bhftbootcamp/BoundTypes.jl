# test/dates

using Test
using Dates
using BoundTypes

@testset verbose = true "BoundTime" begin
    @testset "Case №1: TimeAfterNow constructor" begin
        current_time = now()
        @test TimeAfterNow{Time}(current_time + Minute(1))  == Time(current_time + Minute(1))
        @test TimeAfterNow{Date}(current_time + Day(1))     == Date(current_time + Day(1))
        @test TimeAfterNow{DateTime}(current_time + Day(1)) == DateTime(current_time + Day(1))

        @test_throws ConstraintError TimeAfterNow{Time}(current_time - Minute(1))
        @test_throws ConstraintError TimeAfterNow{Date}(current_time - Day(1))
        @test_throws ConstraintError TimeAfterNow{DateTime}(current_time - Day(1))
    end

    @testset "Case №2: TimeAfter constructor" begin
        @test TimeAfter{Time,Time(12)}(Time(13))                 == Time(13)
        @test TimeAfter{Date,Date(2024)}(Date(2025))             == Date(Date(2025))
        @test TimeAfter{DateTime,DateTime(2024)}(DateTime(2025)) == DateTime(DateTime(2025))

        @test_throws ConstraintError TimeAfter{Time,Time(12)}(Time(11))
        @test_throws ConstraintError TimeAfter{Date,Date(2024)}(Date(2023))
        @test_throws ConstraintError TimeAfter{DateTime,DateTime(2024)}(DateTime(2023))

        @test_throws ConstraintError TimeAfter{Time,Time(12)}(Time(12))
        @test_throws ConstraintError TimeAfter{Date,Date(2024)}(Date(2024))
        @test_throws ConstraintError TimeAfter{DateTime,DateTime(2024)}(DateTime(2024))
    end

    @testset "Case №3: TimeAfterOrEqual constructor" begin
        @test TimeAfterOrEqual{Time,Time(12)}(Time(13))                 == Time(13)
        @test TimeAfterOrEqual{Date,Date(2024)}(Date(2025))             == Date(Date(2025))
        @test TimeAfterOrEqual{DateTime,DateTime(2024)}(DateTime(2025)) == DateTime(DateTime(2025))

        @test TimeAfterOrEqual{Time,Time(12)}(Time(12))                 == Time(12)
        @test TimeAfterOrEqual{Date,Date(2024)}(Date(2024))             == Date(Date(2024))
        @test TimeAfterOrEqual{DateTime,DateTime(2024)}(DateTime(2024)) == DateTime(DateTime(2024))

        @test_throws ConstraintError TimeAfterOrEqual{Time,Time(12)}(Time(11))
        @test_throws ConstraintError TimeAfterOrEqual{Date,Date(2024)}(Date(2023))
        @test_throws ConstraintError TimeAfterOrEqual{DateTime,DateTime(2024)}(DateTime(2023))
    end

    @testset "Case №4: TimePeriodAfterNow constructor" begin
        current_time = now()
        @test TimePeriodAfterNow{Time,Hour(1)}(current_time + Minute(1))  == Time(current_time + Minute(1))
        @test TimePeriodAfterNow{Date,Week(1)}(current_time + Day(1))     == Date(current_time + Day(1))
        @test TimePeriodAfterNow{DateTime,Month(1)}(current_time + Week(1)) == DateTime(current_time + Week(1))

        @test_throws ConstraintError TimePeriodAfterNow{Time,Hour(1)}(current_time - Hour(2))
        @test_throws ConstraintError TimePeriodAfterNow{Date,Week(1)}(current_time - Month(1))
        @test_throws ConstraintError TimePeriodAfterNow{DateTime,Month(1)}(current_time - Year(1))
    end

    @testset "Case №5: TimeBeforeNow constructor" begin
        current_time = now()
        @test TimeBeforeNow{Time}(current_time - Minute(1))  == Time(current_time - Minute(1))
        @test TimeBeforeNow{Date}(current_time - Day(1))     == Date(current_time - Day(1))
        @test TimeBeforeNow{DateTime}(current_time - Day(1)) == DateTime(current_time - Day(1))

        @test_throws ConstraintError TimeBeforeNow{Time}(current_time + Minute(1))
        @test_throws ConstraintError TimeBeforeNow{Date}(current_time + Day(1))
        @test_throws ConstraintError TimeBeforeNow{DateTime}(current_time + Day(1))
    end

    @testset "Case №6: TimeBefore constructor" begin
        @test TimeBefore{Time,Time(12)}(Time(11))                 == Time(11)
        @test TimeBefore{Date,Date(2024)}(Date(2023))             == Date(Date(2023))
        @test TimeBefore{DateTime,DateTime(2024)}(DateTime(2023)) == DateTime(DateTime(2023))

        @test_throws ConstraintError TimeBefore{Time,Time(12)}(Time(13))
        @test_throws ConstraintError TimeBefore{Date,Date(2024)}(Date(2025))
        @test_throws ConstraintError TimeBefore{DateTime,DateTime(2024)}(DateTime(2025))

        @test_throws ConstraintError TimeBefore{Time,Time(12)}(Time(12))
        @test_throws ConstraintError TimeBefore{Date,Date(2024)}(Date(2024))
        @test_throws ConstraintError TimeBefore{DateTime,DateTime(2024)}(DateTime(2024))
    end

    @testset "Case №7: TimeBeforeOrEqual constructor" begin
        @test TimeBeforeOrEqual{Time,Time(12)}(Time(11))                 == Time(11)
        @test TimeBeforeOrEqual{Date,Date(2024)}(Date(2023))             == Date(Date(2023))
        @test TimeBeforeOrEqual{DateTime,DateTime(2024)}(DateTime(2023)) == DateTime(DateTime(2023))

        @test TimeBeforeOrEqual{Time,Time(12)}(Time(12))                 == Time(12)
        @test TimeBeforeOrEqual{Date,Date(2024)}(Date(2024))             == Date(Date(2024))
        @test TimeBeforeOrEqual{DateTime,DateTime(2024)}(DateTime(2024)) == DateTime(DateTime(2024))

        @test_throws ConstraintError TimeBeforeOrEqual{Time,Time(12)}(Time(13))
        @test_throws ConstraintError TimeBeforeOrEqual{Date,Date(2024)}(Date(2025))
        @test_throws ConstraintError TimeBeforeOrEqual{DateTime,DateTime(2024)}(DateTime(2025))
    end

    @testset "Case №8: TimePeriodBeforeNow constructor" begin
        current_time = now()
        @test TimePeriodBeforeNow{Time,Hour(1)}(current_time - Minute(1))    == Time(current_time - Minute(1))
        @test TimePeriodBeforeNow{Date,Week(1)}(current_time - Day(1))       == Date(current_time - Day(1))
        @test TimePeriodBeforeNow{DateTime,Month(1)}(current_time - Week(1)) == DateTime(current_time - Week(1))

        @test_throws ConstraintError TimePeriodBeforeNow{Time,Hour(1)}(current_time + Hour(2))
        @test_throws ConstraintError TimePeriodBeforeNow{Date,Week(1)}(current_time + Month(1))
        @test_throws ConstraintError TimePeriodBeforeNow{DateTime,Month(1)}(current_time + Year(1))
    end

    @testset "Case №9: TimeInterval constructor" begin
        @test TimeInterval{Time,Time(5),<=,<,Time(15)}(Time(10)) == Time(10)
        @test TimeInterval{Time,Time(5),<=,<,Time(15)}(Time(5))  == Time(5)

        @test TimeInterval{Date,Date(2023),<=,<,Date(2025)}(Date(2024)) == Date(2024)
        @test TimeInterval{Date,Date(2023),<=,<,Date(2025)}(Date(2023)) == Date(2023)

        @test TimeInterval{DateTime,DateTime(2023),<=,<,DateTime(2025)}(DateTime(2024)) == DateTime(2024)
        @test TimeInterval{DateTime,DateTime(2023),<=,<,DateTime(2025)}(DateTime(2023)) == DateTime(2023)

        @test_throws ConstraintError TimeInterval{Time,Time(5),<=,<,Time(15)}(Time(15))
        @test_throws ConstraintError TimeInterval{Time,Time(5),<=,<,Time(15)}(Time(1))
        @test_throws ConstraintError TimeInterval{Time,Time(5),<=,<,Time(15)}(Time(20))

        @test_throws ConstraintError TimeInterval{Date,Date(2023),<=,<,Date(2025)}(Date(2025))
        @test_throws ConstraintError TimeInterval{Date,Date(2023),<=,<,Date(2025)}(Date(2020))
        @test_throws ConstraintError TimeInterval{Date,Date(2023),<=,<,Date(2025)}(Date(2030))

        @test_throws ConstraintError TimeInterval{DateTime,DateTime(2023),<=,<,DateTime(2025)}(DateTime(2025))
        @test_throws ConstraintError TimeInterval{DateTime,DateTime(2023),<=,<,DateTime(2025)}(DateTime(2020))
        @test_throws ConstraintError TimeInterval{DateTime,DateTime(2023),<=,<,DateTime(2025)}(DateTime(2030))
    end

    @testset "Case №10: Nested constructor" begin
        @test TimeAfter{TimeBeforeOrEqual{Time,Time(4)},Time(2)}(Time(3)) == Time(3)
        @test TimeAfter{TimeBeforeOrEqual{Time,Time(4)},Time(2)}(Time(4)) == Time(4)

        @test_throws ConstraintError TimeAfter{TimeBeforeOrEqual{Time,Time(4)},Time(2)}(Time(1))
        @test_throws ConstraintError TimeAfter{TimeBeforeOrEqual{Time,Time(4)},Time(2)}(Time(2))
        @test_throws ConstraintError TimeAfter{TimeBeforeOrEqual{Time,Time(4)},Time(2)}(Time(5))

        @test TimeAfterOrEqual{TimeBefore{Time,Time(4)},Time(2)}(Time(3)) == Time(3)
        @test TimeAfterOrEqual{TimeBefore{Time,Time(4)},Time(2)}(Time(2)) == Time(2)

        @test_throws ConstraintError TimeAfterOrEqual{TimeBefore{Time,Time(4)},Time(2)}(Time(1))
        @test_throws ConstraintError TimeAfterOrEqual{TimeBefore{Time,Time(4)},Time(2)}(Time(4))
        @test_throws ConstraintError TimeAfterOrEqual{TimeBefore{Time,Time(4)},Time(2)}(Time(5))
    end

    @testset "Case №11: Custom constructor" begin
        @test TimeCustomBound{Time, x -> x > Time(2) && x <= Time(4)}(Time(3)) == Time(3)
        @test TimeCustomBound{Time, x -> x > Time(2) && x <= Time(4)}(Time(4)) == Time(4)

        @test_throws ConstraintError TimeCustomBound{Time, x -> x > Time(2) && x <= Time(4)}(Time(1))
        @test_throws ConstraintError TimeCustomBound{Time, x -> x > Time(2) && x <= Time(4)}(Time(2))
        @test_throws ConstraintError TimeCustomBound{Time, x -> x > Time(2) && x <= Time(4)}(Time(5))
    end

    @testset "Case №12: Basic methods" begin
        a = TimeAfter{DateTime,DateTime(2024)}(DateTime(2025))
        b = TimeBefore{DateTime,DateTime(2025)}(DateTime(2024))
        c = TimeBefore{DateTime,DateTime(2025)}(DateTime(1, 2, 3, 4, 5, 6, 7))

        @test a == a
        @test a == DateTime(2025)
        @test a != b
        @test a > b
        @test b <= a

        @test a + Year(1) == DateTime(2026)
        @test a - Year(1) == b

        @test year(c)        == 1
        @test month(c)       == 2
        @test day(c)         == 3
        @test hour(c)        == 4
        @test minute(c)      == 5
        @test second(c)      == 6
        @test millisecond(c) == 7

        @test Year(c)        == Year(1)
        @test Month(c)       == Month(2)
        @test Day(c)         == Day(3)
        @test Hour(c)        == Hour(4)
        @test Minute(c)      == Minute(5)
        @test Second(c)      == Second(6)
        @test Millisecond(c) == Millisecond(7)
    end
end
