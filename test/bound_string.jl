# test/strings

@testset verbose = true "BoundString" begin
    @testset "Case №1: StringLowerCase constructor" begin
        @test StringLowerCase{String}("abcdef")      == "abcdef"
        @test StringLowerCase{String}("a.b/c#d_e f") == "a.b/c#d_e f"
        @test StringLowerCase{String}("a1b2c3d4e5f") == "a1b2c3d4e5f"

        @test StringLowerCase{String}(Vector{UInt8}("abcdef"))      == "abcdef"
        @test StringLowerCase{String}(Vector{UInt8}("a.b/c#d_e f")) == "a.b/c#d_e f"
        @test StringLowerCase{String}(Vector{UInt8}("a1b2c3d4e5f")) == "a1b2c3d4e5f"

        @test_throws ConstraintError{<:StringLowerCase} StringLowerCase{String}("abcdEf")
        @test_throws ConstraintError{<:StringLowerCase} StringLowerCase{String}("./-_A")
        @test_throws ConstraintError{<:StringLowerCase} StringLowerCase{String}("123Q456")
    end

    @testset "Case №2: StringUpperCase constructor" begin
        @test StringUpperCase{String}("ABCDEF")      == "ABCDEF"
        @test StringUpperCase{String}("A.B/C#D_E F") == "A.B/C#D_E F"
        @test StringUpperCase{String}("A1B2C3D4E5F") == "A1B2C3D4E5F"

        @test StringUpperCase{String}(Vector{UInt8}("ABCDEF"))      == "ABCDEF"
        @test StringUpperCase{String}(Vector{UInt8}("A.B/C#D_E F")) == "A.B/C#D_E F"
        @test StringUpperCase{String}(Vector{UInt8}("A1B2C3D4E5F")) == "A1B2C3D4E5F"

        @test_throws ConstraintError{<:StringUpperCase} StringUpperCase{String}("ABCDeF")
        @test_throws ConstraintError{<:StringUpperCase} StringUpperCase{String}("./-_a")
        @test_throws ConstraintError{<:StringUpperCase} StringUpperCase{String}("123q456")
    end

    @testset "Case №3: StringMinLength constructor" begin
        @test StringMinLength{String,4}("abcdef")       == "abcdef"
        @test StringMinLength{String,8}("a.b/c#d_e f")  == "a.b/c#d_e f"
        @test StringMinLength{String,11}("a1b2c3d4e5f") == "a1b2c3d4e5f"

        @test StringMinLength{String,4}(Vector{UInt8}("abcdef"))       == "abcdef"
        @test StringMinLength{String,8}(Vector{UInt8}("a.b/c#d_e f"))  == "a.b/c#d_e f"
        @test StringMinLength{String,11}(Vector{UInt8}("a1b2c3d4e5f")) == "a1b2c3d4e5f"

        @test_throws ConstraintError{<:StringMinLength} StringMinLength{String,10}("ABCDeF")
        @test_throws ConstraintError{<:StringMinLength} StringMinLength{String,10}("./-_a")
        @test_throws ConstraintError{<:StringMinLength} StringMinLength{String,10}("123q456")
    end

    @testset "Case №4: StringMaxLength constructor" begin
        @test StringMaxLength{String,10}("abcdef")      == "abcdef"
        @test StringMaxLength{String,15}("a.b/c#d_e f") == "a.b/c#d_e f"
        @test StringMaxLength{String,11}("a1b2c3d4e5f") == "a1b2c3d4e5f"

        @test StringMaxLength{String,10}(Vector{UInt8}("abcdef"))      == "abcdef"
        @test StringMaxLength{String,15}(Vector{UInt8}("a.b/c#d_e f")) == "a.b/c#d_e f"
        @test StringMaxLength{String,11}(Vector{UInt8}("a1b2c3d4e5f")) == "a1b2c3d4e5f"

        @test_throws ConstraintError{<:StringMaxLength} StringMaxLength{String,3}("ABCDeF")
        @test_throws ConstraintError{<:StringMaxLength} StringMaxLength{String,3}("./-_a")
        @test_throws ConstraintError{<:StringMaxLength} StringMaxLength{String,3}("123q456")
    end

    @testset "Case №5: StringFixedLength constructor" begin
        @test StringFixedLength{String,6}("abcdef")       == "abcdef"
        @test StringFixedLength{String,11}("a.b/c#d_e f") == "a.b/c#d_e f"
        @test StringFixedLength{String,11}("a1b2c3d4e5f") == "a1b2c3d4e5f"

        @test StringFixedLength{String,6}(Vector{UInt8}("abcdef"))       == "abcdef"
        @test StringFixedLength{String,11}(Vector{UInt8}("a.b/c#d_e f")) == "a.b/c#d_e f"
        @test StringFixedLength{String,11}(Vector{UInt8}("a1b2c3d4e5f")) == "a1b2c3d4e5f"

        @test_throws ConstraintError{<:StringFixedLength} StringFixedLength{String,2}("ABCDeF")
        @test_throws ConstraintError{<:StringFixedLength} StringFixedLength{String,3}("./-_a")
        @test_throws ConstraintError{<:StringFixedLength} StringFixedLength{String,20}("123q456")
    end

    @testset "Case №6: StringPattern constructor" begin
        @test StringPattern{String,pattern"^[a-z]+$"}("abcdef")        == "abcdef"
        @test StringPattern{String,pattern"^[A-Z]+$"}("ABCDEF")        == "ABCDEF"
        @test StringPattern{String,pattern"^[a-z\d]+$"}("a1b2c3d4e5f") == "a1b2c3d4e5f"

        @test StringPattern{String,pattern"^[a-z]+$"}(Vector{UInt8}("abcdef"))        == "abcdef"
        @test StringPattern{String,pattern"^[A-Z]+$"}(Vector{UInt8}("ABCDEF"))        == "ABCDEF"
        @test StringPattern{String,pattern"^[a-z\d]+$"}(Vector{UInt8}("a1b2c3d4e5f")) == "a1b2c3d4e5f"

        @test_throws ConstraintError{<:StringPattern} StringPattern{String,pattern"^[a-z]+$"}("ab234def")
        @test_throws ConstraintError{<:StringPattern} StringPattern{String,pattern"^[A-Z]+$"}("A!BC2D_EF")
        @test_throws ConstraintError{<:StringPattern} StringPattern{String,pattern"^[a-z\d]+$"}("_a1b2c3d4e5f_")
    end

    @testset "Case №7: Nesting tests constructor" begin
        @test StringLowerCase{StringMaxLength{String,5}}("abc") == "abc"

        @test_throws ConstraintError{<:StringMaxLength} StringLowerCase{StringMaxLength{String,5}}("abcdef")
        @test_throws ConstraintError{<:StringLowerCase} StringLowerCase{StringMaxLength{String,5}}("aBc")

        @test StringUpperCase{StringMinLength{String,5}}("ABCDEF") == "ABCDEF"

        @test_throws ConstraintError{<:StringMinLength} StringUpperCase{StringMinLength{String,5}}("ABC")
        @test_throws ConstraintError{<:StringUpperCase} StringUpperCase{StringMinLength{String,5}}("AbC")

        @test StringFixedLength{StringPattern{String,pattern"^[a-z]+$"},5}("abcde") == "abcde"

        @test_throws ConstraintError{<:StringPattern} StringFixedLength{StringPattern{String,pattern"^[a-z]+$"},5}("ab1de")
        @test_throws ConstraintError{<:StringFixedLength} StringFixedLength{StringPattern{String,pattern"^[a-z]+$"},5}("abcdef")
    end

    @testset "Case №8: Custom constructor" begin
        @test StringCustomBound{String,x -> x <= "bbb" && length(x) < 5}("aaa") == "aaa"

        @test_throws ConstraintError{<:StringCustomBound} StringCustomBound{String,x -> x <= "bbb" && length(x) < 5}("ccc")
        @test_throws ConstraintError{<:StringCustomBound} StringCustomBound{String,x -> x <= "bbb" && length(x) < 5}("aaaaaa")
    end
end
