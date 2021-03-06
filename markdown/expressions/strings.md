# Strings
Like a lot of languages, strings in `obl` are containers that contain characters. They are closest
to the `std::string` type found in C++ in which standard string operations are allowed for normal
use, but also allows easy access to the container operations available. They are overall a
straightforward type.

Strings in `obl` are not a vanilla type, and thus don't interface so cleanly with other types.
Many vanilla functions have a new "EX" (i.e. `MessageEX`) version that can take these strings.

Additionally, like array variables, they are saved to the player's save game unless deleted.

## Notation
Strings are enclosed in double-quotes, and can contain any valid ASCII.

```ebnf
string = '"', ascii, '"';
```

There is no practical limit for the length of a string, but remember the line limit of `obl`.

### Declaration
String variables are declared with `string_var`. Default initialization is 0.

## Differences From Other Language Strings
While `obl` strings are powerful, being a data type that was introduced into the language through
reverse-engineering efforts means there's some notable limitations.

### Initialized Strings are Always Truthy
In `obl`, truthy/falsy is solely determinated by non-zero/zero values respectively. Strings
default initialize to 0 to state that they are truly empty and not just filled with an empty
string. Thus any string with any value will have a non-zero value, and be impossible to actually
compare using the default conditional. [`sv_Compare`](#sv_compare) should be used instead.

### No Byte Size
Most languages allow you to access the byte size of strings, which can be useful when dealing
with encoding. `obl` only supports standard ASCII for strings, and thus ASCII functions should
be used instead.

## Constructing Strings
Strings can be directly defined via a let statement:

```obse
scn StringDefinition
string_var string
begin gamemode
let string := "Adoring Fan"
end
```

However, format specified strings cannot be defined in this manner. `sv_Construct` must be used.
Additionally, as `let` cannot be used in the console, if strings are needed for user INI
settings the set statement should be used.

```obse
scn SVConstruct
string_var string
begin gamemode
set string to sv_Construct "some string: %z", player.GetName
end
```

## Format Specified Strings
Format specified strings are similar to JavaScript template literals and Lua's `string.format`.
They are escaping characters that insert some stringicized value or change the string property of
the object calling said format specifier. There is no formal declaration for making a string of
this type, simply include it wherever you need.

```ebnf
formatSpecifier = '"', {(ascii | specifier)}, '"', {',', (expression)};
```

A format specified string can take up to 20 parameters.

### Format Piping
Some functions required "piped" strings, in which the left hand side of the pipe is the
expression as a string that gets either: gets replaced by the formatted right string, or the
right string is inserted. The exact functionality depends on the function that uses format
piping.

```ebnf
formatPiping = '"', {(ascii | specifier)}, '|', {(ascii | specifier)}, '"', {',', (expression)}
```

```obse
scn FormatPipe
string_var string
begin gamemode
let string := "Adoring Fan"
sv_Replace "Fan|God", string
end
```

The "|" character is restricted from use with a format piped string as there are no escape
characters. "@" can be used when calling a format piped string in the console (say for an INI
file).

### Format Specifiers
The following are a list of format specifiers.

|*Specifier* | *Parameters* | *Function*
|-|-|-|
|`%a` | int | Inserts ASCII character from integer code|
|`%c` | objectID, int | Inserts name of component in other object, see [1](#1)|
|`%g` | int | Inserts result of integer expression, does not numericize|
|`%x.yf` | number | Inserts floating representation of passed number. 'x' and 'y' control number of digits and are optional [2](#2)|
|`%x.ye` | number | Inserts scientific notation of number like `%.f`|
|`%i` | objectID | Inserts formID of passed objectID|
|`%k` | int | Inserts string of name of passed DirectX scan code|
|`%n` | objectID | Inserts name of passed objectID|
|`%v` | int | Inserts name of passed actor value integer code|
|`%x` | int, (int) | Inserts string of the hexadecimal notation of passed integer. Optional int specifies length of notation|
|`%z` | string | Inserts result of string expression, does not stringicize|
|-|-|-|
|`%ps` | objectID | Inserts subjective pronoun of objectID|
|`%pp` | objectID | Inserts possessive pronoun of objectID|
|`%po` | objectID | Inserts objective pronoun of objectID|
|-|-|-|
|`%%` | n/a | Inserts '%' character|
|`%e` | n/a | Inserts empty string|
|`%q` | n/a | Inserts double quote character|
|`%r` | n/a | Inserts newline character|
|-|-|-|
|`%B` | n/a | Sets console output to blue|
|`%b` | n/a | Sets console output to default color|
|`%{...%}` | multi | Optionally inserts what is inside the brackets when this expresses to a truthy value|

###### 1
Only supports 2 object types:
1. Magic Item: Prints name of nth effect item
2. Faction: Prints male rank of nth rank

###### 2
Four additional values can be used alongside integers for 'x' and 'y':
1. `+`: Displays a '+' in front of positive numbers
2. `<Space>`: Leaves leading space in front of positive numbers
3. `-`: Uses left aligned format instead of right
4. `0`: Use '0' instead of spaces for leading zeroes

Examples:

`"% .0f", 12.34 -> " 12"`

`"%+4.3f", 12.34 -> "+12.340"`

## Operators
There are a number of operators that can work on the string type:

|*Operator* | *Type* | *Use* | *Precedence*|
|-|-|-|-|
|`+` | Binary | Concatenation | 9|
|`$` | Unary | Stringicize | 12|
|`[]` | Binary | Subscript | 15|
|`:` | Binary | Slice/Range | 3|
|`#` | Unary | Numericize | 12|

### Concatenation
Concatenation is the combination of 2 strings literally. Thus the concatenation of "Adoring" and
"Fan" is "AdoringFan". Note the lack of whitespace in the new string. `obl` can't always
implicitly convert strings, only functions that explicitly return strings are allowed. The rest
must be stringicized (see below).

```ebnf
concatenation = string, '+', string;
```

```obse
scn concatentation
string_var string
begin gamemode
let string := "Adoring"
Print string + "Fan"
end
```

### Stringicize
The stringicize operator is simply a shorthand for the function `ToString`. It attempts to
convert the expression argument to a string. Numerical expressions convert to the string
representation of the result. Object expressions convert to the object name if possible, else
the formID. Strings are not converted, thus this operator does not run.

```ebnf
stringicize = '$', (expression);
```

```obse
scn stringicize
begin gamemode
print "Player's name is: " + $(PlayerREF)
end
```

### Subscript
As strings are containers, they can be directly subscripted like arrays. The subscripted string
returns a string containing the character.

```ebnf
subscript = variable, '[', [{(expression)}, literal], ']';
```

```obse
scn subscript
string_var string
begin gamemode
let string := "Adoring Fan"
Print "2nd character is: " + string[1]
end
```

### Slice/Range
The slice/range operator allows a specific range of the string container. It can return the
characters over the range, and also be used for iteration.

```ebnf
sliceRange = {literal}, ':', {literal};
```

```obse
scn stringSliceRange
string_var string
string_var iter
begin gamemode
let string := "Adoring Fan"
Print "First 4 characters are: " + string[3:]
; iterate over the last 4 characters
foreach iter <- string[:-4]
; ...
loop
end
```

### Numericize
Numericize takes a string and attempts to convert it to a number. A shorthand for `ToNumber`. It
is assumed that the string is in standard decimal notation. If the string starts with "0x", it
attempts to convert the string as a hexadecimal number. Returns 0 when it fails.

```ebnf
numericize = '#', (expression);
```

```obse
scn Numericize
string_var string
begin gamemode
let string := "1230"
PrintC "%g", (4 + #string)
end
```

## String Functions

### sv_Construct
Returns a new regular or format specified string. Note that this function was used to create and
return generic strings, it is mostly unneeded for this use as let statements can now directly
define strings. It's secondary use is to create strings in user INI files.

Takes up to 20 parameters for format specifiers.

`(null) sv_Construct arg:string, arg1:multi, arg2:multi, ... arg20:multi`

### sv_Destruct
Returns a destroyed string variable or a destroys a list of string variables. String variables
are no longer saved to save game.

`(string_var) sv_Destruct`

`(null) sv_Destruct arg1:string, ... arg20:string`

### sv_Length
Returns the number of characters in a string. Note, not number of bytes like some languages.

`(length:int) sv_Length arg:string`

### sv_Compare
Returns the result of comparing 2 strings of any kind case-insensitively, including format
specified strings. If a format specified string is to be used, it must be the first one.
Optional boolean makes comparison case-sensitive. Returns 1 of 4 possible outcomes:
1. 0: Strings are equal
2. 1: String 2 occurs before string 1 alphabetically
3. -1: String 2 occurs after string 1 alphabetically
4. -2: Comparison failed

`(result:int) sv_Compare string1:string string2:string sensitive:bool`

### sv_Erase
Erases specified number of characters from specified starting position of a string variable. If
number of characters is omitted, all from starting position are erased. If starting position is
also omitted, then starting position is 0 and thus the string is made empty. Note that nothing
is returned, and thus requires a variable to mutate.

`(null) sv_Erase string_var:string start:int numChars:int`

### sv_ToNumeric
Returns the numerical conversion of string. Acceptable non-numerals are:
- `-`: Leading sign
- `e`: Scientific notation
- `.`: Decimal
Conversion to a number halts at the first invalid character. This is not the long hand for the
numericize operator.

`(number:float) sv_ToNumeric arg:string`

### sv_Find
Returns the index of which the matched substring is case insensitively found in a specified
string starting at a specified position. Searches are only included in the range of: `start,
start + searchLength`. An optional boolean searches case sensitively. The substring can be
format specified.

`(index:int) sv_Find subString:string mainString:string start:int searchLength:int
sensitive:bool`

### sv_Count
Returns the number of matched substrings found in the specified string. Functions like
`sv_Find`.

`(count:int) sv_Count subString:string mainString:string start:int searchLength:int`

### sv_Replace
Replaces occurrences found with the left hand side of a format piped string with the right hand
side. Returns the number of replaced instances. Functions like `sv_Find`, and can also specify
the number of replacements.

`(replaced:int) sv_Replace subString:string mainString:string start:int searchLength:int
sensitive:bool replacements:int`

### sv_Insert
Inserts the substring into the specified string at the specified position. The position must be
less than the length of the string. The substring is prepended if no position is provided.

`(null) sv_Insert subString:string mainString:string start:int`

### sv_Split
Returns an array of type array containing substrings of the specified string, in which each
string element is delimited by a specified delimiter character(s). Delimitation happens on each
side of the delimiter character(s). "#This#is#delimited#", when using "#" as the delimiter, is
split into \["This", "is", "delimited"\]. Without the first and last "#" characters, this string
would split into \["is"\].

`(subStrings:array) sv_Split arg:string delimiters:string`

### sv_Percentify
Returns the input string where each "%" is replaced with "%%". This is meant to be used with
format specified strings.

`(string:string) sv_Percentify arg:string`

### sv_ToLower
Returns a string where are characters are in lowercase.

`(lower:string) sv_ToLower arg:string`

### sv_ToUpper
Returns a string where are characters are in uppercase.

`(upper:string) sv_ToUpper arg:string`

### GetKeyName
Returns name of key scan given its DirectInput integer scan code.

`(scan:string) GetKeyName scan:int`

### NumToHex
Returns the hexadecimal notation of an integer as a string. The minimum width from 0 to 8 can be
provided. Unused digits are padded with zeroes. 8 is the default.

`(hex:string) NumToHex num:int width:int`

### ToNumber
Long hand of numericize operator. Returns number associated with string. Optional flag attempts
to convert from hexadecimal notation. Returns 0 if fails.

`(number:float) ToNumber arg:string hex:bool`

## Character Functions
Characters are handled the ASCII integer of the character. There functions are meant to work on
these constructs. Characters from strings can be found using subscripting. This replaces
`sv_GetChar`.

### AsciiToChar
Returns string character of the associated ASCII character code.

`(character:string) AsciiToChar character:int`

### CharToAscii
Returns ASCII code of character string. Only first character is read.

`(character:int) CharToAscii character:string`

### IsDigit
Is character a digit?

`(isDigit:bool) IsDigit character:int`

### IsPunctuation
Is character a punctuation?

`(isPunctuation:bool) IsPunctuation character:int`

### IsUppercase
Is character uppercase?

`(isPunction:bool) IsUppercase character:int`

### IsPrintable
Is character printable?

`(isPrintable:bool) IsPrintable character:int`

### IsLetter
Is character a letter?

`(isLetter:bool) IsLetter character:int`

### ToUpper
Returns uppercase ASCII code of character.

`(upper:int) ToUpper character:int`

### ToLower
Returns lowercase ASCII code of character.

`(lower:int) ToLower character:int`
