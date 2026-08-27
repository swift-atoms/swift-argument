# swift-argument

`swift-argument` defines the Foundation-free core argument-schema vocabulary
shared by the Swift Institute command-line stack. It owns argument names, arity,
help, visibility, and schema nodes; tokenization and parsing belong to higher
layers.

## Quick start

```swift
import Argument

enum Repeat: Sendable {}

let schema = Argument.Schema.Definition<Repeat>(
    nodes: [
        Argument.Positional<String>(
            name: "phrase",
            placeholder: "phrase"
        ),
        Argument.Option<Int>(
            name: .long(try .init("count")),
            placeholder: "count",
            help: .init(abstract: "Number of repetitions.", defaults: "2")
        ),
        Argument.Flag(
            name: .long(try .init("verbose")),
            help: .init(abstract: "Enable verbose output.")
        ),
    ]
)
```

Schema visitors can consume the same declaration to build parsers, help text,
completion scripts, or other representations without duplicating metadata.

## Installation

```swift
dependencies: [
    .package(
        url: "https://github.com/swift-atoms/swift-argument.git",
        branch: "main"
    ),
],
targets: [
    .target(
        name: "MyTarget",
        dependencies: [
            .product(name: "Argument", package: "swift-argument"),
        ]
    ),
]
```

## Products

| Product | Module | Purpose |
|---|---|---|
| `Argument` | `Argument` | Core argument and schema vocabulary |
| `Argument Apple Foundation Integration` | `Argument_Apple_Foundation_Integration` | Apple Foundation integration and re-export |
| `Argument Test Support` | `Argument_Test_Support` | Recording schema visitor for tests |

Foundation is imported only by the Apple Foundation integration target. The
core and test-support targets remain Foundation-free.

## Extracted seams

The core retains the `Argument.Environment.Variable` namespace so integration
packages can extend it without moving the namespace into a higher layer.
[`swift-argument-tagged`](https://github.com/swift-molecules/swift-argument-tagged)
owns `Argument.Environment.Variable.Name` and its `Tagged` representation.

Environment lookup and the association between an option and an environment
variable belong above this atom.
