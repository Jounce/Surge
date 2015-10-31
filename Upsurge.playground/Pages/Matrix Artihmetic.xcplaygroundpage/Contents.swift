//: ## Matrix Arithmetic
//: This example shows how to perform basic matrix operations with Upsurge
import Upsurge
//: Let's define two matrices using row notation
let A = RealMatrix([
    [1,  1],
    [1, -1]
])
let C = RealMatrix([
    [3],
    [1]
])
//: Now let' find the matrix `B` such that `A*B=C`
let B = inv(A) * C
//: And verify the result
let r = A*B - C
//: You can also operate on a matrix row or column the same way as you would with a RealArray
var col = A.column(0)
let diff = col - [10, 1]
col += diff
