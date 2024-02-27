external test : string -> (unit -> unit) -> unit = "test"
[@@mel.module "node:test"]
(** Create a test with a given name and callback function that runs the test *)

(** This promise-based module is needed for nested tests, see {: https://nodejs.org/api/test.html#subtests } *)
module Promise = struct
  (** {{:https://v2.ocaml.org/manual/bindingops.html }Monadic binding operator} for promises *)
  let ( let* ) p f = Js.Promise.then_ f p

  external test : string -> (unit -> unit Js.Promise.t) -> unit Js.Promise.t
    = "test"
  [@@mel.module "node:test"]
  (** Create a test with a given name and callback function that runs the test and returns a promise. *)
end

type assertion
(** Abstract type for the {{: https://nodejs.org/api/assert.html#strict-assertion-mode} node:assert/strict} module  *)

external expect : assertion = "node:assert/strict"
[@@mel.module]
(** The {{: https://nodejs.org/api/assert.html#strict-assertion-mode} node:assert/strict} module object *)

external equal : 'a -> 'a -> unit = "strictEqual"
[@@mel.send.pipe: assertion]
(** Tests strict equality between the actual and expected parameters as determined by {{: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is }Object.is()} *)

external deep_equal : 'a -> 'a -> unit = "deepStrictEqual"
[@@mel.send.pipe: assertion]
(** Tests for deep strict equality between the actual and expected parameters *)

(** Alias for {!deep_equal} *)
let deepEqual = deep_equal
