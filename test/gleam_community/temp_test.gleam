import gleam/float
import gleam/int
import gleam/list
import gleam/set
import gleam_community/maths
import gleeunit/should

pub fn example_1_test() {
  maths.gcd(1, 1)
  |> should.equal(1)

  maths.gcd(100, 10)
  |> should.equal(10)

  maths.gcd(-36, -17)
  |> should.equal(1)
}

pub fn example_2_test() {
  maths.int_euclidean_modulo(15, 4)
  |> should.equal(3)

  maths.int_euclidean_modulo(-3, -2)
  |> should.equal(1)

  maths.int_euclidean_modulo(5, 0)
  |> should.equal(0)
}

pub fn example_3_test() {
  maths.lcm(1, 1)
  |> should.equal(1)

  maths.lcm(100, 10)
  |> should.equal(100)

  maths.lcm(-36, -17)
  |> should.equal(612)
}

pub fn example_4_test() {
  maths.divisors(4)
  |> should.equal([1, 2, 4])

  maths.divisors(6)
  |> should.equal([1, 2, 3, 6])

  maths.divisors(13)
  |> should.equal([1, 13])
}

pub fn example_5_test() {
  maths.proper_divisors(4)
  |> should.equal([1, 2])

  maths.proper_divisors(6)
  |> should.equal([1, 2, 3])

  maths.proper_divisors(13)
  |> should.equal([1])
}

