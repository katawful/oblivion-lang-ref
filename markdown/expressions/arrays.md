# Arrays
Arrays are containers. They can store any of the [literal](../language/Types.md#literal-types)
types, plus another array. They are very similar to most language containers, like Lua tables and
C++ vectors. There are 3 types of arrays. Conversion between these types is not possible.
Additionally, arrays in `obl` are always ordered.

## Notation
Arrays are generally only stored into variables. Performing array operations on expressions will
generally lead to runtime errors.

```ebnf
array = variable, {subscript};
```

### Declaration
Array variables are declared with 'array_var'. Default initialization is 0.

## Scope
Arrays must be explicitly defined within their scope if not passing the return value of a
function. This determines the type of array container.

```obse
scn ArrayDeclare
array_var arrayVar
begin gamemode
let arrayVar := ar_Construct Array
; arrayVar is now an array
let arrayVar := ar_Construct Map
; arrayVar is now a map
let arrayVar := ar_Construct StringMap
; arrayVar is now a string map
end
begin menumode
ar_Dump arrayVar
; error, not defined until gamemode runs
end
```

## Array Types
There are 3 types of arrays
1. Array: 0-indexed sequential array. Standard array operations.
2. Map: Unordered array where the key is any numeral expression.
3. StringMap: Unordered array where the key is any string expression.

## Iteration of Arrays
Generally arrays can be processed in 2 manners: [while statement](../statements/statements.md#while-statement)
and [foreach statement](../statements/statements.md#foreach-statement). Both have upsides and
should be considered.

### Using While Loops to Iterate Arrays
A while statement is a very simple construct. It loops until an expression is false. Because of
this, it is very fast. A simple loop over an array can be significantly faster than a foreach
loop. However, it can only successfully iterate over the array type "array" (i.e. 0-indexed
arrays). It is impossible to iterate over "StringMaps", and while regular "Map" style can be
iterated on it is only possible on the valid numerical keys of the map array. 

```obse
scn WhileIteration
array_var arrayType
array_var mapType
int iter
begin gamemode
; assume that var arrayType is filled with the values of 0-19 inclusive
; 0, 1, 2, ... 18, 19
let iter := 0
while iter < (ar_Size arrayType)
  printc "current value is: %g", arrayType[iter]
  let iter += 1
loop
; assume that mapType is filled with keys of even values between 0 and 20 inclusive
; 0, 2, 4, ... 16, 18, 20
let iter := 0
while iter <= (ar_Size mapType)
  printc "current value is: %g", mapType[iter]
  let iter += 2
loop
end
```

### Using ForEach Loops to Iterate Arrays
ForEach loops can be used to directly iterate over each value of any array type. Like most
languages with the foreach statement, a destination variable is used that contains the
information needed. In `obl` that destination variable is itself an array. See the section on
destination containers in [foreach statement](../language/statements.md#foreach-statement) for all 3
types that can use the foreach loop. This destination variable is only valid for the current
iteration.

For arrays themselves, it does not matter what type the source array can be. The destination
container will always contain 2 indices:
1. "key": the current index in the loop
2. "value": the current value of index "key"

```obse
scn ForEachIteration
array_var arrayType
array_var mapType
array_var stringMapType
array_var iter
int tempInt
string_var tempString
begin gamemode
; assume that var arrayType is filled with the values of 0-19 inclusive
; 0, 1, 2, ... 18, 19
foreach iter <- arrayType
  let tempInt := iter["key"]
  printc "key is: %g", tempInt
  let tempInt := iter["value"]
  printc "value is: %g", tempInt
loop
; assume that mapType is filled with keys of even values between 0 and 20 inclusive
; 0, 2, 4, ... 16, 18, 20
foreach iter <- mapType
  let tempInt := iter["key"]
  printc "key is: %g", tempInt
  let tempInt := iter["value"]
  printc "value is: %g", tempInt
loop
; assume that stringMapType is filled with keys of the letters a through z
; a, b, c, ... y, z
foreach iter <- stringMapType
  let tempString := iter["key"]
  printc "key is: %z", tempInt
  let tempInt := iter["value"]
  printc "value is: %g", tempInt
loop
end
```

Note that we need to pass off the subscripted destination array. This is related to typing, and
is a case where it can fail even with OEs.

## Array Operations
Arrays only have 2 main operators:

|*Operator* | *Type* | *Use* | *Precedence*|
|-|-|-|-|
|`[]` | n/a | Subscript | 15|
|`:` | Binary | Slice/Range | 3|

### SubScripting Arrays
The subscripted array returns the value associated with the index.

```ebnf
subscript = '[', [{(expression)}, literal], ']';
```

Variables can be subscripted many times, for nested arrays.

```obse
scn ArraySubscript
array_var arrayVar
begin gamemode
; array is type array with ["a", "b", ["i", "ii"], "d"]
Print arrayVar[1] ; -> "b"
Print arrayVar[2] ; -> error, is array
Print arrayVar[2][0] ; -> "i"
let arrayVar[4] := "e" ; add new elements
let arrayVar[5] := ar_Construct StringMap ; create new array at position 5
let arrayVar[5][0] := "1."
end
```

### Slice/Range Notation
Arrays can be addressed over a range of valid index values:

```ebnf
sliceRange = {literal}, ':', {literal};
```

```obse
scn SliceRange
array_var arrayVar
array_var iter
begin gamemode
; if array is of size 9
foreach iter <- arrayVar[2:7]
; indices  2-7 are iterated
loop
foreach iter <- arrayVar[:8]
; indices up to and including 8 are iterated
loop
foreach iter <- arrayVar[3:-2]
; indices from 3 to the second from last are iterated
loop
; if array is a map that contains the even values between 0-10
foreach iter <- arrayVar[3:7]
; indices 4 and 6 are iterated
loop
; if array is a stringmap that has the keys "begin", middle, and "end"
foreach iter <- arrayVar["begin":"end"]
; indices >= "begin" and <= "end" are iterated
loop
end
```

A number of things are of note here:
1. Array type doesn't matter
2. Only one range needs to be used
3. Negative values work from the reverse for array type
4. Numerical value of strings is used

## Array Functions
### ar_Construct
Creates and returns a new empty array of the specified type:
1. Array
2. Map
3. StringMap

`(array_var) ar_Construct arrayType:type`

### ar_Size
Returns the number of elements in an array, or -1 for uninitialized arrays.

`(array_var) ar_Size array:array_var`

### ar_Dump
Prints the contents of the array, key and value, to the console.

`(null) ar_Dump array:array_var`

### ar_DumpID
Like ar_Dump but accepts an array ID instead.

`(null) ar_DumpID arrayID:int`

### ar_Erase
Erases all elements in an array, a single element, or a range using [Slice/Range Notation](#slicerange-notation).
Returns the number of elements removed.

`(removed:int) ar_Erase target:array_var`

`(removed:int) ar_Erase target:array_var[index:arrayIndex]`

`(removed:int) ar_Erase target:array_var[sliceRange]`

### ar_Find
Locates the first value in an array of the specified value, and returns the key associated with
it. Accepts a range. Returns an empty string for StringMaps or -99999.0 for numerical arrays
when no value is found.

`(index:arrayIndex) ar_Find value:Literal sourceArray:array_var`

`(index:arrayIndex) ar_Find value:Literal sourceArray:array_var[sliceRange]`

### ar_Sort
Sorts in ascending order and returns the specified array of type array. Keys associated with
these values are lost. All elements must be the same type. If not, then an empty array is
returned. An optional truthy value uses descending order.
1. Strings are sorted alphabetically and case-insensitively
2. Numbers are sorted numerically
3. Objects are sorted by FormID

`(sorted:array_var) ar_Sort source:array_var descend:bool`

### ar_SortAlpha
Sorts in ascending order and returns the specified array of type array. Keys associated with
these values are lost. Converts all values to strings temporarily, then sorts alphabetically and
case-insensitively. An optional truthy value uses descending order.

`(sorted:array_var) ar_SortAlpha source:array_var descend:bool`

### ar_Copy
Creates and returns a copy of the source array, making references to any nested arrays.

`(copy:array_var) ar_Copy source:array_var`

### ar_DeepCopy
Like `ar_Copy` but nested arrays are also copied.

`(copy:array_var) ar_Copy source:array_var`

### ar_First
Returns the key of the first element of an array.

`(index:arrayIndex) ar_First source:array_var`

### ar_Last
Returns the key of the last element of an array.

`(index:arrayIndex) ar_Last source:array_var`

### ar_BadNumericIndex
Returns a constant representing the invalid numerical index. Used for comparing to the return
value of array functions.

`(badIndex:int) ar_BadNumericIndex`

### ar_BadStringIndex
Like `ar_BadNumericIndex` but for StringMaps.

`(badIndex:int) ar_BadStringIndex`

### ar_Next
Returns the key of the element immediately following the specified key. Returns the bad index
constant if no key follows.

`(nextIndex:arrayIndex) ar_Next source:array_var index:arrayIndex`

### ar_Prev
Returns the key of the element immediately preceding the specified key. Returns the bad index
constant if no key follows.

`(prevIndex:arrayIndex) ar_Prev source:array_var index:arrayIndex`

### ar_Keys
Returns an array of type array containing all of the keys of the source array.

`(array:array_var) ar_Keys source:array_var`

### ar_HasKeys
Returns true if array has an element with the specified key.

`(hasKey:bool) ar_HasKey source:array_var index:arrayIndex`

### ar_List
Taking up to 20 arguments of any type, returns an array of type array containing those elements
in the order in which they were passed. Separation of arguments is optionally comma separated
(and encouraged).

`(list:array_var) ar_List arg1:literal arg2:literal ... arg20:literal`

### ar_Map
Returns a Map or StringMap given up to 20 key-value pairs. Keys must be either numbers or
strings, values can be any value.

`(Map/StringMap) ar_Map keyValue1 keyValue2 ... keyValue20`

> Note that the rest of these functions only apply to arrays of type array

### ar_Resize
Resizes an array that is resized to the specified size. If the new array is smaller, values
outside of that array are lost. If the new array is bigger, new values are used. 0 is the
default, but the padding values can be specified. Returns true if successful, false otherwise.

`(resized:bool) ar_Resize source:array_var size:int paddingValue:multi`

### ar_Insert
Inserts a single element into an array at the index. Index must be inside the array. Elements
above the index are shifted up by 1 index. Returns true on success, false otherwise.

`(inserted:bool) ar_Insert source:array_var index:arrayIndex value:multi`

### ar_InsertRange
Inserts a range of elements into an array at the index. Index must be inside the array. Elements
above the index are shifted up by the number of elements inserted. Returns true on success,
false otherwise.

`(inserted:bool) ar_Insert source:array_var index:arrayIndex range:array_var`

### ar_Range
Returns an array of 0 or more numbers within the inclusive start and end ranges, on the optional
interval specified, otherwise 1. This allows one to mimic traditional for loops using the
foreach loop.

`(range:array_var) ar_Range start:int end:int step:int`

### ar_Append
Appends value to array.

`(null) ar_Append source:array_var value:value`

### ar_CustomSort
Returns an array sorted by the called sorting function. The function takes 2 array_var
arguments. When called, the arguments contain 1 element each - the values being compared. The
function returns false if the first argument is less than the second argument and true if the
first is greater than or equal to the second.

These terms are general, and are only there to provide sorting. Care must be taken to
provide a definitive ordering of your array. Otherwise this function will never terminate.

The optional bool can set sorting to reverse.

`(sorted:array_var) ar_CustomSort source:array_var comparisonFunction:ref descend:bool`

