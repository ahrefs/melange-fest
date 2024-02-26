open Fest

let () = test "some test" (fun () -> expect |> equal 1 1)
let () = test "second basic test" (fun () -> expect |> equal "foo" "foo")

open Fest.Promise

let inner input output =
  test
    ("Math.defaultRound: " ^ Js.Float.toString input)
    (fun () ->
      expect
      |> equal output (input |> Js.Math.round |> int_of_float |> string_of_int);
      Js.Promise.resolve ())

let (_ : unit Js.Promise.t) =
  let* () =
    test "show '0' when value is less then 0.1" (fun () ->
        let* () = inner 0. "0" in
        inner 0.055 "0")
  in
  Js.Promise.resolve ()