pub fn example_6_test() {
  // An empty list returns an error
  []
  |> maths.float_weighted_sum()
  |> should.equal(Ok(0.0))

  // Valid input returns a result
  [#(1.0, 1.0), #(2.0, 1.0), #(3.0, 1.0)]
  |> maths.float_weighted_sum()
  |> should.equal(Ok(6.0))

  [#(9.0, 0.5), #(10.0, 0.5), #(10.0, 0.5)]
  |> maths.float_weighted_sum()
  |> should.equal(Ok(14.5))

  [#(1.0, 0.5), #(2.0, 0.5), #(3.0, 0.5)]
  |> maths.float_weighted_sum()
  |> should.equal(Ok(3.0))

  // Negative weights returns an error
  [#(1.0, -1.0), #(2.0, -1.0), #(3.0, -1.0)]
  |> maths.float_weighted_sum()
  |> should.be_error()
}

pub fn example_7_test() {
  // An empty list returns 1.0
  []
  |> maths.float_weighted_product()
  |> should.equal(Ok(1.0))

  // Valid input returns a result
  [#(1.0, 1.0), #(2.0, 1.0), #(3.0, 1.0)]
  |> maths.float_weighted_product()
  |> should.equal(Ok(6.0))

  // Set the tolerance
  let assert Ok(tol) = float.power(10.0, -6.0)

  let assert Ok(result) =
    [#(9.0, 0.5), #(10.0, 0.5), #(10.0, 0.5)]
    |> maths.float_weighted_product()
  result
  |> maths.is_close(30.0, 0.0, tol)
  |> should.be_true()

  let assert Ok(result) =
    [#(1.0, 0.5), #(2.0, 0.5), #(3.0, 0.5)]
    |> maths.float_weighted_product()
  result
  |> maths.is_close(2.4494897427831783, 0.0, tol)
  |> should.be_true()

  // Negative weights returns an error
  [#(1.0, -1.0), #(2.0, -1.0), #(3.0, -1.0)]
  |> maths.float_weighted_sum()
  |> should.be_error()
}

pub fn example_8_test() {
  []
  |> maths.float_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.float_cumulative_sum()
  |> should.equal([1.0, 3.0, 6.0])
}

pub fn example_9_test() {
  []
  |> maths.int_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> maths.int_cumulative_sum()
  |> should.equal([1, 3, 6])
}

pub fn example_10_test() {
  // An empty list returns an error
  []
  |> maths.float_cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.float_cumulative_product()
  |> should.equal([1.0, 2.0, 6.0])
}

pub fn example_11_test() {
  []
  |> maths.float_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.float_cumulative_sum()
  |> should.equal([1.0, 3.0, 6.0])
}

pub fn example_12_test() {
  []
  |> maths.int_cumulative_sum()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> maths.int_cumulative_sum()
  |> should.equal([1, 3, 6])
}

pub fn example_13_test() {
  // An empty list returns an error
  []
  |> maths.float_cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.float_cumulative_product()
  |> should.equal([1.0, 2.0, 6.0])
}

pub fn example_14_test() {
  // An empty list returns an error
  []
  |> maths.int_cumulative_product()
  |> should.equal([])

  // Valid input returns a result
  [1, 2, 3]
  |> maths.int_cumulative_product()
  |> should.equal([1, 2, 6])
}

pub fn example_15_test() {
  maths.degrees_to_radians(360.0)
  |> should.equal(2.0 *. maths.pi())
}

pub fn example_16_test() {
  maths.radians_to_degrees(0.0)
  |> should.equal(0.0)

  maths.radians_to_degrees(2.0 *. maths.pi())
  |> should.equal(360.0)
}

pub fn example_17_test() {
  maths.acos(1.0)
  |> should.equal(Ok(0.0))

  maths.acos(1.1)
  |> should.be_error()

  maths.acos(-1.1)
  |> should.be_error()
}

pub fn example_18_test() {
  maths.acosh(1.0)
  |> should.equal(Ok(0.0))

  maths.acosh(0.0)
  |> should.be_error()
}

pub fn example_19_test() {
  maths.asin(0.0)
  |> should.equal(Ok(0.0))

  maths.asin(1.1)
  |> should.be_error()

  maths.asin(-1.1)
  |> should.be_error()
}

pub fn example_20_test() {
  maths.asinh(0.0)
  |> should.equal(0.0)
}

pub fn example_21_test() {
  maths.atanh(0.0)
  |> should.equal(Ok(0.0))

  maths.atanh(1.0)
  |> should.be_error()

  maths.atanh(-1.0)
  |> should.be_error()
}

pub fn example_22_test() {
  maths.logarithm(1.0, 10.0)
  |> should.equal(Ok(0.0))

  maths.logarithm(maths.e(), maths.e())
  |> should.equal(Ok(1.0))

  maths.logarithm(-1.0, 2.0)
  |> should.be_error()
}

pub fn example_23_test() {
  maths.logarithm_2(1.0)
  |> should.equal(Ok(0.0))

  maths.logarithm_2(2.0)
  |> should.equal(Ok(1.0))

  maths.logarithm_2(-1.0)
  |> should.be_error()
}

pub fn example_24_test() {
  maths.nth_root(1.0, 2)
  |> should.equal(Ok(1.0))

  maths.nth_root(27.0, 3)
  |> should.equal(Ok(3.0))

  maths.nth_root(256.0, 4)
  |> should.equal(Ok(4.0))

  maths.nth_root(-1.0, 2)
  |> should.be_error()
}

pub fn example() {
  maths.round_to_nearest(12.0654, 2)
  |> should.equal(12.07)
}

pub fn example_25_test() {
  maths.round_ties_away(12.0654, 2)
  |> should.equal(12.07)
}

pub fn example_26_test() {
  maths.round_ties_up(12.0654, 2)
  |> should.equal(12.07)
}

pub fn example_28_test() {
  maths.round_to_zero(12.0654, 2)
  |> should.equal(12.06)
}

pub fn example_29_test() {
  maths.round_down(12.0654, 2)
  |> should.equal(12.06)
}

pub fn example_30_test() {
  maths.round_up(12.0654, 2)
  |> should.equal(12.07)
}

pub fn example_31_test() {
  maths.float_absolute_difference(-10.0, 10.0)
  |> should.equal(20.0)

  maths.float_absolute_difference(0.0, -2.0)
  |> should.equal(2.0)
}

pub fn example_32_test() {
  // An empty lists returns an error
  []
  |> maths.list_minimum(int.compare)
  |> should.be_error()

  // Valid input returns a result
  [4, 4, 3, 2, 1]
  |> maths.list_minimum(int.compare)
  |> should.equal(Ok(1))
}

pub fn example_33_test() {
  // An empty lists returns an error
  []
  |> maths.list_maximum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> maths.list_maximum(float.compare)
  |> should.equal(Ok(4.0))
}

pub fn example_34_test() {
  []
  |> maths.list_maximum(float.compare)
  |> should.be_error()

  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> maths.list_maximum(float.compare)
  |> should.equal(Ok(4.0))
}

pub fn example_35_test() {
  // An empty lists returns an error
  []
  |> maths.arg_minimum(float.compare)
  |> should.be_error()

  // Valid input returns a result
  [4.0, 4.0, 3.0, 2.0, 1.0]
  |> maths.arg_minimum(float.compare)
  |> should.equal(Ok([4]))
}

pub fn example_36_test() {
  // Invalid input gives an error
  maths.combination_with_repetitions(-1, 1)
  |> should.be_error()

  maths.combination_with_repetitions(2, 3)
  |> should.equal(Ok(4))

  maths.combination_with_repetitions(13, 5)
  |> should.equal(Ok(6188))
}

pub fn example_37_test() {
  maths.combination(-1, 1)
  |> should.be_error()

  maths.combination(4, 0)
  |> should.equal(Ok(1))

  maths.combination(4, 4)
  |> should.equal(Ok(1))

  maths.combination(13, 5)
  |> should.equal(Ok(1287))
}

pub fn example_38_test() {
  maths.factorial(-1)
  |> should.be_error()

  maths.factorial(0)
  |> should.equal(Ok(1))

  maths.factorial(3)
  |> should.equal(Ok(6))
}

pub fn example_39_test() {
  maths.permutation(-1, 1)
  |> should.be_error()

  maths.permutation(4, 0)
  |> should.equal(Ok(1))

  maths.permutation(4, 2)
  |> should.equal(Ok(12))

  maths.permutation(13, 5)
  |> should.equal(Ok(154_440))
}

pub fn example_40_test() {
  maths.permutation_with_repetitions(1, -1)
  |> should.be_error()

  maths.permutation_with_repetitions(2, 3)
  |> should.equal(Ok(8))

  maths.permutation_with_repetitions(4, 4)
  |> should.equal(Ok(256))

  maths.permutation_with_repetitions(6, 3)
  |> should.equal(Ok(216))
}

pub fn example_41_test() {
  // Cartesian product of two empty sets
  set.from_list([])
  |> maths.cartesian_product(set.from_list([]))
  |> should.equal(set.from_list([]))

  // Cartesian product of two sets with numeric values
  set.from_list([1.0, 10.0])
  |> maths.cartesian_product(set.from_list([1.0, 2.0]))
  |> should.equal(
    set.from_list([#(1.0, 1.0), #(1.0, 2.0), #(10.0, 1.0), #(10.0, 2.0)]),
  )
}

pub fn example_42_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  let assert Ok(result) =
    [1.0, 1.0, 1.0]
    |> maths.norm(1.0)
  result
  |> maths.is_close(3.0, 0.0, tolerance)
  |> should.be_true()

  let assert Ok(result) =
    [1.0, 1.0, 1.0]
    |> maths.norm(-1.0)
  result
  |> maths.is_close(0.3333333333333333, 0.0, tolerance)
  |> should.be_true()
}

pub fn example_43_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  let assert Ok(result) = maths.manhattan_distance([#(0.0, 1.0), #(0.0, 2.0)])
  result
  |> maths.is_close(3.0, 0.0, tolerance)
  |> should.be_true()
}

pub fn example_44_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  let assert Ok(result) =
    maths.minkowski_distance([#(1.0, 4.0), #(2.0, 5.0), #(3.0, 6.0)], 4.0)
  result
  |> maths.is_close(3.9482220388574776, 0.0, tolerance)
  |> should.be_true()
}

pub fn example_45_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  let assert Ok(result) = maths.euclidean_distance([#(0.0, 1.0), #(0.0, 2.0)])
  result
  |> maths.is_close(2.23606797749979, 0.0, tolerance)
  |> should.be_true()
}

pub fn example_46_test() {
  let assert Ok(tolerance) = float.power(10.0, -6.0)

  // Test that the constant is approximately equal to 2.7128...
  maths.e()
  |> maths.is_close(2.7_182_818_284_590_452_353_602, 0.0, tolerance)
  |> should.be_true()
}

pub fn example_47_test() {
  // Empty lists returns an error
  maths.chebyshev_distance([])
  |> should.be_error()

  maths.chebyshev_distance([#(-5.0, -1.0), #(-10.0, -12.0), #(-3.0, -3.0)])
  |> should.equal(Ok(4.0))
}

pub fn example_48_test() {
  // An empty list returns an error
  []
  |> maths.mean()
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.mean()
  |> should.equal(Ok(2.0))
}

pub fn example_49_test() {
  []
  |> maths.median()
  |> should.be_error()

  [1.0, 2.0, 3.0]
  |> maths.median()
  |> should.equal(Ok(2.0))

  [1.0, 2.0, 3.0, 4.0]
  |> maths.median()
  |> should.equal(Ok(2.5))
}

pub fn example_50_test() {
  // Degrees of freedom
  let ddof = 1

  // An empty list returns an error
  []
  |> maths.variance(ddof)
  |> should.be_error()

  // Valid input returns a result
  [1.0, 2.0, 3.0]
  |> maths.variance(ddof)
  |> should.equal(Ok(1.0))
}

pub fn example_51_test() {
  // Degrees of freedom
  let ddof = 1

  []
  |> maths.standard_deviation(ddof)
  |> should.be_error()

  [1.0, 2.0, 3.0]
  |> maths.standard_deviation(ddof)
  |> should.equal(Ok(1.0))
}

pub fn example_52_test() {
  let xset = set.from_list(["cat", "dog", "hippo", "monkey"])
  let yset = set.from_list(["monkey", "rhino", "ostrich", "salmon"])
  maths.jaccard_index(xset, yset)
  |> should.equal(1.0 /. 7.0)
}

pub fn example_53_test() {
  let xset = set.from_list(["cat", "dog", "hippo", "monkey"])
  let yset = set.from_list(["monkey", "rhino", "ostrich", "salmon", "spider"])
  maths.sorensen_dice_coefficient(xset, yset)
  |> should.equal(2.0 *. 1.0 /. { 4.0 +. 5.0 })
}

pub fn example_54_test() {
  let yset = set.from_list(["cat", "dog", "hippo", "monkey"])
  let xset = set.from_list(["monkey", "rhino", "ostrich", "salmon"])
  // Test Jaccard index (alpha = beta = 1)
  maths.tversky_index(xset, yset, 1.0, 1.0)
  |> should.equal(Ok(1.0 /. 7.0))
}

pub fn example_55_test() {
  let set_a = set.from_list(["horse", "dog", "hippo", "monkey", "bird"])
  let set_b = set.from_list(["monkey", "bird", "ostrich", "salmon"])
  maths.overlap_coefficient(set_a, set_b)
  |> should.equal(2.0 /. 4.0)
}

pub fn example_56_test() {
  // Two orthogonal vectors
  maths.cosine_similarity([#(-1.0, 1.0), #(1.0, 1.0), #(0.0, -1.0)])
  |> should.equal(Ok(0.0))

  // Two identical (parallel) vectors
  maths.cosine_similarity([#(1.0, 1.0), #(2.0, 2.0), #(3.0, 3.0)])
  |> should.equal(Ok(1.0))

  // Two parallel, but oppositely oriented vectors
  maths.cosine_similarity([#(-1.0, 1.0), #(-2.0, 2.0), #(-3.0, 3.0)])
  |> should.equal(Ok(-1.0))
}

pub fn example_57_test() {
  // Empty lists returns an error
  maths.canberra_distance([])
  |> should.be_error()

  maths.canberra_distance([#(1.0, -2.0), #(2.0, -1.0)])
  |> should.equal(Ok(2.0))

  maths.canberra_distance_with_weights([#(1.0, 0.0, 1.0), #(0.0, 2.0, 0.5)])
  |> should.equal(Ok(1.5))
}

pub fn example_58_test() {
  // Empty lists returns an error
  maths.braycurtis_distance([])
  |> should.be_error()

  // Valid inputs
  maths.braycurtis_distance([#(1.0, 0.0), #(0.0, 2.0)])
  |> should.equal(Ok(1.0))

  maths.braycurtis_distance_with_weights([#(1.0, 3.0, 0.5), #(2.0, 4.0, 1.0)])
  |> should.equal(Ok(0.375))
}

pub fn example_59_test() {
  let value = 99.0
  let reference_value = 100.0
  // We set 'absolute_tolerance' and 'relative_tolerance' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let relative_tolerance = 0.01
  let absolute_tolerance = 0.1
  maths.is_close(value, reference_value, relative_tolerance, absolute_tolerance)
  |> should.be_true()
}

pub fn example_60_test() {
  let val = 99.0
  let ref_val = 100.0
  let xarr = list.repeat(val, 42)
  let yarr = list.repeat(ref_val, 42)
  let arr = list.zip(xarr, yarr)
  // We set 'atol' and 'rtol' such that the values are equivalent
  // if 'val' is within 1 percent of 'ref_val' +/- 0.1
  let relative_tolerance = 0.01
  let absolute_tolerance = 0.1
  maths.all_close(arr, relative_tolerance, absolute_tolerance)
  |> fn(zarr: Result(List(Bool), Nil)) -> Result(Bool, Nil) {
    case zarr {
      Ok(arr) ->
        arr
        |> list.all(fn(a) { a })
        |> Ok
      _ -> Nil |> Error
    }
  }
  |> should.equal(Ok(True))
}

pub fn example_61_test() {
  maths.is_fractional(0.3333)
  |> should.equal(True)

  maths.is_fractional(1.0)
  |> should.equal(False)
}

pub fn example_62_test() {
  // Check if 4 is a power of 2 (it is)
  maths.is_power(4, 2)
  |> should.equal(True)

  // Check if 5 is a power of 2 (it is not)
  maths.is_power(5, 2)
  |> should.equal(False)
}

pub fn example_63_test() {
  maths.is_prime(2)
  |> should.equal(True)

  maths.is_prime(4)
  |> should.equal(False)

  // Test the 2nd Carmichael number
  maths.is_prime(1105)
  |> should.equal(False)
}
