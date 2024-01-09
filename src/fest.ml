external test : string -> (unit -> unit) -> unit = "test"
[@@mel.module "node:test"]

module Promise = struct
  let ( let* ) p f = Js.Promise.then_ f p

  (* The promise-based version is needed for nested tests,
     see https://nodejs.org/api/test.html#subtests *)
  external test : string -> (unit -> unit Js.Promise.t) -> unit Js.Promise.t
    = "test"
  [@@mel.module "node:test"]
end

type assertion

external expect : assertion = "assert" [@@mel.module]
external equal : 'a -> 'a -> unit = "equal" [@@mel.send.pipe: assertion]

external strict_equal : 'a -> 'a -> unit = "strictEqual"
[@@mel.send.pipe: assertion]

let strictEqual = strict_equal
