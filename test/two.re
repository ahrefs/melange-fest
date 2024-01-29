open Fest;
module RTL = ReactTestingLibrary;
[@mel.get] external textContent: Dom.element => string = "textContent";

Domloader.init();

module Hello = {
  [@react.component]
  let make = (~text) => <div> {("Hello " ++ text)->React.string} </div>;
};

let () =
  test("test component", () => {
    let result = RTL.render(<Hello text="Nila" />);

    // Check that Hello component renders the name properly.
    let el = RTL.getByText(~matcher=`Str("Hello Nila"), result);
    expect |> strictEqual(textContent(el), "Hello Nila");
  });

type foo =
  | Foo(int);

type bar = {
  foo,
  bar: string,
};

test("test variant", () =>
  expect
  |> deepStrictEqual(
       {foo: Foo(42), bar: "hello"},
       {
         let bar = {foo: Foo(40), bar: "hell"};
         let bar = {...bar, bar: bar.bar ++ "o"};
         let bar = {
           ...bar,
           foo:
             switch (bar.foo) {
             | Foo(x) => Foo(x + 2)
             },
         };
         bar;
       },
     )
);
