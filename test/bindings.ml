open Fest

let () = test "strict_equal" (fun () -> expect |> strict_equal 1 1)
let () = test "strictEqual" (fun () -> expect |> strictEqual 1 1)
let () = test "equal" (fun () -> expect |> equal "foo" "foo")

module Deep_strict_equal = struct
  type foo = Foo of int
  type bar = { foo : foo; bar : string }

  let assertion ~f () =
    expect
    |> f
         { foo = Foo 42; bar = "hello" }
         (let bar = { foo = Foo 40; bar = "hell" } in
          let bar = { bar with bar = bar.bar ^ "o" } in
          let bar =
            { bar with foo = (match bar.foo with Foo x -> Foo (x + 2)) }
          in
          bar)

  let () = test "deep_strict_equal" (assertion ~f:deep_strict_equal)
  let () = test "deepStrictEqual" (assertion ~f:deepStrictEqual)
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
      test "promise" (fun () ->
          let* () = inner 0. "0" in
          inner 0.055 "0")
    in
    Js.Promise.resolve ()
end
