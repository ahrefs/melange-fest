open Fest

let () = test "equal" (fun () -> equal expect (4 - 3) 1)
let () = test "equal 2" (fun () -> equal expect ("f" ^ "oo") "foo")
let () = test "ok" (fun () -> ok expect (true || false))

module Deep_strict_equal = struct
  type foo = Foo of int
  type bar = { foo : foo; bar : string }

  let assertion ~f () =
    f expect
      { foo = Foo 42; bar = "hello" }
      (let bar = { foo = Foo 40; bar = "hell" } in
       let bar = { bar with bar = bar.bar ^ "o" } in
       let bar =
         { bar with foo = (match bar.foo with Foo x -> Foo (x + 2)) }
       in
       bar)

  let () = test "deep_equal" (assertion ~f:deep_equal)
  let () = test "deepEqual" (assertion ~f:deepEqual)
end

module Promise = struct
  open Fest.Promise

  let inner input output =
    subtest
      ("Math.defaultRound: " ^ Js.Float.toString input)
      (fun () ->
        equal expect output
          (input |> Js.Math.round |> int_of_float |> string_of_int);
        Js.Promise.resolve ())

  let () =
    test "promise" (fun () ->
        let* () = inner 0. "0" in
        inner 0.055 "0")
end
