external test : string -> (unit -> unit) -> unit = "test" [@@mel.module "node:test"]

type assertion
external expect : assertion = "assert" [@@mel.module]
external equal : assertion -> 'a -> 'a -> unit = "equal" [@@mel.send]
external strict_equal : assertion -> 'a -> 'a -> unit = "strictEqual" [@@mel.send]

let () = test "some test" (fun () ->
  expect |. strict_equal 1 1
)
let () = test "second basic test" (fun () ->
  expect |. equal "foo" "foo"
)
