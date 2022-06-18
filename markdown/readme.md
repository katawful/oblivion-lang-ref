Oblivion

Table of Contents

# Oblivion Scripting Language Reference for xOBSE v22.6.1
Oblivion Language (obl) is a dynamically typed interpreted language for the video game _The Elder
Scrolls IV: Oblivion_. While language within development tools refers to "compilation" of scripts,
it is only a temporary transpilation to, mildly human readable, internal game (not machine)
bytecode. It is thus purely interpreted in function, running all scripts as they finish serially
in a single thread. The order of execution is based on the order of internal ID the script _or_
object attached to script is bound to.
language-reference core test- verify that "compilation" is just parsing

`obl` has been expanded upon by the community, first with **OB**livion **S**cript **E**xtender
(OBSE), then in recent years with xOBSE. Because of the wide spread usage and the greatly expanded
syntax, this documentation will simply be assuming the features provided with the original game
are not solely valid. Any problems related to that will be discussed as they arrive.

- [Language Notation](notation.md)
- [General Language Constructs](constructs.md)

## Language
- [Lexical Conventions](language/lexical.md)
- [Operators](language/operators.md)
- [Available Types](language/Types.md)
- [Script Types](language/script-types.md)
- [Variable Types](language/variables.md)

## Statements
- [Language Statements](statments/statements.md)
- [Event Handlers](statements/event-handlers.md)
- [User-Defined Functions](statements/user-defined-functions.md)

## Expressions
- [Main Details](expressions/main.md)

## Objects
- [Objects Overview](objects/main.md)
- [Using Object-Oriented Programming Skills](objects/oriented.md)
