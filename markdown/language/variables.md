# Variables
Variables store values of the specified type (see: [Variable Types](Types.md#variable-types)). They
can be contained in 3 scopes: global, quest, and script.

## Global Variables
Global variables are variables that can be accessed without any namespace. However they can only
be floats or integers, and thus are mostly used for game settings. Additionally since they don't
have a namespace, they can easily become overloaded. Thus they should only be used when direct
player intervention is needed via the game's console.

## Quest Variables
Quest variables are namespaced variables. See [Quest Namespace](script-types.md#quest-namespace).

## Script Variables
Script variables are scoped to the script that calls it, but its time of existence depends on
the type of script/the object attached to it.
- For object scripts, variables are temporarily saved to the object its attached to.
- For magic effect scripts, variables are never saved.
- For user-defined functions, variables are never saved.

