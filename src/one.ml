open Fest

let () = test "some test" (fun () ->
  expect |. strict_equal 1 1
)
let () = test "second basic test" (fun () ->
  expect |. equal "foo" "foo"
)
