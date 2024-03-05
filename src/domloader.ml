(** Initialize the Node environment to make it ready to run tests *)
let init () =
  (* this function doesn't do anything, it just allows other modules to load the raw code below *)
  ()

(* Source: https://samthor.au/2022/test-react-builtin/ *)
[%%mel.raw
{|
import * as jsdom from 'jsdom';

const j = new jsdom.JSDOM(undefined, {
  // Many APIs are confused without being "on a real URL"
  url: 'http://localhost',
  // This adds dummy requestAnimationFrame and friends
  pretendToBeVisual: true,
});

// We need to add everything on JSDOM's window object to global scope.
// We don't add anything starting with _, or anything that's already there.
Object.getOwnPropertyNames(j.window)
    .filter((k) => !k.startsWith('_') && !(k in global))
    .forEach((k) => global[k] = j.window[k])

// Finally, tell React 18+ that we are not really a browser.
global.IS_REACT_ACT_ENVIRONMENT = true;
|}]
