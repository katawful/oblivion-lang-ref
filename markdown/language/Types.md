# Types
## Literal Types
Literals can be used in any place a variable can, and are simply the direct connotation of what
the type refers to. There are a number of literals available to `obl`:

- String literals: Any ASCII characters enclosed in double quotes: `"string"`
- Integer literals: Any Arabic-Indic numeral, with optional negative symbol: `-1, 333`
- Float literals: Any Arabic-Indic numeral with a period for decimal notation: `-1.22, 3.44`
- Scientific literal: Any scientific notation numeral, using the E notation: `3E10, 3e-10`
    - These numbers are all floats
- Reference literal: Any game object reference, usually an identifier: `Torch02`
    - Any EditorID is acceptable here, which includes every valid object found in a plugin
- Type literal: Any unenclosed string, identifiers not found as game objects

## Variable Types
Variable types are the types that variables can be.
- floats: 32-bit/single precision. Effective precision is 1.18E-38 to 3.40E38
- integers: integers internally stored as floats
- reference: stores a game object, object must be persistent
- array: reference to an array, type unspecified
- string: reference to a string, a container type

```ebnf
variableDeclaration = varType, variable;
varType = "float"
        | "int"
        | "short"
        | "long"
        | "ref"
        | "array_var"
        | "string_var"
```

```obse
scn VarDeclaration
float floating
int integer
ref reference
array_var array
string_var string
```

### Numbers
All numbers are ultimately stored as floats, there is no use for distinguishing between shorts
and longs. Thus there are only 2 types, with one having 3 aliases for declaration:

|Type | Declaration|
|-|-|
|float | `float`|
|integer | `int`, `short`, `long`|

**NOTE:** the following two headings are here to address 2 solutions to integers being stored as
floats. While it is absolutely confirmed that the game internally stores integers in scripts
as floats, there is conflicting information on if they are stored as double-precision or
single-precision floats. Thus until one of these is confirmed, both are assumed to be true and
responsible for behaviors found when working with high number integers.

#### Integers as single floats
As all numbers are stored as floats internally, the only precision is the limitations of the
32-bit floats available. Therefore the largest integer value you can make where there's a
+/- 1 addition is 16,777,216. Higher values are rounded down. This is the source of weird
math behavior.

#### Integers as double floats
As all numbers are stored as double-precision floats internally, there is no use in
distinguishing between shorts and longs. Thus the full signed range up to 2,147,483,647 can
be used for any integer type. 

### Reference
Reference variables, confusingly, do not refer to anything. They contain the metadata of the
game object using the EditorID of the object as the name. EditorID is an unenclosed string of
characters. FormID, a hexadecimal number, can be stored in a reference variable but only as
the return value of a function. It'll get converted to the EditorID implicitly.

|Type | Declaration|
|-|-|
|reference | ref|

```obse
scn HowRefVarsWork
ref editorID
begin gamemode
let editorID := Torch02
end
```

### Strings
Strings are standard ASCII. They behave as containers, taking all array operations available.
They additionally get saved to the player's save game. Variables of this type behave in
specific ways. See the section on Strings in Expressions for more details.

|Type | Declaration|
|-|-|
|string | string_var|

### Arrays
Arrays are a generalized container type that gets saved to the player's saved game. They can
be 1 of three types:

1. Array: this is a 0-indexed array. Standard array operations apply
2. Map: a non-ordered array that takes any number as index
3. StringMap: a non-ordered array that takes any string as index

|Type | Declaration|
|-|-|
|array | array_var|

Array variables, like string variables are references to the container. The container must
exist before manipulation, see the section on Arrays in Expressions for more details.

## Return and Parameter Types
Documentation of game functions will show a variety of types that can be returned and used as
parameters. The above types can all be used in addition to the following:

|Type | Source Type | Stored Type|
|-|-|-|
|chars | `4` character string, optionally enclosed in quotes | String|
|bool | `1` for true, `0` for false | Number|
|formatString | a string that takes format specifiers, plus up to 20 arguments [1](#1) | String|
|FormID | a hexadecimal number of an object [2](#2) | Reference|
|multi | any non-object value | n/a|

###### 1
Format specifiers can be found in the sections on Strings in Expressions.

###### 2
See the section on References for more details.

## Null Type
You cannot assign anything to the null type, it is simply returned upon a runtime error.

