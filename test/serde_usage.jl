# test/extensions

@testset verbose = true "Serde extension" begin
    struct UserProfile
        username::StringPattern{String,pattern"^[a-zA-Z0-9_]+$"}
        password::StringFixedLength{String,12}
        email::StringPattern{String,pattern"^\S+@\S+\.\S+$"}
        age::NumberPositive{Int64}
        bio::String
        height_in_cm::NumberInterval{Float64,50,<,<,250}
        weight_in_kg::NumberNonNegative{Float64}
        account_creation_date::TimeBeforeNow{DateTime}
        subscription_end_date::TimeAfter{DateTime,DateTime(2024,1,1)}
        is_email_verified::Bool
    end

    function Serde.deser(::Type{<:UserProfile}, ::Type{<:TimeType}, x::String)
        return DateTime(x)
    end

    correct_user_info = """
    {
      "username": "user123_",
      "password": "Abc123!@#Def",
      "email": "user123@example.com",
      "age": 25,
      "bio": "Just a simple bio.",
      "height_in_cm": 175.5,
      "weight_in_kg": 70.0,
      "account_creation_date": "2023-01-15T14:22:00",
      "subscription_end_date": "2030-01-15T00:00:00",
      "is_email_verified": true
    }
    """

    @testset "Case №1: Deserialization" begin
        @test UserProfile(
            "user123_",
            "Abc123!@#Def",
            "user123@example.com",
            25,
            "Just a simple bio.",
            175.5,
            70.0,
            DateTime("2023-01-15T14:22:00"),
            DateTime("2030-01-15T00:00:00"),
            true,
        ) == deser_json(UserProfile, correct_user_info)

        null_bio = """
        {
          "username": "user123_",
          "password": "Abc123!@#Def",
          "email": "user123@example.com",
          "age": 25,
          "bio": null,
          "height_in_cm": 175.5,
          "weight_in_kg": 70.0,
          "account_creation_date": "2023-01-15T14:22:00",
          "subscription_end_date": "2030-01-15T00:00:00",
          "is_email_verified": true
        }
        """

        @test_throws Serde.ParamError deser_json(UserProfile, null_bio)

        incorrect_username = """
        {
          "username": "user@@@",
          "password": "Abc123!@#Def",
          "email": "user123@example.com",
          "age": 25,
          "bio": "A bio with special characters in the username.",
          "height_in_cm": 175,
          "weight_in_kg": 70,
          "account_creation_date": "2023-01-15T14:22:00",
          "subscription_end_date": "2024-01-15T00:00:00",
          "is_email_verified": true
        }
        """

        @test_throws ConstraintError{<:StringPattern} deser_json(UserProfile, incorrect_username)

        incorrect_password = """
        {
          "username": "user123_",
          "password": "Short1!",
          "email": "user123@example.com",
          "age": 25,
          "bio": "Password is too short.",
          "height_in_cm": 175,
          "weight_in_kg": 70,
          "account_creation_date": "2023-01-15T14:22:00",
          "subscription_end_date": "2024-01-15T00:00:00",
          "is_email_verified": true
        }
        """

        @test_throws ConstraintError{<:StringFixedLength} deser_json(UserProfile, incorrect_password)

        incorrect_age = """
        {
          "username": "user123_",
          "password": "Abc123!@#Def",
          "email": "user123@example.com",
          "age": -5,
          "bio": "Age cannot be negative.",
          "height_in_cm": 175,
          "weight_in_kg": 70,
          "account_creation_date": "2023-01-15T14:22:00",
          "subscription_end_date": "2024-01-15T00:00:00",
          "is_email_verified": true
        }
        """

        @test_throws ConstraintError{NumberPositive} deser_json(UserProfile, incorrect_age)

        incorrect_height = """
        {
          "username": "user123_",
          "password": "Abc123!@#Def",
          "email": "user123@example.com",
          "age": 25,
          "bio": "Height is too tall.",
          "height_in_cm": 300,
          "weight_in_kg": 70,
          "account_creation_date": "2023-01-15T14:22:00",
          "subscription_end_date": "2024-01-15T00:00:00",
          "is_email_verified": true
        }
        """

        @test_throws ConstraintError{NumberInterval} deser_json(UserProfile, incorrect_height)

        incorrect_sub_date = """
        {
          "username": "user123_",
          "password": "Abc123!@#Def",
          "email": "user123@example.com",
          "age": 25,
          "bio": "Subscription end date is in the past.",
          "height_in_cm": 175,
          "weight_in_kg": 70,
          "account_creation_date": "2023-01-15T14:22:00",
          "subscription_end_date": "2023-01-01T00:00:00",
          "is_email_verified": true
        }
        """

        @test_throws ConstraintError{TimeAfter} deser_json(UserProfile, incorrect_sub_date)
    end

    @testset "Case №2: Serialization" begin

        user = deser_json(UserProfile, correct_user_info)

        @test to_json(user) ==
        """
        {\
        "username":"user123_",\
        "password":"Abc123!@#Def",\
        "email":"user123@example.com",\
        "age":25,\
        "bio":"Just a simple bio.",\
        "height_in_cm":175.5,\
        "weight_in_kg":70.0,\
        "account_creation_date":"2023-01-15T14:22:00",\
        "subscription_end_date":"2030-01-15T00:00:00",\
        "is_email_verified":true\
        }\
        """

        @test to_csv([user]) == """
        account_creation_date,age,bio,email,height_in_cm,is_email_verified,password,subscription_end_date,username,weight_in_kg
        2023-01-15T14:22:00,25,Just a simple bio.,user123@example.com,175.5,true,Abc123!@#Def,2030-01-15T00:00:00,user123_,70.0
        """

        @test to_query(user) == """
        username=user123_&\
        password=Abc123%21%40%23Def&\
        email=user123%40example.com&\
        age=25&\
        bio=Just%20a%20simple%20bio.&\
        height_in_cm=175.5&\
        weight_in_kg=70.0&\
        account_creation_date=2023-01-15T14%3A22%3A00&\
        subscription_end_date=2030-01-15T00%3A00%3A00&\
        is_email_verified=true\
        """

        @test to_toml(user) == """
        username = \"user123_\"
        password = \"Abc123!@#Def\"
        email = \"user123@example.com\"
        age = 25
        bio = \"Just a simple bio.\"
        height_in_cm = 175.5
        weight_in_kg = 70.0
        account_creation_date = \"2023-01-15T14:22:00\"
        subscription_end_date = \"2030-01-15T00:00:00\"
        is_email_verified = true
        """

        @test to_xml(user) == """
        <xml username=\"user123_\" \
        password=\"Abc123!@#Def\" \
        email=\"user123@example.com\" \
        age=\"25\" \
        bio=\"Just a simple bio.\" \
        height_in_cm=\"175.5\" \
        weight_in_kg=\"70.0\" \
        account_creation_date=\"2023-01-15T14:22:00\" \
        subscription_end_date=\"2030-01-15T00:00:00\" \
        is_email_verified=\"true\"/>
        """
    end

    @testset "Case №3: Nested boundbypes deserialization" begin
      struct StringAndFloat
          a::StringMaxLength{StringMinLength{StringLowerCase{String},10},20}
          b::Float64
      end
      
      obj = StringAndFloat("1234567890a", 1)
      
      json  = "{\"a\":\"1234567890a\",\"b\":1.0}"
      toml  = "a = \"1234567890a\"\nb = 1.0\n"
      csv   = "a,b\n1234567890a,1.0\n"
      query = "a=1234567890a&b=1.0"
      xml   = "<xml a=\"1234567890a\" b=\"1.0\"/>\n"
      yaml  = "a: \"1234567890a\"\nb: 1.0\n"
      
      @test to_json(obj)  == json
      @test to_toml(obj)  == toml
      @test to_csv([obj]) == csv
      @test to_query(obj) == query
      @test to_xml(obj)   == xml
      @test to_yaml(obj)  == yaml
      
      @test Serde.deser_json(StringAndFloat, json)   == obj
      @test Serde.deser_toml(StringAndFloat, toml)   == obj
      @test Serde.deser_csv(StringAndFloat, csv)[1]  == obj
      @test Serde.deser_query(StringAndFloat, query) == obj
      @test Serde.deser_xml(StringAndFloat, xml)     == obj
      @test Serde.deser_yaml(StringAndFloat, yaml)   == obj
      
      struct StringAndNumber
          a::StringMaxLength{StringMinLength{StringLowerCase{String},10},20}
          b::NumberPositive{Float64}
      end
      
      obj = StringAndNumber("1234567890a", 1)
      
      json  = "{\"a\":\"1234567890a\",\"b\":1.0}"
      toml  = "a = \"1234567890a\"\nb = 1.0\n"
      csv   = "a,b\n1234567890a,1.0\n"
      query = "a=1234567890a&b=1.0"
      xml   = "<xml a=\"1234567890a\" b=\"1.0\"/>\n"
      yaml  = "a: \"1234567890a\"\nb: 1.0\n"
      
      @test to_json(obj)  == json
      @test to_toml(obj)  == toml
      @test to_csv([obj]) == csv
      @test to_query(obj) == query
      @test to_xml(obj)   == xml
      @test to_yaml(obj)  == yaml
      
      @test Serde.deser_json(StringAndNumber, json)   == obj
      @test Serde.deser_toml(StringAndNumber, toml)   == obj
      @test Serde.deser_csv(StringAndNumber, csv)[1]  == obj
      @test Serde.deser_query(StringAndNumber, query) == obj
      @test Serde.deser_xml(StringAndNumber, xml)     == obj
      @test Serde.deser_yaml(StringAndNumber, yaml)   == obj
      
      struct StringsAndNumber
          a::StringMaxLength{StringMinLength{StringLowerCase{String},10},20}
          b::StringMinLength{String,5}
          c::NumberPositive{Float64}
      end
      
      obj = StringsAndNumber("1234567890a", "asdfdasf", 1.0)
      
      json  = "{\"a\":\"1234567890a\",\"b\":\"asdfdasf\",\"c\":1.0}"
      toml  = "a = \"1234567890a\"\nb = \"asdfdasf\"\nc = 1.0\n"
      csv   = "a,b,c\n1234567890a,asdfdasf,1.0\n"
      query = "a=1234567890a&b=asdfdasf&c=1.0"
      xml   = "<xml a=\"1234567890a\" b=\"asdfdasf\" c=\"1.0\"/>\n"
      yaml  = "a: \"1234567890a\"\nb: \"asdfdasf\"\nc: 1.0\n"
      
      @test to_json(obj)  == json
      @test to_toml(obj)  == toml
      @test to_csv([obj]) == csv
      @test to_query(obj) == query
      @test to_xml(obj)   == xml
      @test to_yaml(obj)  == yaml
      
      @test Serde.deser_json(StringsAndNumber, json)   == obj
      @test Serde.deser_toml(StringsAndNumber, toml)   == obj
      @test Serde.deser_csv(StringsAndNumber, csv)[1]  == obj
      @test Serde.deser_query(StringsAndNumber, query) == obj
      @test Serde.deser_xml(StringsAndNumber, xml)     == obj
      @test Serde.deser_yaml(StringsAndNumber, yaml)   == obj
      
      struct TwoStrings
          a::StringMaxLength{StringMinLength{StringLowerCase{String},10},20}
          b::StringMinLength{String,5}
      end
      
      obj = TwoStrings("1234567890a", "asdfdasf")
      
      json  = "{\"a\":\"1234567890a\",\"b\":\"asdfdasf\"}"
      toml  = "a = \"1234567890a\"\nb = \"asdfdasf\"\n"
      csv   = "a,b\n1234567890a,asdfdasf\n"
      query = "a=1234567890a&b=asdfdasf"
      xml   = "<xml a=\"1234567890a\" b=\"asdfdasf\"/>\n"
      yaml  = "a: \"1234567890a\"\nb: \"asdfdasf\"\n"
      
      @test to_json(obj)  == json
      @test to_toml(obj)  == toml
      @test to_csv([obj]) == csv
      @test to_query(obj) == query
      @test to_xml(obj)   == xml
      @test to_yaml(obj)  == yaml
      
      @test Serde.deser_json(TwoStrings, json)   == obj
      @test Serde.deser_toml(TwoStrings, toml)   == obj
      @test Serde.deser_csv(TwoStrings, csv)[1]  == obj
      @test Serde.deser_query(TwoStrings, query) == obj
      @test Serde.deser_xml(TwoStrings, xml)     == obj
      @test Serde.deser_yaml(TwoStrings, yaml)   == obj

      struct BasicTimeTypes
          a::TimeAfter{Time,Time(10)}
          b::TimeBefore{TimeAfter{Date,Date(2020)},Date(2025)}
          c::TimeInterval{DateTime,DateTime(2020),<,<,DateTime(2025)}
      end
      
      Serde.deser(::Type{BasicTimeTypes}, ::Type{Time}, x::String) = Time(x)
      Serde.deser(::Type{BasicTimeTypes}, ::Type{Date}, x::String) = Date(x)
      Serde.deser(::Type{BasicTimeTypes}, ::Type{DateTime}, x::String) = DateTime(x)
      
      function Serde.deser(::Type{BasicTimeTypes}, ::Type{T}, x::String) where {T<:BoundTime}
          return T(Serde.deser(BasicTimeTypes, bound_type(T), x))
      end
      
      obj = BasicTimeTypes(Time(15), Date(2023), DateTime(2024))
      
      json  = "{\"a\":\"15:00:00\",\"b\":\"2023-01-01\",\"c\":\"2024-01-01T00:00:00\"}"
      toml  = "a = \"15:00:00\"\nb = \"2023-01-01\"\nc = \"2024-01-01T00:00:00\"\n"
      csv   = "a,b,c\n15:00:00,2023-01-01,2024-01-01T00:00:00\n"
      query = "a=15%3A00%3A00&b=2023-01-01&c=2024-01-01T00%3A00%3A00"
      xml   = "<xml a=\"15:00:00\" b=\"2023-01-01\" c=\"2024-01-01T00:00:00\"/>\n"
      yaml  = "a: \"15:00:00\"\nb: \"2023-01-01\"\nc: \"2024-01-01T00:00:00\"\n"
      
      @test to_json(obj)  == json
      @test to_toml(obj)  == toml
      @test to_csv([obj]) == csv
      @test to_query(obj) == query
      @test to_xml(obj)   == xml
      @test to_yaml(obj)  == yaml
      
      @test Serde.deser_json(BasicTimeTypes, json)   == obj
      @test Serde.deser_toml(BasicTimeTypes, toml)   == obj
      @test Serde.deser_csv(BasicTimeTypes, csv)[1]  == obj
      @test Serde.deser_query(BasicTimeTypes, query) == obj
      @test Serde.deser_xml(BasicTimeTypes, xml)     == obj
      @test Serde.deser_yaml(BasicTimeTypes, yaml)   == obj
    end
end
