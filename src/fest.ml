external test : string -> (unit -> unit) -> unit = "test" [@@mel.module "node:test"]

type assertion
external expect : assertion = "assert" [@@mel.module]
external equal : assertion -> 'a -> 'a -> unit = "equal" [@@mel.send]
external strict_equal : assertion -> 'a -> 'a -> unit = "strictEqual" [@@mel.send]
let strictEqual = strict_equal
