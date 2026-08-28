# Swift Argument

Intrinsic command-line argument vocabulary for the Swift Atoms ecosystem.

The package owns the `Argument` namespace, validated names, arity, help and
visibility metadata, schema declarations, and the intrinsic schema node types:
`Positional`, `Option`, `Flag`, `Group`, and `Subcommand`. It does not tokenize,
parse, diagnose, or attach representation-specific identifiers.

## Products

| Product | Declaration ownership |
|---|---|
| `Argument` | Namespace, names, arity, help, visibility, and environment namespaces |
| `Argument Positional` | `Argument.Positional` |
| `Argument Option` | `Argument.Option` |
| `Argument Flag` | `Argument.Flag` |
| `Argument Group` | `Argument.Group` |
| `Argument Subcommand` | `Argument.Subcommand` and `Choice` |
| `Argument Schema` | Schema, node, visitor, definition, and intrinsic node conformances |
| `Argument Schema Test Support` | Schema visitor recording support |

Consumers should depend on the narrowest product they use. There is no umbrella
product that re-exports every declaration.

```swift
import Argument_Schema

enum Command {}

let schema = Argument.Schema.Definition<Command>(
    nodes: [
        Argument.Positional<String>(name: "input", placeholder: "path"),
        Argument.Option<Int>(
            name: .long(try .init("count")),
            placeholder: "count"
        ),
        Argument.Flag(name: .long(try .init("verbose"))),
    ]
)
```

## Focused integrations

- `swift-argument-index` owns `Argument.Position`.
- `swift-argument-diagnostic` owns `Argument.Error`.
- `swift-argument-tagged` owns `Argument.Environment.Variable.Name` and the
  typed environment-name option initializer.
- `swift-argument-text` owns `Argument.Token` and `Argument.Token.Kind`.
- `swift-argument-finite` owns `Argument.Flag.Enumerable`.
- Parser behavior belongs to the separate argument-parser integration package.

`Argument.Option.environment` stores the dependency-free raw environment name.
Import `Argument_Tagged` when constructing an option with the tagged name type.

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
