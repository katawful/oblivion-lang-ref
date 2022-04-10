# Arithmetic Operators
`obl` supports a number of standard arithmetic operators. Operators are symbols, either unary or
binary that combine 1 or more identifiers into an expression.

|Operator | Type | Use | Precedence|
|-|-|-|-|
|`+` | Binary | Addition | 9|
|`-` | Binary | Subtraction | 9|
|`*` | Binary | Multiplication | 10|
|`/` | Binary | Division | 10|
|`^` | Binary | Exponentiation | 11|
|`%` | Binary | Integer modulo | 10|

> Integer modulo takes the integer remainder of the division factor.

## Type Conversion
Math can be performed between either number type at will, but the output variable will determine
how it gets stored. When storing a floating point result as an integer, the decimal portion will
be truncated without rounding.

# Math Functions
In addition to the base arithmetic operators, `obl` also supports additional math functions.

## Abs
Return the absolute value of the argument, truncates floats.

`(abs:float) abs arg:float`

## Ceil
Returns the nearest integer above the argument.

`(ceil:float) ceil arg:float`

## Exp
Returns the result of e, the natural number, to the power of the argument.

`(exp:float) exp arg:float`

## Floor
Returns the nearest integer below the argument.

`(floor:float) floor arg:float`

## Fmod
Returns the floating point modulo of the dividend in the base. The optional offset shifts the
range of the result by adding that value to the base.

This function can be generally defined in the following form:
`modulus n base := n - base * (floor (n / base))`.

This will produce a result that can be defined in the range of:

`0 <= result < base`

`offset <= result < base + offset`

when the base is positive and

`0 >= result > base`

`offset >= result > base + offset`

when the base is negative.

`(fmod:float) fmod dividend:float base:float offset:float`

## Log
Returns the natural log of the argument.

`(log:float) log arg:float`

## Log10
Returns the log of base 10 of the argument.

`(log10:float) log10 arg:float`

## Pow
Returns the result of the base raised to the exponent.

`(pow:float) pow base:float exponent:float`

## Rand
language-reference test math- see if rand is inclusive
- see if rand is a float
      Returns a random number between the two arguments, inclusive.

`(rand:float) rand min:float max:float`

## GetRandomPercent
language-reference formatting- mark soft deprecated functions?
      Returns a random number between 0 and 99 inclusive.

`(GetRandomPercent:int) GetRandomPercent`

Note that this function was originally the only available random function in `obl`. It should
not be used when working with new code.

## SquareRoot
language-reference formatting- think about formatting for aliases here
      Returns the square root of the argument.

`(SquareRoot:float) SquareRoot arg:float`

`(sqrt:float) sqrt arg:float`

# Trigonometric Functions
Standard trig functions are available, the default functions use degrees instead of radians.
Radian specific functions are designated with a 'R' as a prefix. All trig functions have an alias
with a 'D' as a prefix, to better distinguish that the degrees form is used.

## ACos
Returns the arccosine of the argument.

`(acos:float) acos arg:float`

`(acos:float) dacos arg:float`

`(acos:float) racos arg:float`

## ASin
Returns the arcsine of the argument.

`(asin:float) asin arg:float`

`(asin:float) dasin arg:float`

`(asin:float) rasin arg:float`

## ATan
Returns the arctangent of the argument.

`(atan:float) atan arg:float`

`(atan:float) datan arg:float`

`(atan:float) ratan arg:float`

## ATan2
Returns the arctangent of the arguments, an expanded vector form.

`(atan:float) atan2 arg1:float arg2:float`

`(atan:float) datan2 arg1:float arg2:float`

`(atan:float) ratan2 arg1:float arg2:float`

