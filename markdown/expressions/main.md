# Expressions
Expressions return a value of one of the possible [types](../language/Types.md#types). The general
forms are as so:

```ebnf
expression = literal
           | variable  
           | gameFunction
           | userFunction
           | (expression, binary, expression)
           | (unary, expression);
```

Most objects being interacted with are considered expressions and can be used directly. All
variable types, all literals, and function that returns any value but null are expressions.

Literals can be found in [Literals](../language/Types.md#literal-types) under Types.

## Associativity 
It can be assumed that all expressions in `obl` is left associative. Precedence controls order
of operations for expressions.

## Variables as Expressions
Any variable type can be used in a place an expression is expected, when strict typing is not a
concern. If dealing with a function found in the original release of the game, use [Oblivion expressions](../constructs.md#implicit-type-forcing-via-obse-expressions-oe).
When used as expressions, variables cannot take any parameters and behave solely as placeholders
for the literal types.

See [Variables](../language/variables.md#variables) for how variables are declared
and [Variable Types](../language/Types.md#variable-types) for the types available.

## Game Expressions
`obl` has a variety of built-in functions that return values based on states in the game itself.
These can do a large variety of operations, but the general form of a game function is like so:

```ebnf
gameFunction = function, [{expression}] | [{ '(', {expression} ')' }];
```

For functions that can take a parameter, any expression is possible. However, parentheses must
be used to distinguish groups of expressions.

```obse
scn GameFunctionExpressions
int x
ref refVar
begin gamemode
let refVar := PlayerREF
let x := GetActorMinLevel PlayerREF ; parameter is a literal
let x := GetActorMinLevel refVar ; paramater is a variable
let x := GetActorMinLevel GetSelf ; paramater is another function
let x := GetActorMinLevel (Anusai.GetNthDetectedActor 0) ; parameter is a grouped expression
end
```

## Expression Types
There are 4 main types of named expressions in `obl`.

### Is/Has Expressions
Is/Has expressions typically return the status of a value of an object. They are almost always
booleans, returning 1 for truthy.

### Get Expressions
Get expressions return the value specified of an object. They can return any type.

### To Expressions
Converts between data types. Generally named as to what it converts to, not from.

### Unnamed Expressions
Unnamed expressions do not follow a consistent naming, but are generally self explanatory.
There are unnamed game statements, specificity is defined in the documentation these functions.

## Available Expressions
- [Math Functions](math.md)
- [Array Functions](arrays.md)

