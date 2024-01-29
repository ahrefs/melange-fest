open Fest

module Strict_equal = struct
  let () = test "some test" (fun () -> expect |> strict_equal 1 1)
  let () = test "second basic test" (fun () -> expect |> equal "foo" "foo")
end

module Deep_strict_equal = struct
  type foo = Foo of int
  type bar = { foo : foo; bar : string }

  let () =
    test "test variant" (fun () ->
        expect
        |> deepStrictEqual
             { foo = Foo 42; bar = "hello" }
             (let bar = { foo = Foo 40; bar = "hell" } in
              let bar = { bar with bar = bar.bar ^ "o" } in
              let bar =
                { bar with foo = (match bar.foo with Foo x -> Foo (x + 2)) }
              in
              bar))
end

module Promise = struct
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
end
