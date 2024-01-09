external test : string -> (unit -> unit) -> unit = "test" [@@mel.module "node:test"]

type assertion
external expect : assertion = "assert" [@@mel.module]
external equal : 'a -> 'a -> unit = "equal" [@@mel.send.pipe: assertion]
external strict_equal : 'a -> 'a -> unit = "strictEqual" [@@mel.send.pipe: assertion]
let strictEqual = strict_equal
