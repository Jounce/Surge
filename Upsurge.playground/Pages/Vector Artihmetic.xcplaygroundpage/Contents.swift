//: ## Vector Arithmetic
//: This example shows how to perform basic vector operations on arrays
import Upsurge
//: Regular Swift arrays can be used to perform some arithmetic operations. Let's add all the elements in an array.
let array = [1.0, 2.0, 3.0, 4.0, 5.0]
let arraySum = sum(array)
//: Upsurge's `RealArray`s are more powerful than regular Swift arrays for doing math. For instance, `RealArray` overloads `+` and `+=` to mean addition, whereas for Swift arrays they mean concatenation. Let's define two `RealArray`s and add them together.
let a: RealArray = [1.0, 3.0, 5.0, 7.0]
let b: RealArray = [2.0, 4.0, 6.0, 8.0]
let c = a + b
//: You can also perform operation that are unique to `RealArray`. This is how you would compute the dot production between two arrays
let product = a • b
//: You can also perform operations on parts of an array using the usual slice syntax
let d = a[0..<2] + b[2..<4]
//: And you can of course mix operations into more elaborate expressions
let result = sqrt(a[0..<2] * 2 + a[2..<4] / 2)
