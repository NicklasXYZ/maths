////<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css" integrity="sha384-nB0miv6/jRmo5UMMR1wu3Gz6NLsoTkbqJghGIsx//Rlm+ZU03BU6SQNC66uf4l5+" crossorigin="anonymous">
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js" integrity="sha384-7zkQWkzuo3B5mTepMUcHkMB5jZaolc2xDwL6VFqjFALcbeS9Ggm/Yr2r3Dy4lfFg" crossorigin="anonymous"></script>
////<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js" integrity="sha384-43gviWU0YVjaDtb/GhzOouOXtZMP/7XUzwPTstBeZFe/+rCMvRwr4yROQP43s0Xk" crossorigin="anonymous"></script>
////<script>
////    document.addEventListener("DOMContentLoaded", function() {
////        renderMathInElement(document.body, {
////          // customised options
////          // • auto-render specific keys, e.g.:
////          delimiters: [
////              {left: '$$', right: '$$', display: false},
////              {left: '$', right: '$', display: false},
////              {left: '\\(', right: '\\)', display: false},
////              {left: '\\[', right: '\\]', display: true}
////          ],
////          // • rendering keys, e.g.:
////          throwOnError : true
////        });
////    });
////</script>
////<style>
////    .katex { font-size: 1.1em; }
////</style>
////
//// ---
////
//// Arithmetics: A module containing a collection of fundamental mathematical functions relating to simple arithmetics (addition, subtraction, multiplication, etc.), but also number theory.
////
//// * **Division functions**
////   * [`gcd`](#gcd)
////   * [`lcm`](#lcm)
////   * [`divisors`](#divisors)
////   * [`proper_divisors`](#proper_divisors)
////   * [`int_euclidean_modulo`](#int_euclidean_modulo)
//// * **Sums and products**
////   * [`float_weighted_sum`](#float_weighted_sum)
////   * [`int_weighted_sum`](#int_sum)
////   * [`float_weighted_product`](#float_product)
////   * [`int_weighted_product`](#int_product)
////   * [`float_cumulative_sum`](#float_cumulative_sum)
////   * [`int_cumulative_sum`](#int_cumulative_sum)
////   * [`float_cumulative_product`](#float_cumulative_product)
////   * [`int_cumulative_product`](#int_cumulative_product)
//// * **Conversion**
////   * [`degrees_to_radians`](#degrees_to_radians)
////   * [`radians_to_degrees`](#radians_to_degrees)
//// * **Trigonometric and hyperbolic functions**
////   * [`acos`](#acos)
////   * [`acosh`](#acosh)
////   * [`asin`](#asin)
////   * [`asinh`](#asinh)
////   * [`atan`](#atan)
////   * [`atan2`](#atan2)
////   * [`atanh`](#atanh)
////   * [`cos`](#cos)
////   * [`cosh`](#cosh)
////   * [`sin`](#sin)
////   * [`sinh`](#sinh)
////   * [`tan`](#tan)
////   * [`tanh`](#tanh)
//// * **Powers, logs and roots**
////   * [`exponential`](#exponential)
////   * [`natural_logarithm`](#natural_logarithm)
////   * [`logarithm`](#logarithm)
////   * [`logarithm_2`](#logarithm_2)
////   * [`logarithm_10`](#logarithm_10)
////   * [`nth_root`](#nth_root)
//// * **Mathematical constants**
////   * [`pi`](#pi)
////   * [`tau`](#tau)
////   * [`e`](#e)
//// * **Combinatorial functions**
////   * [`combination`](#combination)
////   * [`factorial`](#factorial)
////   * [`permutation`](#permutation)
////   * [`list_combination`](#list_combination)
////   * [`list_permutation`](#list_permutation)
////   * [`cartesian_product`](#cartesian_product)
//// * **Ranges and intervals**
////   * [`arange`](#arange)
////   * [`linear_space`](#linear_space)
////   * [`logarithmic_space`](#logarithmic_space)
////   * [`geometric_space`](#geometric_space)
//// * **Distance measures**
////   * [`norm`](#norm)
////   * [`manhattan_distance`](#manhattan_distance)
////   * [`euclidean_distance`](#euclidean_distance)
////   * [`chebyshev_distance`](#chebyshev_distance)
////   * [`minkowski_distance`](#minkowski_distance)
////   * [`cosine_similarity`](#cosine_similarity)
////   * [`canberra_distance`](#canberra_distance)
////   * [`braycurtis_distance`](#braycurtis_distance)
//// * **Set similarity measures**
////   * [`jaccard_index`](#jaccard_index)
////   * [`sorensen_dice_coefficient`](#sorensen_dice_coefficient)
////   * [`tversky_index`](#tversky_index)
////   * [`overlap_coefficient`](#overlap_coefficient)
//// * **Basic statistical measures**
////   * [`mean`](#mean)
////   * [`median`](#median)
////   * [`variance`](#variance)
////   * [`standard_deviation`](#standard_deviation)
//// * **Tests**
////   * [`is_close`](#is_close)
////   * [`list_all_close`](#all_close)
////   * [`is_fractional`](#is_fractional)
////   * [`is_between`](#is_between)
////   * [`is_power`](#is_power)
////   * [`is_perfect`](#is_perfect)
////   * [`is_divisible`](#is_divisible)
////   * [`is_multiple`](#is_multiple)
////   * [`is_prime`](#is_prime)
//// * **Special mathematical functions**
////   * [`beta`](#beta)
////   * [`erf`](#erf)
////   * [`gamma`](#gamma)
////   * [`incomplete_gamma`](#incomplete_gamma)
////

import gleam/bool
import gleam/float
import gleam/int
import gleam/iterator
import gleam/list
import gleam/order
import gleam/pair
import gleam/result
import gleam/set

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function calculates the greatest common divisor of two integers
/// \\(x, y \in \mathbb{Z}\\). The greatest common divisor is the largest positive
/// integer that is divisible by both \\(x\\) and \\(y\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.gcd(1, 1)
///       |> should.equal(1)
///       
///       maths.gcd(100, 10)
///       |> should.equal(10)
///     
///       maths.gcd(-36, -17)
///       |> should.equal(1)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn gcd(x: Int, y: Int) -> Int {
  let absx = int.absolute_value(x)
  let absy = int.absolute_value(y)
  do_gcd(absx, absy)
}

