# Operators
The following is a list of operators found in `obl`. This is just a cursory list, see the
respective sections of each list for how they work.

|Operator | Type | Usage | Precedence|
|-|-|-|-|
|`+` | Binary | Math, Concatenation | 9|
|`-` | Binary | Math | 9|
|`*` | Binary | Math | 10|
|`/` | Binary | Math | 10|
|`^` | Binary | Math | 11|
|`%` | Binary | Math | 10|
|-|
|`:` | Binary | Slice/Range | 3|
|`::` | Binary | Make Pair | 3|
|`->` | Binary | Member Access | 15|
|`<-` | Binary | ForEach Access | 15|
|`.` | Binary | Method/Namespace Access|
|-|-|-|-|
|`>` | Binary | Comparison | 5|
|`<` | Binary | Comparison | 5|
|`<=` | Binary | Comparison | 5|
|`>=` | Binary | Comparison | 5|
|`==` | Binary | Comparison | 4|
|`!=` | Binary | Comparison | 4|
|`&&` | Binary | Comparison | 2|
|`\|\|` | Binary | Comparison | 1|
|`!` | Unary | Comparison | 13|
|-|-|-|-|
|`()` | n/a | Precedence/OE | 14|
|`[]` | Binary | Subscript | 15|
|-|-|-|-|
|`>>` | Binary | Bitwise | 8|
|`<<` | Binary | Bitwise | 8|
|`&` | Binary | Bitwise | 7|
|`\|` | Binary | Bitwise | 6|
|-|-|-|-|
|`-` | Unary | Negation | 12|
|`$` | Unary | Stringicize | 12|
|`#` | Unary | Numericize | 12|
|`*` | Unary | Dereference/Unbox | 12|
|`&` | Unary | Box | 12|
|-|-|-|-|
|`:=` | Binary | Assignment | 0|
|`+=` | Binary | Assignment | 2|
|`-=` | Binary | Assignment | 2|
|`*=` | Binary | Assignment | 2|
|`/=` | Binary | Assignment | 2|
|`^=` | Binary | Assignment | 2|

> Note that highest precedence is 15

