external test : string -> (unit -> unit) -> unit = "test" [@@mel.module "node:test"]

type assertion
external expect : assertion = "assert" [@@mel.module]
external equal : 'a -> 'a -> assertion -> unit = "equal" [@@mel.send]
external strict_equal : 'a -> 'a -> assertion -> unit = "strictEqual" [@@mel.send]
let strictEqual = strict_equal
