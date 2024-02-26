(** Create a test with a given name and callback function that runs the test *)
external test : string -> (unit -> unit) -> unit = "test"
[@@mel.module "node:test"]

module Promise = struct
  let ( let* ) p f = Js.Promise.then_ f p

  (** Create a test with a given name and callback function that runs the test and returns a promise.

  The promise-based version is needed for nested tests, see {: https://nodejs.org/api/test.html#subtests } *)
  external test : string -> (unit -> unit Js.Promise.t) -> unit Js.Promise.t = "test" [@@mel.module "node:test"]
end

(** Abstract type for the [node:assert] module  *)
type assertion

(** The [node:assert/strict] module object *)
external expect : assertion = "node:assert/strict" [@@mel.module]


(** Tests strict equality between the actual and expected parameters as determined by [Object.is()] *)
external equal : 'a -> 'a -> unit = "strictEqual"
[@@mel.send.pipe: assertion]

(** Tests for deep strict equality between the actual and expected parameters. *)
external deep_equal: 'a -> 'a -> unit = "deepStrictEqual" [@@mel.send.pipe: assertion]

(** Alias for [deep_equal] *)
let deepEqual = deep_equal
