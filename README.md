# melange-fest

A minimal test framework for Melange using [Node test
runner](https://nodejs.org/api/test.html).

## Quick Start

```reason
open Fest

test("1+1=2", () => expect |> equal(1 + 1, 2));
```

### React

React support is provided by
[`reason-react`](https://github.com/reasonml/reason-react/).

```reason
open Fest;
module RTL = ReactTestingLibrary;
[@mel.get] external textContent: Dom.element => string = "textContent";

Domloader.init();

module Hello = {
  [@react.component]
  let make = (~text) => <div> {"Hello " ++ text |> React.string} </div>;
};

let () =
  test("test component", () => {
    let result = RTL.render(<Hello text="Nila" />);

    // Check that Hello component renders the name properly.
    let el = RTL.getByText(~matcher=`Str("Hello Nila"), result);
    expect |> equal(textContent(el), "Hello Nila");
  });
```

## Commands

Run all tests:

```bash
make test
```
