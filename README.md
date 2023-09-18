# SwiftCompilerPlugin
Swift macros without requiring swift-syntax

This project extracts the bare minimum from [swift-syntax](https://github.com/apple/swift-syntax) to be able to build a macro in Xcode 15. All you get are the strings, no fancy object trees.

If nothing else it will allow you to see what is *really* sent to your plugin before it's converted to structures etc.

### Example

Here's the classic example from the default Xcode template which implements `stringify` renamed here to be `ExpressionMacro`.

```swift
@freestanding(expression)
public macro ExpressionMacro<T>(_ value: T) -> (T, String) = #externalMacro(module: "ExampleMacros", type: "ExpressionMacro")

...

let (result, code) = #ExpressionMacro(a + b)
(a + b, "a + b")
/* {
  "expandFreestandingMacro" : {
    "macro" : {
      "moduleName" : "ExampleMacros",
      "name" : "ExpressionMacro",
      "typeName" : "ExpressionMacro"
    },
    "syntax" : {
      "kind" : "expression",
      "location" : {
        "fileID" : "ExampleClient\/main.swift",
        "fileName" : "•••/SwiftCompilerPlugin\/Examples\/Sources\/ExampleClient\/main.swift",
        "line" : 7,
        "offset" : 78,
        "column" : 22
      },
      "source" : "#ExpressionMacro(a + b)"
    },
    "discriminator" : "$s13ExampleClient33_C7C48FD1C44CD1E5F2188E7B86F2D462Ll15ExpressionMacrofMf_",
    "macroRole" : "expression"
  }
}*/
```
