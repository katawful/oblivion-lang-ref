# Lexical Conventions
As stated previously, `obl` is a rather loose language. It is completely case and whitespace
insensitive. Indentation and case are completely up to the end developer, though it is recommended
to keep a convention.

## Keywords
The following is a list of language keywords:
language-reference lexical test- check begin and end if they're keywords
- while
- foreach
- loop
- let

Interestingly, other keywords like 'if' can be used as variables. This does not produce runtime
errors. This is limited to constructs found in the vanilla game mostly.

All game functions, block types, and any EditorID are considered as keywords and cannot be used
as variables.

## Text Format
`obl` can only accept printable ASCII characters (i.e. up to byte 127) in any applicable
construct. Additionally, string variables can contain any of the extended ASCII characters.

