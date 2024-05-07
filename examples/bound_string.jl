using BoundTypes

# YES
StringLowerCase{String}("abcdef")
# NO
StringLowerCase{String}("abCDef")

# YES
StringUpperCase{String}("ABCDEF")
# NO
StringUpperCase{String}("ABcdEF")

# YES
StringMinLength{String,5}("abcdef")
# NO
StringMinLength{String,5}("abc")

# YES
StringMaxLength{String,5}("abc")
# NO
StringMaxLength{String,5}("abcdef")

# YES
StringFixedLength{String,5}("abcde")
# NO
StringFixedLength{String,5}("abcdef")
StringFixedLength{String,5}("abc")

# YES
StringPattern{String,pattern"^[a-zA-Z0-9_]+$"}("abcdef")
# NO
StringPattern{String,pattern"^[a-zA-Z0-9_]+$"}("abc.def")

# Nested bounds
# YES
StringLowerCase{StringMinLength{StringMaxLength{String,6},3}}("abcde")
# NO
StringLowerCase{StringMinLength{StringMaxLength{String,6},3}}("abCDef")
StringLowerCase{StringMinLength{StringMaxLength{String,6},3}}("ab")
StringLowerCase{StringMinLength{StringMaxLength{String,6},3}}("abcdefg")