fn do_gcd(x: Int, y: Int) -> Int {
  case x == 0 {
    True -> y
    False -> {
      let assert Ok(z) = int.modulo(y, x)
      do_gcd(z, x)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
///
/// Given two integers, \\(x\\) (dividend) and \\(y\\) (divisor), the Euclidean modulo
/// of \\(x\\) by \\(y\\), denoted as \\(x \mod y\\), is the remainder \\(r\\) of the
/// division of \\(x\\) by \\(y\\), such that:
///
/// \\[
/// x = q \cdot y + r \quad \text{and} \quad 0 \leq r < |y|,
/// \\]
///
/// where \\(q\\) is an integer that represents the quotient of the division.
///
/// The Euclidean modulo function of two numbers, is the remainder operation most
/// commonly utilized in mathematics. This differs from the standard truncating
/// modulo operation frequently employed in programming via the `%` operator.
/// Unlike the `%` operator, which may return negative results depending on the
/// divisor's sign, the Euclidean modulo function is designed to always yield a
/// positive outcome, ensuring consistency with mathematical conventions.
///
/// Note that like the Gleam division operator `/` this will return `0` if one of
/// the arguments is `0`.
///
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.int_euclidean_modulo(15, 4)
///       |> should.equal(3)
///
///       maths.int_euclidean_modulo(-3, -2)
///       |> should.equal(1)
///
///       maths.int_euclidean_modulo(5, 0)
///       |> should.equal(0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_euclidean_modulo(x: Int, y: Int) -> Int {
  case x % y, x, y {
    _, 0, _ -> 0
    _, _, 0 -> 0
    md, _, _ if md < 0 -> md + int.absolute_value(y)
    md, _, _ -> md
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function calculates the least common multiple of two integers
/// \\(x, y \in \mathbb{Z}\\). The least common multiple is the smallest positive
/// integer that has both \\(x\\) and \\(y\\) as factors.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.lcm(1, 1)
///       |> should.equal(1)
///
///       maths.lcm(100, 10)
///       |> should.equal(100)
///
///       maths.lcm(-36, -17)
///       |> should.equal(612)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn lcm(x: Int, y: Int) -> Int {
  let absx = int.absolute_value(x)
  let absy = int.absolute_value(y)
  absx * absy / do_gcd(absx, absy)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns all the positive divisors of an integer, including the
/// number itself.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.divisors(4)
///       |> should.equal([1, 2, 4])
///
///       maths.divisors(6)
///       |> should.equal([1, 2, 3, 6])
///
///       maths.divisors(13)
///       |> should.equal([1, 13])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn divisors(n: Int) -> List(Int) {
  find_divisors(n)
}

fn find_divisors(n: Int) -> List(Int) {
  let nabs = float.absolute_value(int.to_float(n))
  let assert Ok(sqrt_result) = float.square_root(nabs)
  let max = float.round(sqrt_result) + 1
  list.range(2, max)
  |> list.fold([1, n], fn(acc, i) {
    case n % i == 0 {
      True -> [i, n / i, ..acc]
      False -> acc
    }
  })
  |> list.unique()
  |> list.sort(int.compare)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns all the positive divisors of an integer, excluding the
/// number iteself.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.proper_divisors(4)
///       |> should.equal([1, 2])
///
///       maths.proper_divisors(6)
///       |> should.equal([1, 2, 3])
///
///       maths.proper_divisors(13)
///       |> should.equal([1])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn proper_divisors(n: Int) -> List(Int) {
  let divisors = find_divisors(n)
  divisors
  |> list.take(list.length(divisors) - 1)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) sum of the elements in a list:
///
/// \\[
/// \sum_{i=1}^n w_i x_i
/// \\]
///
/// In the formula, \\(n\\) is the length of the list and \\(x_i \in \mathbb{R}\\) is
/// the value in the input list indexed by \\(i\\), while the \\(w_i \in \mathbb{R}\\)
/// are corresponding weights (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
/// 
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.float_weighted_sum()
///       |> should.equal(Ok(0.0))
///   
///       [#(1.0, 1.0), #(2.0, 1.0), #(3.0, 1.0)]
///       |> maths.float_weighted_sum()
///       |> should.equal(Ok(6.0))
///   
///       [#(9.0, 0.5), #(10.0, 0.5), #(10.0, 0.5)]
///       |> maths.float_weighted_sum()
///       |> should.equal(Ok(14.5))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_weighted_sum(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  case arr {
    [] -> Ok(0.0)
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float)) { tuple.1 <. 0.0 })
      case weight_is_negative {
        True -> Error(Nil)
        False -> {
          arr
          |> list.fold(0.0, fn(acc, a) {
            pair.first(a) *. pair.second(a) +. acc
          })
          |> Ok
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) product of the elements in a list:
///
/// \\[
/// \prod_{i=1}^n x_i^{w_i}
/// \\]
///
/// In the formula, \\(n\\) is the length of the list and \\(x_i \in \mathbb{R}\\) is
/// the value in the input list indexed by \\(i\\), while the \\(w_i \in \mathbb{R}\\)
/// are corresponding weights (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
/// 
/// <details>
///     <summary>Example:</summary>
///     
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.float_weighted_product()
///       |> should.equal(Ok(1.0))
///   
///       [#(1.0, 1.0), #(2.0, 1.0), #(3.0, 1.0)]
///       |> maths.float_weighted_product()
///       |> should.equal(Ok(6.0))
///       
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///       let assert Ok(result) =
///         [#(9.0, 0.5), #(10.0, 0.5), #(10.0, 0.5)]
///         |> maths.float_weighted_product()
///       result
///       |> maths.is_close(30.0, 0.0, tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_weighted_product(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  case arr {
    [] -> 1.0 |> Ok
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float)) { tuple.1 <. 0.0 })
      case weight_is_negative {
        True -> Error(Nil)
        False -> {
          arr
          |> list.map(fn(a: #(Float, Float)) -> Result(Float, Nil) {
            pair.first(a)
            |> float.power(pair.second(a))
          })
          |> result.all
          |> result.map(fn(prods) {
            prods
            |> list.fold(1.0, fn(acc: Float, a: Float) -> Float { a *. acc })
          })
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, \\(v_j\\) is the \\(j\\)'th element in the cumulative sum of \\(n\\)
/// elements. That is, \\(n\\) is the length of the list and \\(x_i \in \mathbb{R}\\)
/// is the value in the input list indexed by \\(i\\). The value \\(v_j\\) is thus the
/// sum of the \\(1\\) to \\(j\\) first elements in the given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.float_cumulative_sum()
///       |> should.equal([])
///
///       [1.0, 2.0, 3.0]
///       |> maths.float_cumulative_sum()
///       |> should.equal([1.0, 3.0, 6.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_cumulative_sum(arr: List(Float)) -> List(Float) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(0.0, fn(acc, a) { a +. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative sum of the elements in a list:
///
/// \\[
/// v_j = \sum_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, \\(v_j\\) is the \\(j\\)'th element in the cumulative sum of \\(n\\)
/// elements. That is, \\(n\\) is the length of the list and \\(x_i \in \mathbb{Z}\\)
/// is the value in the input list indexed by \\(i\\). The value \\(v_j\\) is thus the
/// sum of the \\(1\\) to \\(j\\) first elements in the given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.int_cumulative_sum()
///       |> should.equal([])
///
///       [1, 2, 3]
///       |> maths.int_cumulative_sum()
///       |> should.equal([1, 3, 6])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_cumulative_sum(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(0, fn(acc, a) { a + acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, \\(v_j\\) is the \\(j\\)'th element in the cumulative product of
/// \\(n\\) elements. That is, \\(n\\) is the length of the list and
/// \\(x_i \in \mathbb{R}\\) is the value in the input list indexed by \\(i\\). The
/// value \\(v_j\\) is thus the sum of the \\(1\\) to \\(j\\) first elements in the
/// given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.float_cumulative_product()
///       |> should.equal([])
///
///       [1.0, 2.0, 3.0]
///       |> maths.float_cumulative_product()
///       |> should.equal([1.0, 2.0, 6.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_cumulative_product(arr: List(Float)) -> List(Float) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(1.0, fn(acc, a) { a *. acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the cumulative product of the elements in a list:
///
/// \\[
/// v_j = \prod_{i=1}^j x_i \\;\\; \forall j = 1,\dots, n
/// \\]
///
/// In the formula, \\(v_j\\) is the \\(j\\)'th element in the cumulative product of
/// \\(n\\) elements. That is, \\(n\\) is the length of the list and
/// \\(x_i \in \mathbb{Z}\\) is the value in the input list indexed by \\(i\\). The
/// value \\(v_j\\) is thus the product of the \\(1\\) to \\(j\\) first elements in the
/// given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.int_cumulative_product()
///       |> should.equal([])
///
///       [1, 2, 3]
///       |> maths.int_cumulative_product()
///       |> should.equal([1, 2, 6])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_cumulative_product(arr: List(Int)) -> List(Int) {
  case arr {
    [] -> []
    _ ->
      arr
      |> list.scan(1, fn(acc, a) { a * acc })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Convert a value in degrees to a value measured in radians.
/// That is, \\(1 \text{ degrees } = \frac{\pi}{180} \text{ radians }\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.degrees_to_radians(360.)
///       |> should.equal(2. *. maths.pi())
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn degrees_to_radians(x: Float) -> Float {
  x *. do_pi() /. 180.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Convert a value in degrees to a value measured in radians.
/// That is, \\(1 \text{ radians } = \frac{180}{\pi} \text{ degrees }\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.radians_to_degrees(0.0)
///       |> should.equal(0.0)
///
///       maths.radians_to_degrees(2. *. maths.pi())
///       |> should.equal(360.)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn radians_to_degrees(x: Float) -> Float {
  x *. 180.0 /. do_pi()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse cosine function:
///
/// \\[
/// \forall x \in \[-1, 1\],   \\; \cos^{-1}{(x)} = y \in \[0, \pi \]
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\[-1, 1\]\\) as input and returns a
/// numeric value \\(y\\) that lies in the range \\(\[0, \pi \]\\) (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.acos(1.0)
///       |> should.equal(Ok(0.0))
///
///       maths.acos(1.1)
///       |> should.be_error()
///
///       maths.acos(-1.1)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn acos(x: Float) -> Result(Float, Nil) {
  case x >=. -1.0 && x <=. 1.0 {
    True -> Ok(do_acos(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "acos")
@external(javascript, "../maths.mjs", "acos")
fn do_acos(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse hyperbolic cosine function:
///
/// \\[
/// \forall x \in [1, +\infty\),   \\; \cosh^{-1}{(x)} = y \in \[0, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\[1, +\infty\)\\) as input and returns
/// a numeric value \\(y\\) that lies in the range \\(\[0, +\infty\)\\) (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.acosh(1.0)
///       |> should.equal(Ok(0.0))
///
///       maths.acosh(0.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn acosh(x: Float) -> Result(Float, Nil) {
  case x >=. 1.0 {
    True -> Ok(do_acosh(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "acosh")
@external(javascript, "../maths.mjs", "acosh")
fn do_acosh(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse sine function:
///
/// \\[
/// \forall x \in \[-1, 1\],   \\; \sin^{-1}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\[-1, 1\]\\) as input and returns a numeric
/// value \\(y\\) that lies in the range \\(\[-\frac{\pi}{2}, \frac{\pi}{2}\]\\) (an angle in
/// radians). If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.asin(0.0)
///       |> should.equal(Ok(0.0))
///
///       maths.asin(1.1)
///       |> should.be_error()
///
///       maths.asin(-1.1)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn asin(x: Float) -> Result(Float, Nil) {
  case x >=. -1.0 && x <=. 1.0 {
    True -> Ok(do_asin(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "asin")
@external(javascript, "../maths.mjs", "asin")
fn do_asin(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse hyperbolic sine function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \sinh^{-1}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, +\infty\)\\) as input and
/// returns a numeric value \\(y\\) that lies in the range \\(\(-\infty, +\infty\)\\) (an angle in
/// radians).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.asinh(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn asinh(x: Float) -> Float {
  do_asinh(x)
}

@external(erlang, "math", "asinh")
@external(javascript, "../maths.mjs", "asinh")
fn do_asinh(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse tangent function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),  \\; \tan^{-1}{(x)} = y \in \[-\frac{\pi}{2}, \frac{\pi}{2}\]
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, +\infty\)\\) as input and
/// returns a numeric value \\(y\\) that lies in the range \\(\[-\frac{\pi}{2}, \frac{\pi}{2}\]\\)
/// (an angle in radians).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.atan(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn atan(x: Float) -> Float {
  do_atan(x)
}

@external(erlang, "math", "atan")
@external(javascript, "../maths.mjs", "atan")
fn do_atan(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse 2-argument tangent function:
///
/// \\[
/// \text{atan2}(y, x) =
/// \begin{cases}
///  \tan^{-1}(\frac y x) &\text{if } x > 0, \\\\
///  \tan^{-1}(\frac y x) + \pi &\text{if } x < 0 \text{ and } y \ge 0, \\\\
///  \tan^{-1}(\frac y x) - \pi &\text{if } x < 0 \text{ and } y < 0, \\\\
///  +\frac{\pi}{2} &\text{if } x = 0 \text{ and } y > 0, \\\\
///  -\frac{\pi}{2} &\text{if } x = 0 \text{ and } y < 0, \\\\
///  \text{undefined} &\text{if } x = 0 \text{ and } y = 0.
/// \end{cases}
/// \\]
///
/// The function returns the angle in radians from the x-axis to the line containing the
/// origin \\(\(0, 0\)\\) and a point given as input with coordinates \\(\(x, y\)\\). The numeric
/// value returned by \\(\text{atan2}(y, x)\\) is in the range \\(\[-\pi, \pi\]\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.atan2(0.0, 0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn atan2(y: Float, x: Float) -> Float {
  do_atan2(y, x)
}

@external(erlang, "math", "atan2")
@external(javascript, "../maths.mjs", "atan2")
fn do_atan2(a: Float, b: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The inverse hyperbolic tangent function:
///
/// \\[
/// \forall x \in \(-1, 1\),   \\; \tanh^{-1}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-1, 1\)\\) as input and returns
/// a numeric value \\(y\\) that lies in the range \\(\(-\infty, \infty\)\\) (an angle in radians).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.atanh(0.0)
///       |> should.equal(Ok(0.0))
///
///       maths.atanh(1.0)
///       |> should.be_error()
///
///       maths.atanh(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn atanh(x: Float) -> Result(Float, Nil) {
  case x >. -1.0 && x <. 1.0 {
    True -> Ok(do_atanh(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "atanh")
@external(javascript, "../maths.mjs", "atanh")
fn do_atanh(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The cosine function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \cos{(x)} = y \in \[-1, 1\]
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, \infty\)\\) (an angle in
/// radians) as input and returns a numeric value \\(y\\) that lies in the range \\(\[-1, 1\]\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.cos(0.0)
///       |> should.equal(1.0)
///
///       maths.cos(maths.pi())
///       |> should.equal(-1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cos(x: Float) -> Float {
  do_cos(x)
}

@external(erlang, "math", "cos")
@external(javascript, "../maths.mjs", "cos")
fn do_cos(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The hyperbolic cosine function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \cosh{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, \infty\)\\) as input (an angle
/// in radians) and returns a numeric value \\(y\\) that lies in the range
/// \\(\(-\infty, \infty\)\\). If the input value is too large an overflow error might occur.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.cosh(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cosh(x: Float) -> Float {
  do_cosh(x)
}

@external(erlang, "math", "cosh")
@external(javascript, "../maths.mjs", "cosh")
fn do_cosh(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The sine function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \sin{(x)} = y \in \[-1, 1\]
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, \infty\)\\) (an angle in
/// radians) as input and returns a numeric value \\(y\\) that lies in the range \\(\[-1, 1\]\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.sin(0.0)
///       |> should.equal(0.0)
///
///       maths.sin(0.5 *. maths.pi())
///       |> should.equal(1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sin(x: Float) -> Float {
  do_sin(x)
}

@external(erlang, "math", "sin")
@external(javascript, "../maths.mjs", "sin")
fn do_sin(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The hyperbolic sine function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \sinh{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, +\infty\)\\) as input
/// (an angle in radians) and returns a numeric value \\(y\\) that lies in the range
/// \\(\(-\infty, +\infty\)\\). If the input value is too large an overflow error might occur.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.sinh(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sinh(x: Float) -> Float {
  do_sinh(x)
}

@external(erlang, "math", "sinh")
@external(javascript, "../maths.mjs", "sinh")
fn do_sinh(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The tangent function:
///
/// \\[
/// \forall x \in \(-\infty, +\infty\),   \\; \tan{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, +\infty\)\\) as input
/// (an angle in radians) and returns a numeric value \\(y\\) that lies in the range
/// \\(\(-\infty, +\infty\)\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.tan(0.0)
///       |> should.equal(0.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tan(x: Float) -> Float {
  do_tan(x)
}

@external(erlang, "math", "tan")
@external(javascript, "../maths.mjs", "tan")
fn do_tan(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The hyperbolic tangent function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; \tanh{(x)} = y \in \[-1, 1\]
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(-\infty, \infty\)\\) as input (an angle
/// in radians) and returns a numeric value \\(y\\) that lies in the range \\(\[-1, 1\]\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       maths.tanh(0.0)
///       |> should.equal(0.0)
///
///       maths.tanh(25.0)
///       |> should.equal(1.0)
///
///       maths.tanh(-25.0)
///       |> should.equal(-1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tanh(x: Float) -> Float {
  do_tanh(x)
}

@external(erlang, "math", "tanh")
@external(javascript, "../maths.mjs", "tanh")
fn do_tanh(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The exponential function:
///
/// \\[
/// \forall x \in \(-\infty, \infty\),   \\; e^{(x)} = y \in \(0, +\infty\)
/// \\]
///
/// \\(e \approx 2.71828\dots\\) is Eulers' number.
///
/// Note: If the input value \\(x\\) is too large an overflow error might occur.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.exponential(0.0)
///       |> should.equal(1.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn exponential(x: Float) -> Float {
  do_exponential(x)
}

@external(erlang, "math", "exp")
@external(javascript, "../maths.mjs", "exponential")
fn do_exponential(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The natural logarithm function:
///
/// \\[
/// \forall x \in \(0, \infty\),   \\; \log_{e}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(0, \infty\)\\) as input and returns
/// a numeric value \\(y\\) that lies in the range \\(\(-\infty, \infty\)\\).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       maths.natural_logarithm(1.0)
///       |> should.equal(Ok(0.0))
///
///       maths.natural_logarithm(maths.e())
///       |> should.equal(Ok(1.0))
///
///       maths.natural_logarithm(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn natural_logarithm(x: Float) -> Result(Float, Nil) {
  case x >. 0.0 {
    True -> Ok(do_natural_logarithm(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "log")
@external(javascript, "../maths.mjs", "logarithm")
fn do_natural_logarithm(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The base \\(b\\) logarithm function (computed through the "change of base" formula):
///
/// \\[
/// \forall x \in \(0, \infty\) \textnormal{ and } b > 1,  \\; \log_{b}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(0, \infty\)\\) and a base \\(b > 1\\)
/// as input and returns a numeric value \\(y\\) that lies in the range \\(\(-\infty, \infty\)\\).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       maths.logarithm(1.0, 10.0)
///       |> should.equal(Ok(0.0))
///     
///       maths.logarithm(maths.e(), maths.e())
///       |> should.equal(Ok(1.0))
///     
///       maths.logarithm(-1.0, 2.0)
///       |> should.be_error()
///     }
/// </details>
///
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm(x: Float, base: Float) -> Result(Float, Nil) {
  case x >. 0.0 {
    True ->
      case base >. 0.0 && base != 1.0 {
        False -> Error(Nil)
        True -> {
          // Apply the "change of base formula"
          let assert Ok(numerator) = logarithm_10(x)
          let assert Ok(denominator) = logarithm_10(base)
          Ok(numerator /. denominator)
        }
      }
    _ -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The The base-2 logarithm function:
///
/// \\[
/// \forall x \in \(0, \infty),   \\; \log_{2}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(0, \infty\)\\) as input and returns a
/// numeric value \\(y\\) that lies in the range \\(\(-\infty, \infty\)\\).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       maths.logarithm_2(1.0)
///       |> should.equal(Ok(0.0))
///
///       maths.logarithm_2(2.0)
///       |> should.equal(Ok(1.0))
///
///       maths.logarithm_2(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm_2(x: Float) -> Result(Float, Nil) {
  case x >. 0.0 {
    True -> Ok(do_logarithm_2(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "log2")
@external(javascript, "../maths.mjs", "logarithm_2")
fn do_logarithm_2(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The base-10 logarithm function:
///
/// \\[
/// \forall x \in \(0, \infty),   \\; \log_{10}{(x)} = y \in \(-\infty, +\infty\)
/// \\]
///
/// The function takes a number \\(x\\) in its domain \\(\(0, \infty\)\\) as input and returns a
/// numeric value \\(y\\) that lies in the range \\(\(-\infty, \infty\)\\).
/// If the input value is outside the domain of the function an error is returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       maths.logarithm_10(1.0)
///       |> should.equal(Ok(0.0))
///
///       maths.logarithm_10(10.0)
///       |> should.equal(Ok(1.0))
///
///       maths.logarithm_10(-1.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn logarithm_10(x: Float) -> Result(Float, Nil) {
  case x >. 0.0 {
    True -> Ok(do_logarithm_10(x))
    False -> Error(Nil)
  }
}

@external(erlang, "math", "log10")
@external(javascript, "../maths.mjs", "logarithm_10")
fn do_logarithm_10(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The \\(n\\)'th root function: \\(y = \sqrt[n]{x} = x^{\frac{1}{n}}\\).
///
/// Note that the function is not defined if:
/// 1. The input is negative (\\(x < 0\\)). An error will be returned
///    as an imaginary number will otherwise have to be returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.nth_root(-1.0, 2)
///       |> should.be_error()
/// 
///       maths.nth_root(1.0, 2)
///       |> should.equal(Ok(1.0))
///
///       maths.nth_root(27.0, 3)
///       |> should.equal(Ok(3.0))
///
///       maths.nth_root(256.0, 4)
///       |> should.equal(Ok(4.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn nth_root(x: Float, n: Int) -> Result(Float, Nil) {
  // In the following check:
  // 1. If x is negative then return an error as it will otherwise be an
  // imaginary number
  case x >=. 0.0 && n >= 1 {
    True -> float.power(x, 1.0 /. int.to_float(n))
    False -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The mathematical constant pi: \\(\pi \approx 3.1415\dots\\)
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn pi() -> Float {
  do_pi()
}

@external(erlang, "math", "pi")
@external(javascript, "../maths.mjs", "pi")
fn do_pi() -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The mathematical constant tau: \\(\tau = 2 \cdot \pi \approx 6.283\dots\\)
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tau() -> Float {
  2.0 *. pi()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Euler's number \\(e \approx 2.71828\dots\\).
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///     
///       // Test that the constant is approximately equal to 2.7128...
///       maths.e()
///       |> maths.is_close(2.7182818284590452353602, 0.0, tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn e() -> Float {
  exponential(1.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before
/// if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundNearest` (default): The input \\(x\\) is rounded to the nearest integer value (at the
///   specified digit) with ties (fractional values of 0.5) being rounded to the nearest even
///   integer.
///
/// <details>
/// <summary>Details</summary>
///
///   The `RoundNearest` rounding mode, rounds \\(12.0654\\) to:
///   - \\(12.0\\) for 0 digits after the decimal point (`digits = 0`)
///   - \\(12.1\\) for 1 digit after the decimal point (`digits = 1`)
///   - \\(12.07\\) for 2 digits after the decimal point (`digits = 2`)
///   - \\(12.065\\) for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative
///   number refers to the digits before the decimal point.
///   - \\(10.0\\) for 1 digit before the decimal point (`digits = -1`)
///   - \\(0.0\\) for 2 digits before the decimal point (`digits = -2`)
///   - \\(0.0\\) for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.round_to_nearest(12.0654, 2)
///       |> should.equal(12.07)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round_to_nearest(x: Float, p: Int) -> Float {
  let assert Ok(p) = float.power(10.0, int.to_float(p))
  let xabs = float.absolute_value(x) *. p
  let xabs_truncated = truncate_float(xabs)
  let remainder = xabs -. xabs_truncated
  case remainder {
    _ if remainder >. 0.5 -> float_sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ if remainder == 0.5 -> {
      let assert Ok(is_even) = int.modulo(float.truncate(xabs), 2)
      case is_even == 0 {
        True -> float_sign(x) *. xabs_truncated /. p
        False -> float_sign(x) *. truncate_float(xabs +. 1.0) /. p
      }
    }
    _ -> float_sign(x) *. xabs_truncated /. p
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before
/// if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundTiesAway`: The input \\(x\\) is rounded to the nearest integer value (at the
///    specified digit) with ties (fractional values of 0.5) being rounded away from zero (C/C++
///   rounding behavior).
/// - `RoundTiesUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) with ties (fractional values of 0.5) being rounded towards \\(+\infty\\)
///   (Java/JavaScript rounding behaviour).
/// - `RoundToZero`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///    digit) that is less than or equal to the absolute value of the input \\(x\\). An alias for
///    this rounding mode is [`truncate`](#truncate).
/// - `RoundDown`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is less than or equal to the input \\(x\\). An alias for this rounding mode is
///    [`floor`](#floor).
/// - `RoundUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is larger than or equal to the input \\(x\\). An alias for this rounding mode
///   is [`ceiling`](#ceiling).
///
/// <details>
/// <summary>Details</summary>
///
///   The `RoundTiesAway` rounding mode, rounds \\(12.0654\\) to:
///   - \\(12.0\\) for 0 digits after the decimal point (`digits = 0`)
///   - \\(12.1\\) for 1 digit after the decimal point (`digits = 1`)
///   - \\(12.07\\) for 2 digits after the decimal point (`digits = 2`)
///   - \\(12.065\\) for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative
///   number refers to the digits before the decimal point.
///   - \\(10.0\\) for 1 digit before the decimal point (`digits = -1`)
///   - \\(0.0\\) for 2 digits before the decimal point (`digits = -2`)
///   - \\(0.0\\) for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.round_ties_away(12.0654, 2)
///       |> should.equal(12.07)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round_ties_away(x: Float, p: Int) -> Float {
  let assert Ok(p) = float.power(10.0, int.to_float(p))
  let xabs = float.absolute_value(x) *. p
  let remainder = xabs -. truncate_float(xabs)
  case remainder {
    _ if remainder >=. 0.5 -> float_sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ -> float_sign(x) *. truncate_float(xabs) /. p
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before
/// if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundTiesUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) with ties (fractional values of 0.5) being rounded towards \\(+\infty\\)
///   (Java/JavaScript rounding behaviour).
/// - `RoundToZero`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///    digit) that is less than or equal to the absolute value of the input \\(x\\). An alias for
///    this rounding mode is [`truncate`](#truncate).
/// - `RoundDown`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is less than or equal to the input \\(x\\). An alias for this rounding mode is
///    [`floor`](#floor).
/// - `RoundUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is larger than or equal to the input \\(x\\). An alias for this rounding mode
///   is [`ceiling`](#ceiling).
///
/// <details>
/// <summary>Details</summary>
///
///   The `RoundTiesUp` rounding mode, rounds \\(12.0654\\) to:
///   - \\(12.0\\) for 0 digits after the decimal point (`digits = 0`)
///   - \\(12.1\\) for 1 digits after the decimal point (`digits = 1`)
///   - \\(12.07\\) for 2 digits after the decimal point (`digits = 2`)
///   - \\(12.065\\) for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative
///    number refers to the digits before the decimal point.
///   - \\(10.0\\) for 1 digit before the decimal point (`digits = -1`)
///   - \\(0.0\\) for 2 digits before the decimal point (`digits = -2`)
///   - \\(0.0\\) for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.round_ties_up(12.0654, 2)
///       |> should.equal(12.07)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round_ties_up(x: Float, p: Int) -> Float {
  let assert Ok(p) = float.power(10.0, int.to_float(p))
  let xabs = float.absolute_value(x) *. p
  let xabs_truncated = truncate_float(xabs)
  let remainder = xabs -. xabs_truncated
  case remainder {
    _ if remainder >=. 0.5 && x >=. 0.0 ->
      float_sign(x) *. truncate_float(xabs +. 1.0) /. p
    _ -> float_sign(x) *. xabs_truncated /. p
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before
/// if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundToZero`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///    digit) that is less than or equal to the absolute value of the input \\(x\\). An alias for
///    this rounding mode is [`truncate`](#truncate).
/// - `RoundDown`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is less than or equal to the input \\(x\\). An alias for this rounding mode is
///    [`floor`](#floor).
/// - `RoundUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is larger than or equal to the input \\(x\\). An alias for this rounding mode
///   is [`ceiling`](#ceiling).
///
/// <details>
/// <summary>Details</summary>
///
///   The `RoundToZero` rounding mode, rounds \\(12.0654\\) to:
///   - \\(12.0\\) for 0 digits after the decimal point (`digits = 0`)
///   - \\(12.0\\) for 1 digit after the decimal point (`digits = 1`)
///   - \\(12.06\\) for 2 digits after the decimal point (`digits = 2`)
///   - \\(12.065\\) for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative
///   number refers to the digits before the decimal point.
///   - \\(10.0\\) for 1 digit before the decimal point (`digits = -1`)
///   - \\(0.0\\) for 2 digits before the decimal point (`digits = -2`)
///   - \\(0.0\\) for 3 digits before the decimal point (`digits = -3`)
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.round_to_zero(12.0654, 2)
///       |> should.equal(12.06)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round_to_zero(x: Float, p: Int) -> Float {
  let assert Ok(p) = float.power(10.0, int.to_float(p))
  truncate_float(x *. p) /. p
}

fn truncate_float(x: Float) -> Float {
  do_truncate_float(x)
}

@external(erlang, "erlang", "trunc")
@external(javascript, "../maths.mjs", "truncate")
fn do_truncate_float(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before
/// if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundNearest` (default): The input \\(x\\) is rounded to the nearest integer value (at the
///   specified digit) with ties (fractional values of 0.5) being rounded to the nearest even
///   integer.
/// - `RoundTiesAway`: The input \\(x\\) is rounded to the nearest integer value (at the
///    specified digit) with ties (fractional values of 0.5) being rounded away from zero (C/C++
///   rounding behavior).
/// - `RoundTiesUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) with ties (fractional values of 0.5) being rounded towards \\(+\infty\\)
///   (Java/JavaScript rounding behaviour).
/// - `RoundToZero`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///    digit) that is less than or equal to the absolute value of the input \\(x\\). An alias for
///    this rounding mode is [`truncate`](#truncate).
/// - `RoundDown`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is less than or equal to the input \\(x\\). An alias for this rounding mode is
///    [`floor`](#floor).
/// - `RoundUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is larger than or equal to the input \\(x\\). An alias for this rounding mode
///   is [`ceiling`](#ceiling).
///
/// <details>
/// <summary>Details</summary>
///   The `RoundDown` rounding mode, rounds \\(12.0654\\) to:
///   - \\(12.0\\) for 0 digits after the decimal point (`digits = 0`)
///   - \\(12.0\\) for 1 digits after the decimal point (`digits = 1`)
///   - \\(12.06\\) for 2 digits after the decimal point (`digits = 2`)
///   - \\(12.065\\) for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative
///   number refers to the digits before the decimal point.
///   - \\(10.0\\) for 1 digit before the decimal point (`digits = -1`)
///   - \\(0.0\\) for 2 digits before the decimal point (`digits = -2`)
///   - \\(0.0\\) for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.round_down(12.0654, 2)
///       |> should.equal(12.06)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round_down(x: Float, p: Int) -> Float {
  let assert Ok(p) = float.power(10.0, int.to_float(p))
  do_floor(x *. p) /. p
}

@external(erlang, "math", "floor")
@external(javascript, "../maths.mjs", "floor")
fn do_floor(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function rounds a float to a specific number of digits (after the decimal place or before
/// if negative) using a specified rounding mode.
///
/// Valid rounding modes include:
/// - `RoundUp`: The input \\(x\\) is rounded to the nearest integer value (at the specified
///   digit) that is larger than or equal to the input \\(x\\). An alias for this rounding mode
///   is [`ceiling`](#ceiling).
///
/// <details>
/// <summary>Details</summary>
///   The `RoundUp` rounding mode, rounds \\(12.0654\\) to:
///   - \\(13.0\\) for 0 digits after the decimal point (`digits = 0`)
///   - \\(12.1\\) for 1 digit after the decimal point (`digits = 1`)
///   - \\(12.07\\) for 2 digits after the decimal point (`digits = 2`)
///   - \\(12.066\\) for 3 digits after the decimal point (`digits = 3`)
///
///   It is also possible to specify a negative number of digits. In that case, the negative
///   number refers to the digits before the decimal point.
///   - \\(20.0\\) for 1 digit places before the decimal point (`digit = -1`)
///   - \\(100.0\\) for 2 digits before the decimal point (`digits = -2`)
///   - \\(1000.0\\) for 3 digits before the decimal point (`digits = -3`)
///
/// </details>
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.round_up(12.0654, 2)
///       |> should.equal(12.07)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn round_up(x: Float, p: Int) -> Float {
  let assert Ok(p) = float.power(10.0, int.to_float(p))
  do_ceiling(x *. p) /. p
}

@external(erlang, "math", "ceil")
@external(javascript, "../maths.mjs", "ceiling")
fn do_ceiling(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The absolute difference:
///
/// \\[
///  \forall x, y \in \mathbb{R}, \\; |x - y|  \in \mathbb{R}_{+}.
/// \\]
///
/// The function takes two inputs \\(x\\) and \\(y\\) and returns a positive float
/// value which is the the absolute difference of the inputs.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.float_absolute_difference(-10.0, 10.0)
///       |> should.equal(20.0)
///
///       maths.float_absolute_difference(0.0, -2.0)
///       |> should.equal(2.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_absolute_difference(a: Float, b: Float) -> Float {
  a -. b
  |> float.absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The absolute difference:
///
/// \\[
///  \forall x, y \in \mathbb{Z}, \\; |x - y|  \in \mathbb{Z}_{+}.
/// \\]
///
/// The function takes two inputs \\(x\\) and \\(y\\) and returns a positive integer
/// value which is the the absolute difference of the inputs.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.absolute_difference(-10, 10)
///       |> should.equal(20)
///
///       maths.absolute_difference(0, -2)
///       |> should.equal(2)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_absolute_difference(a: Int, b: Int) -> Int {
  a - b
  |> int.absolute_value()
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes an input \\(x \in \mathbb{R}\\) and returns the sign of
/// the input, indicating whether it is positive (+1.0), negative (-1.0), or
/// zero (0.0).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_sign(x: Float) -> Float {
  do_float_sign(x)
}

@target(erlang)
fn do_float_sign(x: Float) -> Float {
  case x <. 0.0 {
    True -> -1.0
    False ->
      case x == 0.0 {
        True -> 0.0
        False -> 1.0
      }
  }
}

@target(javascript)
@external(javascript, "../maths.mjs", "sign")
fn do_float_sign(a: Float) -> Float

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes an input \\(x \in \mathbb{Z}\\) and returns the sign of
/// the input, indicating whether it is positive (+1), negative (-1), or zero
/// (0).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_sign(x: Int) -> Int {
  do_int_sign(x)
}

@target(erlang)
fn do_int_sign(x: Int) -> Int {
  case x < 0 {
    True -> -1
    False ->
      case x == 0 {
        True -> 0
        False -> 1
      }
  }
}

@target(javascript)
@external(javascript, "../maths.mjs", "sign")
fn do_int_sign(a: Int) -> Int

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes two arguments \\(x, y \in \mathbb{R}\\) and returns \\(x\\)
/// such that it has the same sign as \\(y\\).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_copy_sign(x: Float, y: Float) -> Float {
  case float_sign(x) == float_sign(y) {
    // x and y have the same sign, just return x
    True -> x
    // x and y have different signs:
    // - x is positive and y is negative, then flip sign of x
    // - x is negative and y is positive, then flip sign of x
    False -> float_flip_sign(x)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function takes two arguments \\(x, y \in \mathbb{Z}\\) and returns \\(x\\)
/// such that it has the same sign as \\(y\\).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_copy_sign(x: Int, y: Int) -> Int {
  case int_sign(x) == int_sign(y) {
    // x and y have the same sign, just return x
    True -> x
    // x and y have different signs:
    // - x is positive and y is negative, then flip sign of x
    // - x is negative and y is positive, then flip sign of x
    False -> int_flip_sign(x)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function flips the sign of a given input value \\(x \in \mathbb{R}\\).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn float_flip_sign(x: Float) -> Float {
  -1.0 *. x
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function flips the sign of a given input value \\(x \in \mathbb{Z}\\).
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn int_flip_sign(x: Int) -> Int {
  -1 * x
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The minmax function takes two arguments \\(x, y\\) along with a function
/// for comparing \\(x, y\\). The function returns a tuple with the smallest
/// value first and largest second.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.minmax(2.0, 1.5, float.compare)
///       |> should.equal(#(1.5, 2.0))
///
///       maths.minmax(1.5, 2.0, float.compare)
///       |> should.equal(#(1.5, 2.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
// pub fn minmax(x: a, y: a, compare: fn(a, a) -> order.Order) {
//   #(minimum(x, y, compare), maximum(x, y, compare))
// }
// TODO

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the minimum value of a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/int
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.list_minimum(int.compare)
///       |> should.be_error()
///
///       [4, 4, 3, 2, 1]
///       |> maths.list_minimum(int.compare)
///       |> should.equal(Ok(1))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
pub fn list_minimum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(a, Nil) {
  case arr {
    [] -> Error(Nil)
    [x, ..rest] ->
      Ok(
        list.fold(rest, x, fn(acc, element) {
          case compare(element, acc) {
            order.Lt -> element
            _ -> acc
          }
        }),
      )
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the maximum value of a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.list_maximum(float.compare)
///       |> should.be_error()
///
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> maths.list_maximum(float.compare)
///       |> should.equal(Ok(4.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn list_maximum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(a, Nil) {
  case arr {
    [] -> Error(Nil)
    [x, ..rest] ->
      Ok(
        list.fold(rest, x, fn(acc, element) {
          case compare(acc, element) {
            order.Lt -> element
            _ -> acc
          }
        }),
      )
  }
}

/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the indices of the minimum values in a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.arg_minimum(float.compare)
///       |> should.be_error()
///
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> maths.arg_minimum(float.compare)
///       |> should.equal(Ok([4]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn arg_minimum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(List(Int), Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let assert Ok(min) =
        arr
        |> list_minimum(compare)
      arr
      |> list.index_map(fn(element, index) {
        case compare(element, min) {
          order.Eq -> index
          _ -> -1
        }
      })
      |> list.filter(fn(index) {
        case index {
          -1 -> False
          _ -> True
        }
      })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns the indices of the maximum values in a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.arg_maximum(float.compare)
///       |> should.be_error()
///
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> maths.arg_maximum(float.compare)
///       |> should.equal(Ok([0, 1]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn arg_maximum(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(List(Int), Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let assert Ok(max) =
        arr
        |> list_maximum(compare)
      arr
      |> list.index_map(fn(element, index) {
        case compare(element, max) {
          order.Eq -> index
          _ -> -1
        }
      })
      |> list.filter(fn(index) {
        case index {
          -1 -> False
          _ -> True
        }
      })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Returns a tuple consisting of the minimum and maximum values of a given list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/float
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.extrema(float.compare)
///       |> should.be_error()
///
///       [4.0, 4.0, 3.0, 2.0, 1.0]
///       |> maths.extrema(float.compare)
///       |> should.equal(Ok(#(1.0, 4.0)))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn extrema(
  arr: List(a),
  compare: fn(a, a) -> order.Order,
) -> Result(#(a, a), Nil) {
  case arr {
    [] -> Error(Nil)
    [x, ..rest] ->
      Ok(
        list.fold(rest, #(x, x), fn(acc, element) {
          let first = pair.first(acc)
          let second = pair.second(acc)
          case compare(element, first), compare(second, element) {
            order.Lt, order.Lt -> #(element, element)
            order.Lt, _ -> #(element, second)
            _, order.Lt -> #(first, element)
            _, _ -> #(first, second)
          }
        }),
      )
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of \\(k\\)-combinations of \\(n\\) elements.
///
/// **Without Repetitions:**
///
/// \\[
/// C(n, k) = \binom{n}{k} = \frac{n!}{k! (n-k)!}
/// \\]
/// Also known as "\\(n\\) choose \\(k\\)" or the binomial coefficient.
///
/// **With Repetitions:**
///
/// \\[
/// C^*(n, k) = \binom{n + k - 1}{k} = \frac{(n + k - 1)!}{k! (n - 1)!}
/// \\]
/// Also known as the "stars and bars" problem in maths.
///
/// The implementation uses an efficient iterative multiplicative formula for computing the result.
///
/// <details>
/// <summary>Details</summary>
///
/// A \\(k\\)-combination is a sequence of \\(k\\) elements selected from \\(n\\) elements where
/// the order of selection does not matter. For example, consider selecting 2 elements from a list
/// of 3 elements: `["A", "B", "C"]`:
///
/// - For \\(k\\)-combinations (without repetitions), where order does not matter, the possible
///   selections are:
///   - `["A", "B"]`
///   - `["A", "C"]`
///   - `["B", "C"]`
///
/// - For \\(k\\)-combinations (with repetitions), where order does not matter but elements can
///   repeat, the possible selections are:
///   - `["A", "A"], ["A", "B"], ["A", "C"]`
///   - `["B", "B"], ["B", "C"], ["C", "C"]`
///
/// - On the contrary, for \\(k\\)-permutations (without repetitions), the order matters, so the
///   possible selections are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
/// </details>
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.combination_with_repetitions(-1, 1)
///       |> should.be_error()
///
///       maths.combination_with_repetitions(2, 3)
///       |> should.equal(Ok(4))
///     
///       maths.combination_with_repetitions(13, 5)
///       |> should.equal(Ok(6188))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn combination_with_repetitions(n: Int, k: Int) -> Result(Int, Nil) {
  combination(n + k - 1, k)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of \\(k\\)-combinations of \\(n\\) elements.
///
/// **Without Repetitions:**
///
/// \\[
/// C(n, k) = \binom{n}{k} = \frac{n!}{k! (n-k)!}
/// \\]
/// Also known as "\\(n\\) choose \\(k\\)" or the binomial coefficient.
///
/// **With Repetitions:**
///
/// \\[
/// C^*(n, k) = \binom{n + k - 1}{k} = \frac{(n + k - 1)!}{k! (n - 1)!}
/// \\]
/// Also known as the "stars and bars" problem in maths.
///
/// The implementation uses an efficient iterative multiplicative formula for computing the result.
///
/// <details>
/// <summary>Details</summary>
///
/// A \\(k\\)-combination is a sequence of \\(k\\) elements selected from \\(n\\) elements where
/// the order of selection does not matter. For example, consider selecting 2 elements from a list
/// of 3 elements: `["A", "B", "C"]`:
///
/// - For \\(k\\)-combinations (without repetitions), where order does not matter, the possible
///   selections are:
///   - `["A", "B"]`
///   - `["A", "C"]`
///   - `["B", "C"]`
///
/// - For \\(k\\)-combinations (with repetitions), where order does not matter but elements can
///   repeat, the possible selections are:
///   - `["A", "A"], ["A", "B"], ["A", "C"]`
///   - `["B", "B"], ["B", "C"], ["C", "C"]`
///
/// - On the contrary, for \\(k\\)-permutations (without repetitions), the order matters, so the
///   possible selections are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
/// </details>
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.combination(-1, 1)
///       |> should.be_error()
///     
///       maths.combination(4, 0)
///       |> should.equal(Ok(1))
///     
///       maths.combination(4, 4)
///       |> should.equal(Ok(1))
///     
///       maths.combination(13, 5)
///       |> should.equal(Ok(1287))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn combination(n: Int, k: Int) -> Result(Int, Nil) {
  case n, k {
    _, _ if n < 0 -> Error(Nil)
    _, _ if k < 0 -> Error(Nil)
    _, _ if k == 0 || k == n -> {
      1 |> Ok
    }
    _, _ -> {
      let min = case k < n - k {
        True -> k
        False -> n - k
      }
      list.range(1, min)
      |> list.fold(1, fn(acc, x) { acc * { n + 1 - x } / x })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the total number of combinations of \\(n\\)
/// elements, that is \\(n!\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.factorial(-1)
///       |> should.be_error()
///     
///       maths.factorial(0)
///       |> should.equal(Ok(1))
///     
///       maths.factorial(3)
///       |> should.equal(Ok(6))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn factorial(n) -> Result(Int, Nil) {
  case n {
    _ if n < 0 -> Error(Nil)
    0 -> Ok(1)
    1 -> Ok(1)
    _ ->
      list.range(1, n)
      |> list.fold(1, fn(acc, x) { acc * x })
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of \\(k\\)-permutations.
///
/// **Without** repetitions:
///
/// \\[
/// P(n, k) = \binom{n}{k} \cdot k! = \frac{n!}{(n - k)!}
/// \\]
///
/// **With** repetitions:
///
/// \\[
/// P^*(n, k) = n^k
/// \\]
///
/// The implementation uses an efficient iterative multiplicative formula for computing the result.
///
/// <details>
/// <summary>Details</summary>
///
/// A \\(k\\)-permutation (without repetitions) is a sequence of \\(k\\) elements selected from \
/// \\(n\\) elements where the order of selection matters. For example, consider selecting 2
/// elements from a list of 3 elements: `["A", "B", "C"]`:
///
/// - For \\(k\\)-permutations (without repetitions), the order matters, so the possible selections
/// are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
///
/// - For \\(k\\)-permutations (with repetitions), the order also matters, but we have repeated
///   selections:
///   - `["A", "A"], ["A", "B"], ["A", "C"]`
///   - `["B", "A"], ["B", "B"], ["B", "C"]`
///   - `["C", "A"], ["C", "B"], ["C", "C"]`
///
/// - On the contrary, for \\(k\\)-combinations (without repetitions), where order does not matter,
///   the possible selections are:
///   - `["A", "B"]`
///   - `["A", "C"]`
///   - `["B", "C"]`
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.permutation(-1, 1)
///       |> should.be_error()
///     
///       maths.permutation(4, 0)
///       |> should.equal(Ok(1))
///     
///       maths.permutation(4, 2)
///       |> should.equal(Ok(12))
///     
///       maths.permutation(13, 5)
///       |> should.equal(Ok(154_440))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn permutation(n: Int, k: Int) -> Result(Int, Nil) {
  case n, k {
    _, _ if n < 0 -> Error(Nil)
    _, _ if k < 0 -> Error(Nil)
    _, _ if k < 0 || k > n -> {
      0 |> Ok
    }
    _, _ if k == 0 -> {
      1 |> Ok
    }
    _, _ ->
      list.range(0, k - 1)
      |> list.fold(1, fn(acc, x) { acc * { n - x } })
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A combinatorial function for computing the number of \\(k\\)-permutations.
///
/// **Without** repetitions:
///
/// \\[
/// P(n, k) = \binom{n}{k} \cdot k! = \frac{n!}{(n - k)!}
/// \\]
///
/// **With** repetitions:
///
/// \\[
/// P^*(n, k) = n^k
/// \\]
///
/// The implementation uses an efficient iterative multiplicative formula for computing the result.
///
/// <details>
/// <summary>Details</summary>
///
/// A \\(k\\)-permutation (without repetitions) is a sequence of \\(k\\) elements selected from \
/// \\(n\\) elements where the order of selection matters. For example, consider selecting 2
/// elements from a list of 3 elements: `["A", "B", "C"]`:
///
/// - For \\(k\\)-permutations (without repetitions), the order matters, so the possible selections
/// are:
///   - `["A", "B"], ["B", "A"]`
///   - `["A", "C"], ["C", "A"]`
///   - `["B", "C"], ["C", "B"]`
///
/// - For \\(k\\)-permutations (with repetitions), the order also matters, but we have repeated
///   selections:
///   - `["A", "A"], ["A", "B"], ["A", "C"]`
///   - `["B", "A"], ["B", "B"], ["B", "C"]`
///   - `["C", "A"], ["C", "B"], ["C", "C"]`
///
/// - On the contrary, for \\(k\\)-combinations (without repetitions), where order does not matter,
///   the possible selections are:
///   - `["A", "B"]`
///   - `["A", "C"]`
///   - `["B", "C"]`
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.permutation_with_repetitions(1, -1)
///       |> should.be_error()
///     
///       maths.permutation_with_repetitions(2, 3)
///       |> should.equal(Ok(8))
///     
///       maths.permutation_with_repetitions(4, 4)
///       |> should.equal(Ok(256))
///     
///       maths.permutation_with_repetitions(6, 3)
///       |> should.equal(Ok(216))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn permutation_with_repetitions(n: Int, k: Int) -> Result(Int, Nil) {
  case n, k {
    _, _ if n < 0 -> Error(Nil)
    _, _ if k < 0 -> Error(Nil)
    _, _ -> {
      let n_float = int.to_float(n)
      let k_float = int.to_float(k)
      // 'n' ank 'k' are positive integers, so no errors here...
      let assert Ok(result) = float.power(n_float, k_float)
      result
      |> float.round()
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generates all possible combinations of \\(k\\) elements selected from a given list of size
/// \\(n\\).
///
/// The function can handle cases with and without repetitions
/// (see more details [here](#combination)). Also, note that repeated elements are treated as
/// distinct.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleam/option
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       // Generate all 3-combinations without repetition
///       let assert Ok(result) =
///         maths.list_combination(
///           [1, 2, 3, 4],
///           3,
///           option.Some(maths.WithoutRepetitions),
///         )
///
///       result
///       |> iterator.to_list()
///       |> set.from_list()
///       |> should.equal(set.from_list([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn list_combination(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), Nil) {
  case k, list.length(arr) {
    _, _ if k < 0 -> Error(Nil)
    _, arr_length if k > arr_length -> Error(Nil)
    // Special case: When k = n, then the entire list is the only valid combination
    _, arr_length if k == arr_length -> {
      iterator.single(arr) |> Ok
    }
    _, _ -> {
      Ok(
        do_list_combination_without_repetitions(iterator.from_list(arr), k, []),
      )
    }
  }
}

fn do_list_combination_without_repetitions(
  arr: iterator.Iterator(a),
  k: Int,
  prefix: List(a),
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single(list.reverse(prefix))
    _ ->
      case arr |> iterator.step {
        iterator.Done -> iterator.empty()
        iterator.Next(x, xs) -> {
          let with_x =
            do_list_combination_without_repetitions(xs, k - 1, [x, ..prefix])
          let without_x = do_list_combination_without_repetitions(xs, k, prefix)
          iterator.concat([with_x, without_x])
        }
      }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generates all possible combinations of \\(k\\) elements selected from a given list of size
/// \\(n\\).
///
/// The function can handle cases with and without repetitions
/// (see more details [here](#combination)). Also, note that repeated elements are treated as
/// distinct.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleam/option
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       // Generate all 3-combinations without repetition
///       let assert Ok(result) =
///         maths.list_combination(
///           [1, 2, 3, 4],
///           3,
///           option.Some(maths.WithoutRepetitions),
///         )
///
///       result
///       |> iterator.to_list()
///       |> set.from_list()
///       |> should.equal(set.from_list([[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn list_combination_with_repetitions(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), Nil) {
  case k {
    _ if k < 0 -> Error(Nil)
    _ -> {
      Ok(do_list_combination_with_repetitions(iterator.from_list(arr), k, []))
    }
  }
}

fn do_list_combination_with_repetitions(
  arr: iterator.Iterator(a),
  k: Int,
  prefix: List(a),
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single(list.reverse(prefix))
    _ ->
      case arr |> iterator.step {
        iterator.Done -> iterator.empty()
        iterator.Next(x, xs) -> {
          let with_x =
            do_list_combination_with_repetitions(arr, k - 1, [x, ..prefix])
          let without_x = do_list_combination_with_repetitions(xs, k, prefix)
          iterator.concat([with_x, without_x])
        }
      }
  }
}

fn remove_first_by_index(
  arr: iterator.Iterator(#(Int, a)),
  index_to_remove: Int,
) -> iterator.Iterator(#(Int, a)) {
  iterator.flat_map(arr, fn(arg) {
    let #(index, element) = arg
    case index == index_to_remove {
      True -> iterator.empty()
      False -> iterator.single(#(index, element))
    }
  })
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generates all possible permutations of \\(k\\) elements selected from a given list of size
/// \\(n\\).
///
/// The function can handle cases with and without repetitions
/// (see more details [here](#permutation)). Also, note that repeated elements are treated as
/// distinct.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleam/option
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       // Generate all 3-permutations without repetition
///       let assert Ok(result) =
///         maths.list_permutation(
///           [1, 2, 3],
///           3,
///           option.Some(maths.WithoutRepetitions),
///         )
///
///       result
///       |> iterator.to_list()
///       |> set.from_list()
///       |> should.equal(
///         set.from_list([
///           [1, 2, 3],
///           [2, 1, 3],
///           [3, 1, 2],
///           [1, 3, 2],
///           [2, 3, 1],
///           [3, 2, 1],
///         ]),
///       )
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn list_permutation(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), Nil) {
  case k, list.length(arr) {
    _, _ if k < 0 -> Error(Nil)
    _, arr_length if k > arr_length -> Error(Nil)
    _, _ -> {
      let indexed_arr = list.index_map(arr, fn(x, i) { #(i, x) })
      Ok(do_list_permutation_without_repetitions(
        iterator.from_list(indexed_arr),
        k,
      ))
    }
  }
}

fn do_list_permutation_without_repetitions(
  arr: iterator.Iterator(#(Int, a)),
  k: Int,
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single([])
    _ ->
      iterator.flat_map(arr, fn(arg) {
        let #(index, element) = arg
        let remaining = remove_first_by_index(arr, index)
        let permutations =
          do_list_permutation_without_repetitions(remaining, k - 1)
        iterator.map(permutations, fn(permutation) { [element, ..permutation] })
      })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generates all possible permutations of \\(k\\) elements selected from a given list of size
/// \\(n\\).
///
/// The function can handle cases with and without repetitions
/// (see more details [here](#permutation)). Also, note that repeated elements are treated as
/// distinct.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleam/option
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       // Generate all 3-permutations without repetition
///       let assert Ok(result) =
///         maths.list_permutation(
///           [1, 2, 3],
///           3,
///           option.Some(maths.WithoutRepetitions),
///         )
///
///       result
///       |> iterator.to_list()
///       |> set.from_list()
///       |> should.equal(
///         set.from_list([
///           [1, 2, 3],
///           [2, 1, 3],
///           [3, 1, 2],
///           [1, 3, 2],
///           [2, 3, 1],
///           [3, 2, 1],
///         ]),
///       )
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn list_permutation_with_repetitions(
  arr: List(a),
  k: Int,
) -> Result(iterator.Iterator(List(a)), Nil) {
  case k {
    _ if k < 0 -> Error(Nil)
    _ -> {
      let indexed_arr = list.index_map(arr, fn(x, i) { #(i, x) })
      do_list_permutation_with_repetitions(indexed_arr, k) |> Ok
    }
  }
}

fn do_list_permutation_with_repetitions(
  arr: List(#(Int, a)),
  k: Int,
) -> iterator.Iterator(List(a)) {
  case k {
    0 -> iterator.single([])
    _ ->
      iterator.flat_map(arr |> iterator.from_list, fn(arg) {
        let #(_, element) = arg
        // Allow the same element (by index) to be reused in future recursive calls
        let permutations = do_list_permutation_with_repetitions(arr, k - 1)
        // Prepend the current element to each generated permutation
        iterator.map(permutations, fn(permutation) { [element, ..permutation] })
      })
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Generate a list containing all combinations of pairs of elements coming from two given lists.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       set.from_list([])
///       |> maths.cartesian_product(set.from_list([]))
///       |> should.equal(set.from_list([]))
///
///       set.from_list([1.0, 10.0])
///       |> maths.cartesian_product(set.from_list([1.0, 2.0]))
///       |> should.equal(
///         set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)]),
///       )
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cartesian_product(xset: set.Set(a), yset: set.Set(b)) -> set.Set(#(a, b)) {
  xset
  |> set.fold(set.new(), fn(accumulator0: set.Set(#(a, b)), member0: a) {
    set.fold(yset, accumulator0, fn(accumulator1: set.Set(#(a, b)), member1: b) {
      set.insert(accumulator1, #(member0, member1))
    })
  })
}

// /// Utility function that checks all lists have the expected length and contents
// /// The function is primarily used by all distance measures taking 'List(Float)'
// /// as input
// fn validate_lists(
//   xarr: List(Float),
//   yarr: List(Float),
//   weights: option.Option(List(Float)),
// ) -> Result(Bool, Nil) {
//   case xarr, yarr {
//     [], _ -> Error(Nil)
//     _, [] -> Error(Nil)
//     _, _ -> {
//       let xarr_length = list.length(xarr)
//       let yarr_length = list.length(yarr)
//       case xarr_length == yarr_length, weights {
//         False, _ -> Error(Nil)
//         True, option.None -> {
//           True
//           |> Ok
//         }
//         True, option.Some(warr) -> {
//           let warr_length = list.length(warr)
//           case xarr_length == warr_length {
//             True -> {
//               validate_weights(warr)
//             }
//             False -> Error(Nil)
//           }
//         }
//       }
//     }
//   }
// }

// fn validate_weights(warr: List(Float)) -> Result(Bool, Nil) {
//   // Check that all the given weights are positive
//   let assert Ok(minimum) = list_minimum(warr, float.compare)
//   case minimum >=. 0.0 {
//     False -> Error(Nil)
//     True -> Ok(True)
//   }
// }

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) \\(p\\)-norm of a list (representing a vector):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_{i}\right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, \\(n\\) is the length of the list and \\(x_i\\) is the value in
/// the input list indexed by \\(i\\), while \\(w_i \in \mathbb{R}_{+}\\) is
/// a corresponding positive weight (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///     
///       let assert Ok(result) =
///         [1.0, 1.0, 1.0]
///         |> maths.norm(1.0)
///       result
///       |> maths.is_close(3.0, 0.0, tolerance)
///       |> should.be_true()
///     
///       let assert Ok(result) =
///         [1.0, 1.0, 1.0]
///         |> maths.norm(-1.0)
///       result
///       |> maths.is_close(0.3333333333333333, 0.0, tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn norm(arr: List(Float), p: Float) -> Result(Float, Nil) {
  case arr {
    [] -> Ok(0.0)
    _ -> {
      let aggregate =
        arr
        |> list.fold(0.0, fn(accumulator, element) {
          let assert Ok(result) =
            float.absolute_value(element)
            |> float.power(p)
          result +. accumulator
        })
      let assert Ok(result) = float.power(aggregate, 1.0 /. p)
      Ok(result)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) \\(p\\)-norm of a list (representing a vector):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_{i}\right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, \\(n\\) is the length of the list and \\(x_i\\) is the value in
/// the input list indexed by \\(i\\), while \\(w_i \in \mathbb{R}_{+}\\) is
/// a corresponding positive weight (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn norm_with_weights(
  arr: List(#(Float, Float)),
  p: Float,
) -> Result(Float, Nil) {
  case arr {
    [] -> Ok(0.0)
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float)) { tuple.1 <. 0.0 })
      case weight_is_negative {
        False -> {
          let aggregate =
            arr
            |> list.fold(0.0, fn(accumulator, tuple) {
              let first_element = pair.first(tuple)
              let second_element = pair.second(tuple)
              let assert Ok(result) =
                float.power(float.absolute_value(first_element), p)
              second_element *. result +. accumulator
            })
          let assert Ok(result) = float.power(aggregate, 1.0 /. p)
          Ok(result)
        }
        True -> Error(Nil)
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Manhattan distance between two lists (representing
/// vectors):
///
/// \\[
/// \sum_{i=1}^n w_{i} \left|x_i - y_i \right|
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///     
///       let assert Ok(result) = maths.manhattan_distance([#(0.0, 1.0), #(0.0, 2.0)])
///       result
///       |> maths.is_close(3.0, 0.0, tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn manhattan_distance(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  minkowski_distance(arr, 1.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Manhattan distance between two lists (representing
/// vectors):
///
/// \\[
/// \sum_{i=1}^n w_{i} \left|x_i - y_i \right|
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn manhattan_distance_with_weights(
  arr: List(#(Float, Float, Float)),
) -> Result(Float, Nil) {
  minkowski_distance_with_weights(arr, 1.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Minkowski distance between two lists (representing
/// vectors):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_i - y_i \right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, \\(p >= 1\\) is the order, \\(n\\) is the length of the two lists
/// and \\(x_i, y_i\\) are the values in the respective input lists indexed by \\(i\\).
/// The \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// The Minkowski distance is a generalization of both the Euclidean distance
/// (\\(p=2\\)) and the Manhattan distance (\\(p = 1\\)).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///     
///       let assert Ok(result) =
///         maths.minkowski_distance([#(1.0, 4.0), #(2.0, 5.0), #(3.0, 6.0)], 4.0)
///       result
///       |> maths.is_close(3.9482220388574776, 0.0, tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minkowski_distance(
  arr: List(#(Float, Float)),
  p: Float,
) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      case p <. 1.0 {
        True -> Error(Nil)
        False -> {
          let differences =
            arr
            |> list.map(fn(tuple: #(Float, Float)) -> Float {
              pair.first(tuple) -. pair.second(tuple)
            })
          norm(differences, p)
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Minkowski distance between two lists (representing
/// vectors):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_i - y_i \right|^{p} \right)^{\frac{1}{p}}
/// \\]
///
/// In the formula, \\(p >= 1\\) is the order, \\(n\\) is the length of the two lists
/// and \\(x_i, y_i\\) are the values in the respective input lists indexed by \\(i\\).
/// The \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// The Minkowski distance is a generalization of both the Euclidean distance
/// (\\(p=2\\)) and the Manhattan distance (\\(p = 1\\)).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn minkowski_distance_with_weights(
  arr: List(#(Float, Float, Float)),
  p: Float,
) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float, Float)) { tuple.2 <. 0.0 })

      case p <. 1.0, weight_is_negative {
        False, False -> {
          let differences =
            arr
            |> list.map(fn(tuple: #(Float, Float, Float)) -> #(Float, Float) {
              #(tuple.0 -. tuple.1, tuple.2)
            })
          norm_with_weights(differences, p)
        }
        _, _ -> Error(Nil)
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Euclidean distance between two lists (representing
/// vectors):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_i - y_i \right|^{2} \right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///     
///       let assert Ok(result) = maths.euclidean_distance([#(0.0, 1.0), #(0.0, 2.0)])
///       result
///       |> maths.is_close(2.23606797749979, 0.0, tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn euclidean_distance(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  minkowski_distance(arr, 2.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Euclidean distance between two lists (representing
/// vectors):
///
/// \\[
/// \left( \sum_{i=1}^n w_{i} \left|x_i - y_i \right|^{2} \right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn euclidean_distance_with_weights(
  arr: List(#(Float, Float, Float)),
) -> Result(Float, Nil) {
  minkowski_distance_with_weights(arr, 2.0)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the Chebyshev distance between two lists (representing vectors):
///
/// \\[
/// \text{max}_{i=1}^n \left|x_i - y_i \right|
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.chebyshev_distance([#(-5.0, -1.0), #(-10.0, -12.0), #(-3.0, -3.0)])
///       |> should.equal(Ok(4.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn chebyshev_distance(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      arr
      |> list.map(fn(tuple) {
        { tuple.0 -. tuple.1 }
        |> float.absolute_value()
      })
      |> list_maximum(float.compare)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the Chebyshev distance between two lists (representing vectors):
///
/// \\[
/// \text{max}_{i=1}^n \left|x_i - y_i \right|
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn chebyshev_distance_with_weights(
  arr: List(#(Float, Float, Float)),
) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float, Float)) { tuple.2 <. 0.0 })

      case weight_is_negative {
        True -> Error(Nil)
        False -> {
          arr
          |> list.map(fn(tuple) {
            { { tuple.0 -. tuple.1 } *. tuple.2 }
            |> float.absolute_value()
          })
          |> list_maximum(float.compare)
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the arithmetic mean of the elements in a list:
///
/// \\[
/// \bar{x} = \frac{1}{n}\sum_{i=1}^n x_i
/// \\]
///
/// In the formula, \\(n\\) is the sample size (the length of the list) and \\(x_i\\)
/// is the sample point in the input list indexed by \\(i\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.mean()
///       |> should.be_error()
///
///       [1., 2., 3.]
///       |> maths.mean()
///       |> should.equal(Ok(2.))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn mean(arr: List(Float)) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ ->
      arr
      |> float.sum()
      |> fn(a) { a /. int.to_float(list.length(arr)) }
      |> Ok
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the median of the elements in a list.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       []
///       |> maths.median()
///       |> should.be_error()
///
///       [1., 2., 3.]
///       |> maths.median()
///       |> should.equal(Ok(2.))
///
///       [1., 2., 3., 4.]
///       |> maths.median()
///       |> should.equal(Ok(2.5))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn median(arr: List(Float)) -> Result(Float, Nil) {
  use <- bool.guard(list.is_empty(arr), Error(Nil))
  let length = list.length(arr)
  let mid = length / 2

  case length % 2 == 0 {
    True -> do_median(arr, mid, True, 0)
    False -> do_median(arr, mid, False, 0)
  }
}

fn do_median(
  xs: List(Float),
  mid: Int,
  mean: Bool,
  index: Int,
) -> Result(Float, Nil) {
  use <- bool.guard(index > mid, Error(Nil))
  let mid_less_one = mid - 1

  case xs {
    [x, ..] if !mean && index == mid -> Ok(x)
    [x, y, ..] if mean && index == mid_less_one -> Ok({ x +. y } /. 2.0)
    [_, ..rest] -> do_median(rest, mid, mean, index + 1)
    [] -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the sample variance of the elements in a list:
///
/// \\[
/// s^{2} = \frac{1}{n - d} \sum_{i=1}^{n}(x_i - \bar{x})
/// \\]
///
/// In the formula, \\(n\\) is the sample size (the length of the list) and \\(x_i\\)
/// is the sample point in the input list indexed by \\(i\\).
/// Furthermore, \\(\bar{x}\\) is the sample mean and \\(d\\) is the "Delta
/// Degrees of Freedom", and is by default set to \\(d = 0\\), which gives a biased
/// estimate of the sample variance. Setting \\(d = 1\\) gives an unbiased estimate.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       // Degrees of freedom
///       let ddof = 1
///
///       []
///       |> maths.variance(ddof)
///       |> should.be_error()
///
///       [1., 2., 3.]
///       |> maths.variance(ddof)
///       |> should.equal(Ok(1.))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn variance(arr: List(Float), ddof: Int) -> Result(Float, Nil) {
  case arr, ddof {
    [], _ -> Error(Nil)
    _, _ if ddof < 0 -> Error(Nil)
    _, _ -> {
      let assert Ok(mean) = mean(arr)
      arr
      |> list.map(fn(a: Float) -> Float {
        let assert Ok(result) = float.power(a -. mean, 2.0)
        result
      })
      |> float.sum()
      |> fn(a: Float) -> Float {
        a /. { int.to_float(list.length(arr)) -. int.to_float(ddof) }
      }
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the sample standard deviation of the elements in a list:
/// \\[
/// s = \left(\frac{1}{n - d} \sum_{i=1}^{n}(x_i - \bar{x})\right)^{\frac{1}{2}}
/// \\]
///
/// In the formula, \\(n\\) is the sample size (the length of the list) and \\(x_i\\)
/// is the sample point in the input list indexed by \\(i\\).
/// Furthermore, \\(\bar{x}\\) is the sample mean and \\(d\\) is the "Delta
/// Degrees of Freedom", and is by default set to \\(d = 0\\), which gives a biased
/// estimate of the sample standard deviation. Setting \\(d = 1\\) gives an unbiased
/// estimate.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       // Degrees of freedom
///       let ddof = 1
///     
///       []
///       |> maths.standard_deviation(ddof)
///       |> should.be_error()
///     
///       [1.0, 2.0, 3.0]
///       |> maths.standard_deviation(ddof)
///       |> should.equal(Ok(1.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn standard_deviation(arr: List(Float), ddof: Int) -> Result(Float, Nil) {
  case arr, ddof {
    [], _ -> Error(Nil)
    _, _ if ddof < 0 -> Error(Nil)
    _, _ -> {
      let assert Ok(variance) = variance(arr, ddof)
      // The computed variance will always be positive
      // So an error should never be returned
      let assert Ok(stdev) = float.square_root(variance)
      stdev
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The Jaccard index measures similarity between two sets of elements.
/// Mathematically, the Jaccard index is defined as:
///
/// \\[
/// \frac{|X \cap Y|}{|X \cup Y|} \\; \in \\; \left[0, 1\right]
/// \\]
///
/// where:
///
/// - \\(X\\) and \\(Y\\) are two sets being compared,
/// - \\(|X \cap Y|\\) represents the size of the intersection of the two sets
/// - \\(|X \cup Y|\\) denotes the size of the union of the two sets
///
/// The value of the Jaccard index ranges from 0 to 1, where 0 indicates that the
/// two sets share no elements and 1 indicates that the sets are identical. The
/// Jaccard index is a special case of the  [Tversky index](#tversky_index) (with
/// \\(\alpha=\beta=1\\)).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let xset = set.from_list(["cat", "dog", "hippo", "monkey"])
///       let yset = set.from_list(["monkey", "rhino", "ostrich", "salmon"])
///       maths.jaccard_index(xset, yset)
///       |> should.equal(1.0 /. 7.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn jaccard_index(xset: set.Set(a), yset: set.Set(a)) -> Float {
  let assert Ok(result) = tversky_index(xset, yset, 1.0, 1.0)
  result
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The Sørensen-Dice coefficient measures the similarity between two sets of
/// elements. Mathematically, the coefficient is defined as:
///
/// \\[
/// \frac{2 |X \cap Y|}{|X| + |Y|} \\; \in \\; \left[0, 1\right]
/// \\]
///
/// where:
/// - \\(X\\) and \\(Y\\) are two sets being compared
/// - \\(|X \cap Y|\\) is the size of the intersection of the two sets (i.e., the
/// number of elements common to both sets)
/// - \\(|X|\\) and \\(|Y|\\) are the sizes of the sets \\(X\\) and \\(Y\\), respectively
///
/// The coefficient ranges from 0 to 1, where 0 indicates no similarity (the sets
/// share no elements) and 1 indicates perfect similarity (the sets are identical).
/// The higher the coefficient, the greater the similarity between the two sets.
/// The Sørensen-Dice coefficient is a special case of the
/// [Tversky index](#tversky_index) (with \\(\alpha=\beta=0.5\\)).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let xset = set.from_list(["cat", "dog", "hippo", "monkey"])
///       let yset = set.from_list(["monkey", "rhino", "ostrich", "salmon", "spider"])
///       maths.sorensen_dice_coefficient(xset, yset)
///       |> should.equal(2.0 *. 1.0 /. { 4.0 +. 5.0 })
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn sorensen_dice_coefficient(xset: set.Set(a), yset: set.Set(a)) -> Float {
  let assert Ok(result) = tversky_index(xset, yset, 0.5, 0.5)
  result
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The Tversky index is a generalization of the Jaccard index and Sørensen-Dice
/// coefficient, which adds flexibility through two parameters, \\(\alpha\\) and
/// \\(\beta\\), allowing for asymmetric similarity measures between sets. The
/// Tversky index is defined as:
///
/// \\[
/// \frac{|X \cap Y|}{|X \cap Y| + \alpha|X - Y| + \beta|Y - X|}
/// \\]
///
/// where:
///
/// - \\(X\\) and \\(Y\\) are the sets being compared
/// - \\(|X - Y|\\) and \\(|Y - X|\\) are the sizes of the relative complements of
/// \\(Y\\) in \\(X\\) and \\(X\\) in \\(Y\\), respectively,
/// - \\(\alpha\\) and \\(\beta\\) are parameters that weigh the relative importance
/// of the elements unique to \\(X\\) and \\(Y\\)
///
/// The Tversky index reduces to the Jaccard index when \\(\alpha = \beta = 1\\) and
/// to the Sørensen-Dice coefficient when \\(\alpha = \beta = 0.5\\). In general, the
/// Tversky index can take on any non-negative value, including 0. The index equals
/// 0 when there is no intersection between the two sets, indicating no similarity.
/// However, unlike similarity measures bounded strictly between 0 and 1, the
/// Tversky index does not have a strict upper limit of 1 when \\(\alpha \neq \beta\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let yset = set.from_list(["cat", "dog", "hippo", "monkey"])
///       let xset = set.from_list(["monkey", "rhino", "ostrich", "salmon"])
///       // Test Jaccard index (alpha = beta = 1)
///       maths.tversky_index(xset, yset, 1.0, 1.0)
///       |> should.equal(Ok(1.0 /. 7.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn tversky_index(
  xset: set.Set(a),
  yset: set.Set(a),
  alpha: Float,
  beta: Float,
) -> Result(Float, Nil) {
  case alpha >=. 0.0, beta >=. 0.0 {
    True, True -> {
      let intersection =
        set.intersection(xset, yset)
        |> set.size()
        |> int.to_float()
      let difference1 =
        set.difference(xset, yset)
        |> set.size()
        |> int.to_float()
      let difference2 =
        set.difference(yset, xset)
        |> set.size()
        |> int.to_float()
      intersection
      /. { intersection +. alpha *. difference1 +. beta *. difference2 }
      |> Ok
    }
    _, _ -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The Overlap coefficient, also known as the Szymkiewicz–Simpson coefficient, is
/// a measure of similarity between two sets that focuses on the size of the
/// intersection relative to the smaller of the two sets. It is defined
/// mathematically as:
///
/// \\[
/// \frac{|X \cap Y|}{\min(|X|, |Y|)} \\; \in \\; \left[0, 1\right]
/// \\]
///
/// where:
///
/// - \\(X\\) and \\(Y\\) are the sets being compared
/// - \\(|X \cap Y|\\) is the size of the intersection of the sets
/// - \\(\min(|X|, |Y|)\\) is the size of the smaller set among \\(X\\) and \\(Y\\)
///
/// The coefficient ranges from 0 to 1, where 0 indicates no overlap and 1
/// indicates that the smaller set is a suyset of the larger set. This
/// measure is especially useful in situations where the similarity in terms
/// of the proportion of overlap is more relevant than the difference in sizes
/// between the two sets.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/set
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let set_a = set.from_list(["horse", "dog", "hippo", "monkey", "bird"])
///       let set_b = set.from_list(["monkey", "bird", "ostrich", "salmon"])
///       maths.overlap_coefficient(set_a, set_b)
///       |> should.equal(2.0 /. 4.0)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn overlap_coefficient(xset: set.Set(a), yset: set.Set(a)) -> Float {
  let intersection =
    set.intersection(xset, yset)
    |> set.size()
    |> int.to_float()
  let minsize =
    int.min(set.size(xset), set.size(yset))
    |> int.to_float()
  intersection /. minsize
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) cosine similarity between two lists (representing
/// vectors):
///
/// \\[
/// \frac{\sum_{i=1}^n w_{i} \cdot x_i \cdot y_i}
/// {\left(\sum_{i=1}^n w_{i} \cdot x_i^2\right)^{\frac{1}{2}}
/// \cdot
/// \left(\sum_{i=1}^n w_{i} \cdot y_i^2\right)^{\frac{1}{2}}}
/// \\; \in \\; \left[-1, 1\right]
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i\\), \\(y_i\\) are
/// the values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// The cosine similarity provides a value between -1 and 1, where 1 means the
/// vectors are in the same direction, -1 means they are in exactly opposite
/// directions, and 0 indicates orthogonality.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       // Two orthogonal vectors
///       maths.cosine_similarity([#(-1.0, 1.0), #(1.0, 1.0), #(0.0, -1.0)])
///       |> should.equal(Ok(0.0))
///     
///       // Two identical (parallel) vectors
///       maths.cosine_similarity([#(1.0, 1.0), #(2.0, 2.0), #(3.0, 3.0)])
///       |> should.equal(Ok(1.0))
///     
///       // Two parallel, but oppositely oriented vectors
///       maths.cosine_similarity([#(-1.0, 1.0), #(-2.0, 2.0), #(-3.0, 3.0)])
///       |> should.equal(Ok(-1.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
// pub fn cosine_similarity(
//   xarr: List(Float),
//   yarr: List(Float),
//   weights: option.Option(List(Float)),
// ) -> Result(Float, Nil) {
//   case validate_lists(xarr, yarr, weights) {
//     Error(msg) ->
//       msg
//       |> Error
//     Ok(_) -> {
//       let zipped_arr = list.zip(xarr, yarr)

//       let numerator_elements =
//         zipped_arr
//         |> list.map(fn(tuple) { pair.first(tuple) *. pair.second(tuple) })

//       case weights {
//         option.None -> {
//           let numerator =
//             numerator_elements
//             |> float.sum()

//           let assert Ok(xarr_norm) = norm(xarr, 2.0, option.None)
//           let assert Ok(yarr_norm) = norm(yarr, 2.0, option.None)
//           let denominator = {
//             xarr_norm *. yarr_norm
//           }
//           numerator /. denominator
//           |> Ok
//         }
//         _ -> {
//           let numerator =
//             numerator_elements
//             |> float_weighted_sum(weights)

//           let assert Ok(xarr_norm) = norm(xarr, 2.0, weights)
//           let assert Ok(yarr_norm) = norm(yarr, 2.0, weights)
//           let denominator = {
//             xarr_norm *. yarr_norm
//           }
//           numerator /. denominator
//           |> Ok
//         }
//       }
//     }
//   }
// }
pub fn cosine_similarity(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  let numerator =
    arr
    |> list.fold(0.0, fn(accumulator, tuple) {
      accumulator +. tuple.0 *. tuple.1
    })

  let xarr = arr |> list.map(fn(tuple: #(Float, Float)) { tuple.0 })
  let yarr = arr |> list.map(fn(tuple: #(Float, Float)) { tuple.1 })

  let assert Ok(xarr_norm) = norm(xarr, 2.0)
  let assert Ok(yarr_norm) = norm(yarr, 2.0)

  let denominator = {
    xarr_norm *. yarr_norm
  }
  numerator /. denominator
  |> Ok
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) cosine similarity between two lists (representing
/// vectors):
///
/// \\[
/// \frac{\sum_{i=1}^n w_{i} \cdot x_i \cdot y_i}
/// {\left(\sum_{i=1}^n w_{i} \cdot x_i^2\right)^{\frac{1}{2}}
/// \cdot
/// \left(\sum_{i=1}^n w_{i} \cdot y_i^2\right)^{\frac{1}{2}}}
/// \\; \in \\; \left[-1, 1\right]
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists and \\(x_i\\), \\(y_i\\) are
/// the values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// The cosine similarity provides a value between -1 and 1, where 1 means the
/// vectors are in the same direction, -1 means they are in exactly opposite
/// directions, and 0 indicates orthogonality.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn cosine_similarity_with_weights(
  arr: List(#(Float, Float, Float)),
) -> Result(Float, Nil) {
  let weight_is_negative =
    list.any(arr, fn(tuple: #(Float, Float, Float)) { tuple.2 <. 0.0 })

  case weight_is_negative {
    False -> {
      let numerator =
        arr
        // |> list.map(fn(tuple) { tuple.0 *. tuple.1 *. tuple.2 })
        |> list.fold(0.0, fn(accumulator, tuple) {
          accumulator +. tuple.0 *. tuple.1 *. tuple.2
        })

      let xarr =
        arr
        |> list.map(fn(tuple: #(Float, Float, Float)) { #(tuple.0, tuple.2) })
      let yarr =
        arr
        |> list.map(fn(tuple: #(Float, Float, Float)) { #(tuple.1, tuple.2) })

      let assert Ok(xarr_norm) = norm_with_weights(xarr, 2.0)
      let assert Ok(yarr_norm) = norm_with_weights(yarr, 2.0)
      let denominator = {
        xarr_norm *. yarr_norm
      }
      numerator /. denominator
      |> Ok
    }
    True -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Canberra distance between two lists:
///
/// \\[
/// \sum_{i=1}^n w_{i}\frac{\left| x_i - y_i \right|}
/// {\left| x_i \right| + \left| y_i \right|}
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists, and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       // Empty lists returns an error
///       maths.canberra_distance([])
///       |> should.be_error()
///     
///       maths.canberra_distance([#(1.0, -2.0), #(2.0, -1.0)])
///       |> should.equal(Ok(2.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn canberra_distance(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      arr
      |> list.fold(0.0, fn(accumulator, tuple) {
        let numerator = float.absolute_value({ tuple.0 -. tuple.1 })
        let denominator = {
          float.absolute_value(tuple.0) +. float.absolute_value(tuple.1)
        }
        accumulator +. numerator /. denominator
      })
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Canberra distance between two lists:
///
/// \\[
/// \sum_{i=1}^n w_{i}\frac{\left| x_i - y_i \right|}
/// {\left| x_i \right| + \left| y_i \right|}
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists, and \\(x_i, y_i\\) are the
/// values in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn canberra_distance_with_weights(
  arr: List(#(Float, Float, Float)),
) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float, Float)) { tuple.2 <. 0.0 })

      case weight_is_negative {
        True -> Error(Nil)
        False -> {
          arr
          |> list.fold(0.0, fn(accumulator, tuple) {
            let numerator = float.absolute_value({ tuple.0 -. tuple.1 })
            let denominator = {
              float.absolute_value(tuple.0) +. float.absolute_value(tuple.1)
            }
            accumulator +. tuple.2 *. numerator /. denominator
          })
          |> Ok
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Bray-Curtis distance between two lists:
///
/// \\[
/// \frac{\sum_{i=1}^n w_{i} \left| x_i - y_i \right|}
/// {\sum_{i=1}^n w_{i}\left| x_i + y_i \right|}
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists, and \\(x_i, y_i\\) are the values
/// in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// The Bray-Curtis distance is in the range \\([0, 1]\\) if all entries \\(x_i, y_i\\) are
/// positive.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.braycurtis_distance([])
///       |> should.be_error()
///       
///       // Valid inputs
///       maths.braycurtis_distance([#(1.0, 0.0), #(0.0, 2.0)])
///       |> should.equal(Ok(1.0))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
///
pub fn braycurtis_distance(arr: List(#(Float, Float))) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let numerator =
        arr
        |> list.fold(0.0, fn(accumulator, tuple) {
          accumulator +. float.absolute_value({ tuple.0 -. tuple.1 })
        })

      let denominator =
        arr
        |> list.fold(0.0, fn(accumulator, tuple) {
          accumulator +. float.absolute_value({ tuple.0 +. tuple.1 })
        })

      { numerator /. denominator }
      |> Ok
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Calculate the (weighted) Bray-Curtis distance between two lists:
///
/// \\[
/// \frac{\sum_{i=1}^n w_{i} \left| x_i - y_i \right|}
/// {\sum_{i=1}^n w_{i}\left| x_i + y_i \right|}
/// \\]
///
/// In the formula, \\(n\\) is the length of the two lists, and \\(x_i, y_i\\) are the values
/// in the respective input lists indexed by \\(i\\), while the
/// \\(w_i \in \mathbb{R}_{+}\\) are corresponding positive weights
/// (\\(w_i = 1.0\\;\forall i=1...n\\) by default).
///
/// The Bray-Curtis distance is in the range \\([0, 1]\\) if all entries \\(x_i, y_i\\) are
/// positive.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/option
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
/// 
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn braycurtis_distance_with_weights(
  arr: List(#(Float, Float, Float)),
) -> Result(Float, Nil) {
  case arr {
    [] -> Error(Nil)
    _ -> {
      let weight_is_negative =
        list.any(arr, fn(tuple: #(Float, Float, Float)) { tuple.2 <. 0.0 })

      case weight_is_negative {
        True -> Error(Nil)
        False -> {
          let numerator =
            arr
            |> list.fold(0.0, fn(accumulator, tuple) {
              accumulator
              +. tuple.2
              *. float.absolute_value({ tuple.0 -. tuple.1 })
            })

          let denominator =
            arr
            |> list.fold(0.0, fn(accumulator, tuple) {
              accumulator
              +. tuple.2
              *. float.absolute_value({ tuple.0 +. tuple.1 })
            })

          { numerator /. denominator }
          |> Ok
        }
      }
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a given value \\(a\\) is close to or equivalent to a reference value
/// \\(b\\) based on supplied relative \\(r_{tol}\\) and absolute \\(a_{tol}\\) tolerance
/// values. The equivalance of the two given values are then determined based on
/// the equation:
///
/// \\[
///     \|a - b\| \leq (a_{tol} + r_{tol} \cdot \|b\|)
/// \\]
///
/// `True` is returned if statement holds, otherwise `False` is returned.
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let value = 99.
///       let reference_value = 100.
///       // We set 'absolute_tolerance' and 'relative_tolerance' such that the values are equivalent
///       // if 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let relative_tolerance = 0.01
///       let absolute_tolerance = 0.10
///       maths.is_close(value, reference_value, relative_tolerance, absolute_tolerance)
///       |> should.be_true()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_close(a: Float, b: Float, rtol: Float, atol: Float) -> Bool {
  let x = float_absolute_difference(a, b)
  let y = atol +. rtol *. float.absolute_value(b)
  case x <=. y {
    True -> True
    False -> False
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a list of values are close to or equivalent to a another list of
/// reference values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/list
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let val = 99.0
///       let ref_val = 100.0
///       let xarr = list.repeat(val, 42)
///       let yarr = list.repeat(ref_val, 42)
///       let arr = list.zip(xarr, yarr)
///       // We set 'absolute_tolerance' and 'relative_tolerance' such that the 
///       // values are equivalentif 'val' is within 1 percent of 'ref_val' +/- 0.1
///       let relative_tolerance = 0.01
///       let absolute_tolerance = 0.1
///       maths.all_close(arr, relative_tolerance, absolute_tolerance)
///       |> fn(zarr: Result(List(Bool), Nil)) -> Result(Bool, Nil) {
///         case zarr {
///           Ok(arr) ->
///             arr
///             |> list.all(fn(a) { a })
///             |> Ok
///           _ -> Nil |> Error
///         }
///       }
///       |> should.equal(Ok(True))
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn all_close(
  arr: List(#(Float, Float)),
  rtol: Float,
  atol: Float,
) -> Result(List(Bool), Nil) {
  arr
  |> list.map(fn(tuple) { is_close(tuple.0, tuple.1, rtol, atol) })
  |> Ok
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// Determine if a given value is fractional.
///
/// `True` is returned if the given value is fractional, otherwise `False` is
/// returned.
///
/// <details>
///     <summary>Example</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       maths.is_fractional(0.3333)
///       |> should.equal(True)
///
///       maths.is_fractional(1.0)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_fractional(x: Float) -> Bool {
  do_ceiling(x) -. x >. 0.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(x \in \mathbb{Z}\\) is a
/// power of another integer value \\(y \in \mathbb{Z}\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       // Check if 4 is a power of 2 (it is)
///       maths.is_power(4, 2)
///       |> should.equal(True)
///
///       // Check if 5 is a power of 2 (it is not)
///       maths.is_power(5, 2)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_power(x: Int, y: Int) -> Bool {
  let assert Ok(value) = logarithm(int.to_float(x), int.to_float(y))
  let truncated = round_to_zero(value, 0)
  let remainder = value -. truncated
  remainder == 0.0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(n \in \mathbb{Z}\\) is a
/// perfect number. A number is perfect if it is equal to the sum of its proper
/// positive divisors.
///
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - \\(6\\) is a perfect number since the divisors of 6 are \\(1 + 2 + 3 = 6\\).
///   - \\(28\\) is a perfect number since the divisors of 28 are \\(1 + 2 + 4 + 7 + 14 = 28\\).
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.is_perfect(6)
///       |> should.equal(True)
///
///       maths.is_perfect(28)
///       |> should.equal(True)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_perfect(n: Int) -> Bool {
  int.sum(proper_divisors(n)) == n
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer value \\(x \in \mathbb{Z}\\) is a
/// prime number. A prime number is a natural number greater than 1 that has no
/// positive divisors other than 1 and itself.
///
/// The function uses the Miller-Rabin primality test to assess if \\(x\\) is prime.
/// It is a probabilistic test, so it can mistakenly identify a composite number
/// as prime. However, the probability of such errors decreases with more testing
/// iterations (the function uses 64 iterations internally, which is typically
/// more than sufficient). The Miller-Rabin test is particularly useful for large
/// numbers.
///
/// <details>
///     <summary>Details</summary>
///
///   Examples of prime numbers:
///   - \\(2\\) is a prime number since it has only two divisors: \\(1\\) and \\(2\\).
///   - \\(7\\) is a prime number since it has only two divisors: \\(1\\) and \\(7\\).
///   - \\(4\\) is not a prime number since it has divisors other than \\(1\\) and itself, such
///     as \\(2\\).
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.is_prime(2)
///       |> should.equal(True)
///
///       maths.is_prime(4)
///       |> should.equal(False)
///
///       // Test the 2nd Carmichael number
///       maths.is_prime(1105)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_prime(x: Int) -> Bool {
  case x {
    x if x < 2 -> {
      False
    }
    x if x == 2 -> {
      True
    }
    _ -> {
      miller_rabin_test(x, 64)
    }
  }
}

fn miller_rabin_test(n: Int, k: Int) -> Bool {
  case n, k {
    _, 0 -> True
    _, _ -> {
      // Generate a random int in the range [2, n]
      let random_candidate = 2 + int.random(n - 2)
      case powmod_with_check(random_candidate, n - 1, n) == 1 {
        True -> miller_rabin_test(n, k - 1)
        False -> False
      }
    }
  }
}

fn powmod_with_check(base: Int, exponent: Int, modulus: Int) -> Int {
  case exponent, { exponent % 2 } == 0 {
    0, _ -> 1
    _, True -> {
      let x = powmod_with_check(base, exponent / 2, modulus)
      case { x * x } % modulus, x != 1 && x != { modulus - 1 } {
        1, True -> 0
        _, _ -> { x * x } % modulus
      }
    }
    _, _ -> { base * powmod_with_check(base, exponent - 1, modulus) } % modulus
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given real number \\(x \in \mathbb{R}\\) is strictly
/// between two other real numbers, \\(a,b \in \mathbb{R}\\), such that \\(a < x < b\\).
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.is_between(5.5, 5.0, 6.0)
///       |> should.equal(True)
///
///       maths.is_between(5.0, 5.0, 6.0)
///       |> should.equal(False)
///
///       maths.is_between(6.0, 5.0, 6.0)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_between(x: Float, lower: Float, upper: Float) -> Bool {
  lower <. x && x <. upper
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer \\(n \in \mathbb{Z}\\) is divisible by another
/// integer \\(d \in \mathbb{Z}\\), such that \\(n \mod d = 0\\).
///
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - \\(n = 10\\) is divisible by \\(d = 2\\) because \\(10 \mod 2 = 0\\).
///   - \\(n = 7\\) is not divisible by \\(d = 3\\) because \\(7 \mod 3 \neq 0\\).
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.is_divisible(10, 2)
///       |> should.equal(True)
///
///       maths.is_divisible(7, 3)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_divisible(n: Int, d: Int) -> Bool {
  n % d == 0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// A function that tests whether a given integer \\(m \in \mathbb{Z}\\) is a multiple of another
/// integer \\(k \in \mathbb{Z}\\), such that \\(m = k \times q\\), with \\(q \in \mathbb{Z}\\).
///
/// <details>
///     <summary>Details</summary>
///
///   For example:
///   - \\(m = 15\\) is a multiple of \\(k = 5\\) because \\(15 = 5 \times 3\\).
///   - \\(m = 14\\) is not a multiple of \\(k = 5\\) because \\(14 \div 5\\) does not yield an
///     integer quotient.
///
/// </details>
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example() {
///       maths.is_multiple(15, 5)
///       |> should.equal(True)
///
///       maths.is_multiple(14, 5)
///       |> should.equal(False)
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn is_multiple(m: Int, k: Int) -> Bool {
  m % k == 0
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The beta function over the real numbers:
///
/// \\[
/// \text{B}(x, y) = \frac{\Gamma(x) \cdot \Gamma(y)}{\Gamma(x + y)}
/// \\]
///
/// The beta function is evaluated through the use of the gamma function.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn beta(x: Float, y: Float) -> Float {
  gamma(x) *. gamma(y) /. gamma(x +. y)
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The error function.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn erf(x: Float) -> Float {
  let assert [a1, a2, a3, a4, a5] = [
    0.254829592, -0.284496736, 1.421413741, -1.453152027, 1.061405429,
  ]
  let p = 0.3275911

  let sign = float_sign(x)
  let x = float.absolute_value(x)

  // Formula 7.1.26 given in Abramowitz and Stegun.
  let t = 1.0 /. { 1.0 +. p *. x }
  let y =
    1.0
    -. { { { { a5 *. t +. a4 } *. t +. a3 } *. t +. a2 } *. t +. a1 }
    *. t
    *. exponential(-1.0 *. x *. x)
  sign *. y
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The gamma function over the real numbers. The function is essentially equal to
/// the factorial for any positive integer argument: \\(\Gamma(n) = (n - 1)!\\)
///
/// The implemented gamma function is approximated through Lanczos approximation
/// using the same coefficients used by the GNU Scientific Library.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn gamma(x: Float) -> Float {
  gamma_lanczos(x)
}

const lanczos_g: Float = 7.0

const lanczos_p: List(Float) = [
  0.99999999999980993, 676.5203681218851, -1259.1392167224028,
  771.32342877765313, -176.61502916214059, 12.507343278686905,
  -0.13857109526572012, 0.0000099843695780195716, 0.00000015056327351493116,
]

fn gamma_lanczos(x: Float) -> Float {
  case x <. 0.5 {
    True -> pi() /. { sin(pi() *. x) *. gamma_lanczos(1.0 -. x) }
    False -> {
      let z = x -. 1.0
      let x =
        list.index_fold(lanczos_p, 0.0, fn(acc, v, index) {
          case index > 0 {
            True -> acc +. v /. { z +. int.to_float(index) }
            False -> v
          }
        })
      let t = z +. lanczos_g +. 0.5
      let assert Ok(v1) = float.power(2.0 *. pi(), 0.5)
      let assert Ok(v2) = float.power(t, z +. 0.5)
      v1 *. v2 *. exponential(-1.0 *. t) *. x
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The lower incomplete gamma function over the real numbers.
///
/// The implemented incomplete gamma function is evaluated through a power series
/// expansion.
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
pub fn incomplete_gamma(a: Float, x: Float) -> Result(Float, Nil) {
  case a >. 0.0 && x >=. 0.0 {
    True -> {
      let assert Ok(v) = float.power(x, a)
      v
      *. exponential(-1.0 *. x)
      *. incomplete_gamma_sum(a, x, 1.0 /. a, 0.0, 1.0)
      |> Ok
    }

    False -> Error(Nil)
  }
}

fn incomplete_gamma_sum(
  a: Float,
  x: Float,
  t: Float,
  s: Float,
  n: Float,
) -> Float {
  case t {
    0.0 -> s
    _ -> {
      let ns = s +. t
      let nt = t *. { x /. { a +. n } }
      incomplete_gamma_sum(a, x, nt, ns, n +. 1.0)
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator generating evenly spaced values within a given interval.
/// based on a start value but excludes the stop value. The spacing between values is determined
/// by the step size provided. The function supports both positive and negative step values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths/sequences
///
///     pub fn example () {
///       sequences.arange(1.0, 5.0, 1.0)
///       |> iterator.to_list()
///       |> should.equal([1.0, 2.0, 3.0, 4.0])
///
///       // No points returned since
///       // start is smaller than stop and the step is positive
///       sequences.arange(5.0, 1.0, 1.0)
///       |> iterator.to_list()
///       |> should.equal([])
///
///       // Points returned since
///       // start smaller than stop but negative step
///       sequences.arange(5.0, 1.0, -1.0)
///       |> iterator.to_list()
///       |> should.equal([5.0, 4.0, 3.0, 2.0])
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn arange(
  start: Float,
  stop: Float,
  step: Float,
) -> iterator.Iterator(Float) {
  case start >=. stop && step >. 0.0 || start <=. stop && step <. 0.0 {
    True -> iterator.empty()
    False -> {
      let direction = case start <=. stop {
        True -> {
          1.0
        }
        False -> {
          -1.0
        }
      }
      let step_abs = float.absolute_value(step)
      let num =
        float.absolute_value(start -. stop) /. step_abs
        |> float.round()

      iterator.range(0, num - 1)
      |> iterator.map(fn(i) {
        start +. int.to_float(i) *. step_abs *. direction
      })
    }
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator for generating linearly spaced points over a specified
/// interval. The endpoint of the interval can optionally be included/excluded. The number of
/// points and whether the endpoint is included determine the spacing between values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///     import gleam_community/maths/sequences
///     import gleam_community/maths
///
///     pub fn example () {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///       let assert Ok(linspace) = sequences.linear_space(10.0, 20.0, 5, True)
///       let assert Ok(result) =
///         maths.all_close(
///           linspace |> iterator.to_list(),
///           [10.0, 12.5, 15.0, 17.5, 20.0],
///           0.0,
///           tol,
///         )
///
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // A negative number of points (-5) does not work
///       sequences.linear_space(10.0, 50.0, -5, True)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn linear_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: Bool,
) -> Result(iterator.Iterator(Float), Nil) {
  let direction = case start <=. stop {
    True -> 1.0
    False -> -1.0
  }

  let increment = case endpoint {
    True -> {
      float.absolute_value(start -. stop) /. int.to_float(num - 1)
    }
    False -> {
      float.absolute_value(start -. stop) /. int.to_float(num)
    }
  }
  case num > 0 {
    True -> {
      iterator.range(0, num - 1)
      |> iterator.map(fn(i) {
        start +. int.to_float(i) *. increment *. direction
      })
      |> Ok
    }
    False -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator of logarithmically spaced points over a specified interval.
/// The endpoint of the interval can optionally be included/excluded. The number of points, base,
/// and whether the endpoint is included determine the spacing between values.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///       let assert Ok(logspace) = sequences.logarithmic_space(1.0, 3.0, 3, True, 10.0)
///       let assert Ok(result) =
///         maths.all_close(
///           logspace |> iterator.to_list(),
///           [10.0, 100.0, 1000.0],
///           0.0,
///           tol,
///         )
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // A negative number of points (-3) does not work
///       sequences.logarithmic_space(1.0, 3.0, -3, False, 10.0)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn logarithmic_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: Bool,
  base: Float,
) -> Result(iterator.Iterator(Float), Nil) {
  case num > 0 {
    True -> {
      let assert Ok(linspace) = linear_space(start, stop, num, endpoint)
      linspace
      |> iterator.map(fn(i) {
        let assert Ok(result) = float.power(base, i)
        result
      })
      |> Ok
    }
    False -> Error(Nil)
  }
}

/// <div style="text-align: right;">
///     <a href="https://github.com/gleam-community/maths/issues">
///         <small>Spot a typo? Open an issue!</small>
///     </a>
/// </div>
///
/// The function returns an iterator of numbers spaced evenly on a log scale (a geometric
/// progression). Each point in the list is a constant multiple of the previous. The function is
/// similar to the [`logarithmic_space`](#logarithmic_space) function, but with endpoints
/// specified directly.
///
/// <details>
///     <summary>Example:</summary>
///
///     import gleam/iterator
///     import gleeunit/should
///     import gleam_community/maths
///
///     pub fn example () {
///       let assert Ok(tolerance) = float.power(10.0, -6.0)
///       let assert Ok(logspace) = sequences.geometric_space(10.0, 1000.0, 3, True)
///       let assert Ok(result) =
///         maths.all_close(
///           logspace |> iterator.to_list(),
///           [10.0, 100.0, 1000.0],
///           0.0,
///           tol,
///         )
///       result
///       |> list.all(fn(x) { x == True })
///       |> should.be_true()
///
///       // Input (start and stop can't be equal to 0.0)
///       sequences.geometric_space(0.0, 1000.0, 3, False)
///       |> should.be_error()
///
///       sequences.geometric_space(-1000.0, 0.0, 3, False)
///       |> should.be_error()
///
///       // A negative number of points (-3) does not work
///       sequences.geometric_space(10.0, 1000.0, -3, False)
///       |> should.be_error()
///     }
/// </details>
///
/// <div style="text-align: right;">
///     <a href="#">
///         <small>Back to top ↑</small>
///     </a>
/// </div>
///
/// TODO
pub fn geometric_space(
  start: Float,
  stop: Float,
  num: Int,
  endpoint: Bool,
) -> Result(iterator.Iterator(Float), Nil) {
  case start == 0.0 || stop == 0.0 {
    True -> Error(Nil)
    False ->
      case num > 0 {
        True -> {
          let assert Ok(log_start) = logarithm_10(start)
          let assert Ok(log_stop) = logarithm_10(stop)
          logarithmic_space(log_start, log_stop, num, endpoint, 10.0)
        }
        False -> Error(Nil)
      }
  }
}
