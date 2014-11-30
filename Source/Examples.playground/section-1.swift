import Surge

let n = [-1.0, 2.0, 3.0, 4.0, 5.0]
let sum = Surge.sum(n)

let a = [1.0, 3.0, 5.0, 7.0]
let b = [2.0, 4.0, 6.0, 8.0]
let product = Surge.mul(a, b)


// | 1  1 |       | 3 |
// |      | * x = |   |          x = ?
// | 1 -1 |       | 1 |
let A = Surge.Matrix([1,1], [1,-1])
let c = Surge.Matrix([3],[1])
let x = Surge.mul(Surge.inv(A), c)
