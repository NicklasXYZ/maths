import gleam/float
import gleam_community/maths
import gleeunit/should

pub fn float_to_degree_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  maths.radians_to_degrees(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.radians_to_degrees(2.0 *. maths.pi())
  |> maths.is_close(360.0, 0.0, tol)
  |> should.be_true()
}

pub fn float_to_radian_test() {
  let assert Ok(tol) = float.power(10.0, -6.0)
  maths.degrees_to_radians(0.0)
  |> maths.is_close(0.0, 0.0, tol)
  |> should.be_true()

  maths.degrees_to_radians(360.0)
  |> maths.is_close(2.0 *. maths.pi(), 0.0, tol)
  |> should.be_true()
}
