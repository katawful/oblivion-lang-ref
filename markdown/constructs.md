# Essential Constructs
## Loose Language
`obl` is completely case insensitive, and is also whitespace insensitive (assuming constructs
are completed within their line).

## Literal Language
`obl` is a literal language, and thus everything must be declared within the language file.
While the scripts written can be attached to game objects, or used as their own functions, the
name as such must be the first thing declared by the script file:

```ebnf
nameDeclare = scriptDeclarator, scriptName, eol;
scriptDeclarator = "scn" | "scriptname";
scriptName = identifier;
eol = "\n" | "\r";
identifier = {ascii};
```

```obse
scn ThisIsTheName
```

### Identifiers
It is not know the extent to which ASCII characters are allowed in `obl` for identifiers.
There is a distinct difference between, for instance, script names and variable names that
are accepted by the compiler. Thus for this reason it is **highly** recommended to only ever
use unaccented ASCII Latin and Arabic-Indic characters. Snakecasing can work for variables,
but this behavior is unknown. In addition, do not start a script name with a numeral. The
game may attempt to process the script name as a number. If one wishes to set their script
name apart from others alphanumerically, it is better to only use a alphabetical prefix.

## Script Body
`obl` can not run functions arbitrarily. As it is a game-oriented language, the scripts run in
certain game-specific blocks. Everything outside is top-level script information.

```ebnf
script = nameDeclare, [{variableDeclaration | beginBlock}];
```

```obse
scn ScriptName
int intVariable
begin GameMode
  set intVariable to 1 + intVariable
  PrintC "%g", intVariable
end
float floatVariable
begin MenuMode
  set floatVariable to 1.33
  PrintC "%.0f", floatVariable
end
```

See ["Begin" Blocks](statements/statements.md#begin-blocks) and 
[Variable Declarators](statements/statements.md#variable-declarators) for more information on
top-level information.

## Script Type
While not a part of the language spec itself, `obl` language files when brought into the game's
development tools can be defined as one of 3 types: "Quest Script", "Object Script", and "Magic
Effect Script", with "Object Script" being the default. More details about these will be
discussed in [Script Types](language/script-types.md#script-types).

## Static Typing by Assumption
`obl` is technically dynamically typed. There are a lot of scenarios where the compiler does
keep static typing, however there are an equal amount of times where a runtime error will
occur. Static typing can be ignored with a type forcing construct, however this does not
prevent runtime errors:

```obse
; the following will fail as AddItem is a vanilla function
; explained a later section, this is an error when trying to use an array, a non-vanilla
;   feature
AddItem Torch02 array[0]
; by using parentheses we can force the type during runtime
AddItem Torch02 (array[0])
```

Thus typing can be dynamic with intervention. For the ease of development, it is best to assume
that typing is static. The exact reasons why this is the case will be discussed later.

## Manifest Typing
Types are declared explicitly in `obl`, and therefore variables cannot change type inside their
scope:

```obse
scn ScriptName
; types must be declared
int i
begin gamemode
let i := 1
; they also can't be changed
let i := "string" ; ERROR
end
```

## Strong/Weak Typing
`obl` has a mix of strong and weak typing. It is similar to implicitly typed languages like Lua
and Javascript, where some types can be converted (i.e.: `let x = 1 + "hi"`), however the
scenarios in which implicit type conversion actually happens is limited. 

### Implicit Type Forcing via OBSE Expressions (OE)
As `obl` has been expanded by community efforts via OBSE, new data types have been
introduced. In order to directly integrate itself with the features available in the original
game, a mechanism to detect and force types to be weak:

```ebnf
OE = "(", expr, ")";
```

```obse
; array[0] contains an integer, but AddItem only sees the array type
; the parentheses forces array[0] to be parsed internally to the type it contains
AddItem Torch02 (array[0])
```

Note that OE also overlaps with parentheses for operation ordering. This might lead to
unexpected behavior if one is unaware.

### Compile with OBSE Expressions Enabled (COEE)
Any expression can be attempted to be evaluated with OE. If more direct control is needed,
you can compile with OBSE expressions enabled for everything:

```ebnf
beginBlock = startBlock, innerBlock, endBlock;
startBlock = "begin", (gameFeature 
                     | function 
                     | coeeGameFeature 
                     | coeeFunction)
                    , eol;
function = "function", "{", {paramter}, "}";
coeeGameFeature = "_", gameFeature;
coeeFunction = "_", function;
endBlock = "end", eol;
```

```obse
scn coeeExample
int i
begin _gamemode
  AddItem Torch02 array[0] ; no longer an error
  let i := "hello" ; however this is a runtime error
end
begin _function {}
end
```

This removes the need for strict OE usage (instead delegating parentheses to evaluation
order), but COEE may also present its own issues. Only use if OE fails.

> COEE can be considered a semantical problem, not a syntaxical one