See the section on [Linear Algebra](#linear-algebra) for vectors forms.

## Cos
Returns the cosine of the argument.

`(cos:float) cos arg:float`

`(cos:float) dcos arg:float`

`(cos:float) rcos arg:float`

## CosH
Returns the hyperbolic cosine of the argument.

`(cosh:float) cosh arg:float`

`(cosh:float) dcosh arg:float`

`(cosh:float) rcosh arg:float`

## Sin
Returns the sine of the argument.

`(sin:float) sin arg:float`

`(sin:float) dsin arg:float`

`(sin:float) rsin arg:float`

## SinH
Returns the hyperbolic sine of the argument.

`(sinh:float) sinh arg:float`

`(sinh:float) dsinh arg:float`

`(sinh:float) rsinh arg:float`

## Tan
Returns the tangent of the argument.

`(tan:float) tan arg:float`

`(tan:float) dtan arg:float`

`(tan:float) rtan arg:float`

## TanH
Returns the hyperbolic tangent of the argument.

`(tanh:float) tanh arg:float`

`(tanh:float) dtanh arg:float`

`(tanh:float) rtanh arg:float`

# Bitwise Operations
language-reference core documentation- explain bitwise operations

`obl` supports standard bitwise operations, with the caveat that no new type for binary numbers
being added. Manual conversion between binary and decimal must be performed.

There are a number of bitwise operators:
|Operator | Type | Function | Precedence|
|`>>` | Binary | Left Shift | 8|
|`<<` | Binary | Right Shift | 8|
|`&` | Binary | Logical AND | 7|
|`\|` | Binary | Logical OR | 6|

> Note the lack of logical XOR and logical NOT binary operators

As well there are a number of bitwise functions, mostly mirrors of these operators:

## LeftShift
Returns argument shifted left by number of bits. Returns zero if shift amount is greater than
32.

`(LeftShift:int) LeftShift arg:int bits:int`

## RightShift
Returns argument shifted right by number of bits. Returns zero if shift amount is greater than
32.

`(RightShift:int) RightShift arg:int bits:int`

## LogicalAND
Returns the logical AND of the two arguments.

`(LogicalAND:int) LogicalAND arg1:int arg2:int`

## LogicalOR
Returns the logical OR of the two arguments.

`(LogicalOR:int) LogicalOR arg1:int arg2:int`

## LogicalNOT
Returns the logical NOT of the two arguments.

`(LogicalNOT:int) LogicalNOT arg1:int arg2:int`

## LogicalXOR
Returns the logical XOR of the two arguments.

`(LogicalXOR:int) LogicalXOR arg1:int arg2:int`

# Linear Algebra
language-reference core documentation- explain linear algebra somewhat

`obl` supports linear algebra directly, using the array type of type array to create vectors and
matrices. Matrices and vectors must always have numbers. Any other type is an error.

## Matrix
Matrices are internally 2 dimensional, stored as nested arrays where the elements of the outer
array are the rows of the matrix. Therefore, in `A[i][j]`, the 'j_th' element is the current
index of the 'i_th' row.

Matrices must either be 1 or 2 dimensional. A 1 dimensional matrix is simply an unnested array.
A 2 dimensional matrix can only have 1 row to function as a 1D matrix. All rows must have the
same length to be a valid 2D matrix.

Some functions expect a "square" matrix, that is a matrix where the number of columns and rows
are equal. This can be described as the size of the first array being equal to the size of one
of the second, nested, arrays. Since matrices must have equal rows regardless, additional
processing is not needed unless one is constructing a matrix programmatically.

```obse
scn SquareMatrix
int columnSize
int rowSize
begin gamemode
let columnSize := ar_Size matrix
let rowSize := ar_Size matrix[i]
if columnSize == rowSize
  print "mkkatrix is square"
endif
end
```

### GenerateZeroMatrix
Returns a matrix of the size specified by the arguments, with each element filled with zero.

`(zeroMatrix:array) GenerateZeroMatrix height:int width:int`

`(zeroMatrix:array) zeromat height:int width:int`

### GenerateIdentityMatrix
Returns a square matrix with each element along the diagonal, top-left to bottom-right, filled
with 1 and every other element filled with 0.

`(identityMatrix:array) GenerateIdentityMatrix size:int`

`(identityMatrix:array) identitymat size:int`

### GenerateRotationMatrix
Returns a 3x3 square matrix that can serve as a rotation matrix about the specified axis.
Rotation matrixes are always invertible, and their inverse is equal to their transpose.
language-reference core test- find out what axis is

`(rotationMatrix:array) GenerateRotationMatrix axis:axis angle:float`

`(rotationMatrix:array) rotmat axis:axis angle:float`

### MatrixTrace
Returns the trace of a square matrix, the sum of elements along the diagonal (top-left to
bottom-right).

`(trace:float) MatrixTrace matrix:array`

`(trace:float) tr matrix:array`

Note that this function returns 0 if it is passed a non-square matrix, not the null type. It
is up to the user to make sure that a square matrix is passed.

### MatrixDeterminant
Returns the determinant of a square matrix.

`(determinant:float) MatrixDeterminant matrix:array`

`(determinant:float) det matrix:array`

Note that this function returns 0 if it is passed a non-square matrix, not the null type. It
is up to the user to make sure that a square matrix is passed.

### MatrixRREF
Returns the reduce row echelon form (RREF) of a matrix.

`(rref:array) MatrixRREF matrix:array`

`(rref:array) rref matrix:array`

### MatrixInvert
Returns the inverse matrix of a matrix. Returns 0 if a matrix is not invertible.

`(inverseMatrix:array) MatrixInvert matrix:array`

`(inverseMatrix:array) matinv matrix:array`

### MatrixTranspose
Returns the transpose of a matrix. The rows a matrix becomes the columns of its transpose.

`(transposeMatrix:array) MatrixTranspose matrix:array`

`(transposeMatrix:array) transpose matrix:array`

### MatrixScale
Returns a matrix where each element is scaled by a number.

`(scaledMatrix:array) MatrixScale scalar:float matrix:array`

`(scaledMatrix:array) matscale scalar:float matrix:array`

### MatrixAdd
Returns the sum of two matrices. Matrices are summed by adding each element at each position.
The matrices must have the same dimensions.

`(matrixSum:array) MatrixAdd addend:array`

`(matrixSum:array) matadd addend:array`

### MatrixSubtract
Returns the difference of two matrices. Matrices are subtracted by taking the difference of
each element at each position. The matrices must have the same dimensions.

`(matrixDiff:array) MatrixSubtract minuend:array`

`(matrixDiff:array) matsubtract minuend:array`

### MatrixMultiply
Returns the product of two matrices. Matrix multiplication is not commutative, order of
multiplication matters. The product of matrix A and matrix B does not equal matrix B and A.
The width of the first matrix must be equal to the height of the second matrix.

`(matrixProduct:array) MatrixMultiply matrix:array matrix:array`

`(matrixProduct:array) matmult matrix:array matrix:array`

Two 1D arrays cannot be multiplied since a row vector multiplied by a column vector is
different than a column vector multiplied by a row vector. This is an ambiguity that is solved
by [`ForceRowVector`](#forcerowvector) and [`ForceColumnVector`](#forcecolumnvector).
Process one or both with these functions to remove the ambiguity.

## Vector
Vectors can be defined in 3 ways:
1. A 1D array [1D Vectors](#1d-vectors)
2. A 2D array with 1 row [Row Vector](#row-vector)
3. A 2D array where each row only has 1 element [Column Vector](#column-vector)

###### 1D Vectors
1D vectors can be ambiguous, use [`ForceRowVector`](#forcerowvector) or 
[`ForceColumnVector`](#forcecolumnvector) if no ambiguity is allowed

###### Row Vector
Type 2 is a row vector

###### Column Vector
Type 3 is a column vector

### ForceRowVector
Takes a 1D array and returns an equivalent 2D array where the outer array's only element is
the 1D array (`vector[0][j] == v[j]`). This is used where row vectors are needed.

`(rowVector:arrays) ForceRowVector vector:array`

`(rowVector:arrays) rowvec vector:array`

Note that row vectors require only 2 array variables as opposed to the n+1 array variables
needed for column vectors. Row vectors are therefore preferred if at all possible.

### ForceColumnVector
Takes a 1D array and returns an equivalent 2D array where the outer array's elements are each
arrays with only 1 element - each element in the 1D array (`vector[i][0] == v[i]`). This is
used when column vectors are needed.

`(columnVector:arrays) ForceColumnVector vector:array`

`(columnVector:arrays) colvec vector:array`

Note that row vectors require only 2 array variables as opposed to the n+1 array variables
needed for column vectors. Row vectors are therefore preferred if at all possible.

### VectorMagnitude
Returns the magnitude of a vector, the square-root of the sum of the squares of its elements.

`(magnitude:float) VectorMagnitude vector:array`

`(magnitude:float) vecmag vector:array`

### VectorNormalize
Returns the normalized version of a vector, where each entry of the vector is divided by the
magnitude. A normalized vector has a magnitude of 1.

`(normVector:array) VectorNormalize vector:array`

`(normVector:array) vecnorm vector:array`

### VectorDot
Returns the dot/scalar product of two vectors. The vectors must have the same length.

`(dotProduct:float) VectorDot vector:array vector:array`

`(dotProduct:float) dot vector:array vector:array`

Note that this function will return 0 upon failure not the null type, which is usually the
result of taking the dot product of vectors of different sizes. The user should make sure that
the vectors are of the same size when using this function.

### VectorCross
Returns the cross/vector product of two vectors. The vectors must have the same length.

`(crossProduct) VectorCross vector:array vector:array`

`(crossProduct) cross vector:array vector:array`

