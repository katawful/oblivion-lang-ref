
# User-Defined Functions
User-defined functions (UDFs) can be defined as needed, and can be called like in other languages. They
are object scripts, and in most circumstances behave the same. They execute within a frame of the
game rendering like most scripts. They can have at most 10 parameters.

## Defining a UDF
The script used as a UDF must be an object script. There is only one possible block type, the
function call.

```ebnf
function = "function", "{", {parameter}, "}";
```

```obse
scn UserDefinedFunction
begin function {}
end
```

## Using UDFs
UDFs behave like most callable functions. Without a return value they return null. Variables are
scoped to only when the function is called. More UDFs can be called (up to 30 levels of nesting).
The only major difference is that there is only one block, and thus UDFs always fire in the same
manner regardless of game states. In that case, think of UDFs as a way to better structure the
scripts of your plugin.

UDFs do not have a performance cost for calling, however since scripts need to process within the
rendering of the game's current frame, it is better to split up functions if they are getting too
big.

### Calling UDFs
UDFs are called with the `call` function:

```ebnf
functionCall = 'call', udf, [{expression}];
udf = scriptName;
```

```obse
scn UDFCall
int x
int y
int z
begin gamemode
let x := call ReturnOne
let y := call AddOne y
let z := call Add x y
end
```

The `call` function always takes a reference to a script that is a user-defined function, plus
up to 10 arguments. When the interpreter gets to this point in execution, it simply injects the
execution of this function into that moment of the first script. The scope of the calling script
is not allowed into the called script. Variables must be passed and returned if needed.

### Returning from UDFs
UDFs always return to the calling script when all possible execution is done. No value is
returned by default (see: [Return Statement](statements.md#return-statement)). A specific function is used to set
the value that is returned, [`SetFunctionValue`](statements.md#userdefined-function-return-statement).

This function does not end execution, the return value is still needed. Instead think of this
function creating a temporary variable for return in this Lua example:

```lua
local left_greater_right = function(x, y)
  local temp_var = nil
  if x > y then
    temp_var = true
  else
    temp_var = false
  end
  return temp_var
end
```
Notice how if `temp_var` wasn't changed explicitly that the function would return nil. Also note
that `temp_var` was set in the else block in order to make sure a false value is passed. This is
how **all** UDFs behave. Return value is updated and then output at the end of execution.

### GetCallingScript
Returns the reference of the script that called this UDF, or null if not called by `call`.

`(script:ref) GetCallingScript`
