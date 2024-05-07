using Dates
using Serde
using BoundTypes

mutable struct UserProfile
    # Usernames must consist of alphanumeric characters and underscores.
    username::StringPattern{String,pattern"^[a-zA-Z0-9_]+$"}
    # Passwords are exactly 12 characters long.
    password::StringFixedLength{String,12}
    # Simple pattern for validating email addresses.
    email::StringPattern{String,pattern"^\S+@\S+\.\S+$"}
    # Age must be a positive integer.
    age::NumberPositive{Int64}
    # Biography field.
    bio::String
    # Height in centimeters, bounded between 50 and 250.
    height_in_cm::NumberInterval{Float64,50,<,<,250}
    # Weight in kilograms, must be positive or zero.
    weight_in_kg::NumberNonNegative{Float64}
    # Account creation must be in the past.
    account_creation_date::TimeBeforeNow{DateTime}
    # Subscription must end in the future.
    subscription_end_date::TimeAfter{DateTime,DateTime(2024,1,1)}
end

# Deserialization

function Serde.deser(::Type{<:UserProfile}, ::Type{<:TimeType}, x::String)
    return DateTime(x)
end

valid_user_info = """
{
  "username": "user123_",
  "password": "Abc123!@#Def",
  "email": "user123@example.com",
  "age": 25,
  "bio": "Just a simple bio.",
  "height_in_cm": 175.5,
  "weight_in_kg": 70.0,
  "account_creation_date": "2023-01-15T14:22:00",
  "subscription_end_date": "2030-01-15T00:00:00"
}
"""

valid_user = deser_json(UserProfile, valid_user_info)

invalid_user_info = """
{
  "username": "user123_@@",
  "password": "Abc123!@#Def123",
  "email": "user123_example!com",
  "age": -30,
  "bio": "Just a simple bio.",
  "height_in_cm": 2000.0,
  "weight_in_kg": -100.0,
  "account_creation_date": "2030-01-15T14:22:00",
  "subscription_end_date": "2010-01-15T00:00:00"
}
"""

invalid_user = deser_json(UserProfile, invalid_user_info)

# Serialization

user = UserProfile(
    "user123_",
    "Abc123!@#Def",
    "user123@example.com",
    25,
    "Just a simple bio.",
    175.5,
    70.0,
    DateTime("2023-01-15T14:22:00"),
    DateTime("2030-01-15T00:00:00"),
)

to_json(user)
