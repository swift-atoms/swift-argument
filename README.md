# Argument

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

CLI argument-parsing vocabulary — `Argument.Name`, `Argument.Arity`, `Argument.Token`, `Argument.Schema.Node`, `Argument.Schema.Visitor`, and the schema-as-data combinators (`Positional`, `Option`, `Flag`, `Group`, `Subcommand`) — for the L3 / L4 argument-parser stack.

---

## Key Features

- **Vocabulary, not parsing** — owns the typed vocabulary that argv tokenization (L3, `swift-ieee-1003`) and argv-to-command parsing (L4, `swift-arguments`) compose. No tokenizer, no parser, no `Codable`-equivalent at this layer. The L2 boundary is the type catalog; logic lives at L3 and L4.
- **Validated names** — `Argument.Name.Short` checks POSIX 12.2 Guideline 3 (single ASCII alphanumeric); `Argument.Name.Long` checks GNU long-options `[a-zA-Z][a-zA-Z0-9-]*`. Both throw typed errors at construction; `__unchecked:` initializers bypass when callers can prove validity.
- **Schema as data** — `Argument.Schema.Definition<Root>` carries `[any Argument.Schema.Node]`. Visitors implementing `Argument.Schema.Visitor` walk a definition once and emit help text, completion scripts, manpages, or a parse configuration — same data, every direction.
- **Generic over the parsed-value type** — `Argument.Positional<V>`, `Argument.Option<V>` carry the typed value through the visitor; the schema visitor sees the same `V` the parser sees, so help-text emission and parsing share one source of truth (no second metadata channel).
- **`Diagnostic.Severity` for errors** — `Argument.Error` cases carry an `Argument.Position` (argv index + byte offset) and an instance-level `severity` accessor returning `Diagnostic.Severity`. L4 consumers route into the institute diagnostic stack without re-wrapping.
- **Tagged identifier for env-var fallback** — `Argument.Environment.Variable.Name` is `Tagged<Argument.Environment.Variable, String>`. The institute typed-identifier framework distinguishes env-var names from arbitrary strings at type-check time; the Tagged SLI gives string-literal ergonomics for free.
- **Foundation-free** — no `import Foundation` anywhere. The package compiles on Embedded targets and on platforms without a Foundation port.

---

## Quick Start

### Declaring an argument schema

```swift
import Argument

enum Repeat {}   // Root type — fields populated by the parser at L4

let nodes: [any Argument.Schema.Node] = [
    Argument.Positional<String>(
        name: "phrase",
        placeholder: "phrase",
        arity: .exactly(1),
        help: .init(abstract: "The phrase to repeat.")
    ),
    Argument.Option<Int>(
        name: .both(short: try .init("c"), long: try .init("count")),
        placeholder: "count",
        help: .init(abstract: "Number of repetitions.", defaults: "2")
    ),
    Argument.Flag(
        name: .long(try .init("include-counter")),
        help: .init(abstract: "Prefix each line with its index.")
    ),
]

let schema = Argument.Schema.Definition<Repeat>(nodes: nodes)
```

This is data. No parsing happens. The L4 layer composes it into a `Parser.Protocol` over argv; visitors emit help text and other artifacts.

### Walking a schema with a visitor

```swift
import Argument

// A visitor that emits one line per node, naming its kind.
struct Summary: Argument.Schema.Visitor {
    typealias Failure = Never
    var lines: [String] = []
    mutating func visit<V: Sendable & Equatable>(positional: Argument.Positional<V>) {
        lines.append("positional \(positional.name)")
    }
    mutating func visit<V: Sendable & Equatable>(option: Argument.Option<V>) {
        lines.append("option \(option.placeholder)")
    }
    mutating func visit(flag: Argument.Flag) {
        lines.append("flag")
    }
    mutating func visit<G: Sendable>(group: Argument.Group<G>) {
        lines.append("group \(group.placeholder)")
    }
    mutating func visit<S: Sendable>(subcommand: Argument.Subcommand<S>) {
        lines.append("subcommand \(subcommand.name)")
    }
}

var summary = Summary()
try schema.accept(&summary)
// summary.lines == ["positional phrase", "option count", "flag"]
```

A help-text emitter, a bash-completion emitter, and a manpage emitter are each a different `Visitor` over the same `Argument.Schema.Definition`. The schema is not regenerated per output format.

### Validated short and long names

```swift
import Argument

let v = try Argument.Name.Short("v")           // OK — single ASCII alphanumeric
let verbose = try Argument.Name.Long("verbose") // OK
let dashed = try Argument.Name.Long("dry-run") // OK — hyphens permitted after the leading letter

do {
    _ = try Argument.Name.Short("ø")  // throws .notASCIIAlphanumeric(found: "ø")
} catch let error {
    print(error)
}

do {
    _ = try Argument.Name.Long("9lives")  // throws .doesNotStartWithLetter(found: "9")
} catch let error {
    print(error)
}
```

### Environment-variable identifier

```swift
import Argument

// Tagged SLI gives string-literal ergonomics.
let verbosity: Argument.Environment.Variable.Name = "MYAPP_VERBOSITY"

let option = Argument.Option<Int>(
    name: .both(short: try .init("v"), long: try .init("verbosity")),
    placeholder: "n",
    help: .init(abstract: "Verbosity level."),
    environmentVariable: verbosity
)
```

L4 (`swift-environment`) resolves the env-var fallback at parse time; L2 only declares the typed name.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-argument.git", branch: "main"),
],
targets: [
    .target(
        name: "MyTarget",
        dependencies: [
            .product(name: "Argument", package: "swift-argument"),
        ]
    ),
],
```

For consumers needing only one variant (say, just the `Argument.Schema` machinery), depend on the specific product instead of the umbrella:

```swift
.product(name: "Argument Schema", package: "swift-argument"),
```

---

## Products

| Product | Contents | Import when... |
|---|---|---|
| `Argument Namespace` | `public enum Argument {}` only | Adding sub-namespaces or typealiases without depending on Core's catalog |
| `Argument Core` | `Name`, `Arity`, `Visibility`, `Help`, `Token`, `Error`, `Position`, `Environment.Variable.Name` | Implementing tokenizers or low-level consumers |
| `Argument Positional` | `Argument.Positional<V>` | Building a schema by hand |
| `Argument Option` | `Argument.Option<V>` | Building a schema by hand |
| `Argument Flag` | `Argument.Flag` | Building a schema by hand |
| `Argument Group` | `Argument.Group<G>` | Building a schema by hand |
| `Argument Subcommand` | `Argument.Subcommand<S>`, `Argument.Subcommand.Choice` | Composing subcommand trees |
| `Argument Schema` | `Argument.Schema.Definition<Root>`, `Argument.Schema.Node`, `Argument.Schema.Visitor` | Writing a visitor (help, completion, manpage) |
| `Argument` | Umbrella — re-exports everything above | General consumers; L4 schema authors |
| `Argument Test Support` | `Argument.Schema.Recording` plus Tagged SLI re-export | Test targets verifying schema traversal |

---

## Architecture

```
Argument
├── Name
│   ├── Short                 — validated single ASCII alphanumeric (POSIX 12.2 G3)
│   └── Long                  — validated [a-zA-Z][a-zA-Z0-9-]* (GNU long-options)
├── Arity                     — exactly | atMost | atLeast | range | count
├── Visibility                — visible | hidden
├── Help                      — abstract / discussion / placeholder / defaults
├── Token                     — argv-derived token
│   └── Kind                  — long | shortCluster | value | separator | positional | endOfOptions
├── Error                     — typed parse-time errors keyed to Argument.Position
├── Position                  — (argvIndex, byteOffset)
├── Environment
│   └── Variable
│       └── Name              — Tagged<Variable, String>
├── Positional<V>             — schema node: positional argument
├── Option<V>                 — schema node: named option
├── Flag                      — schema node: boolean flag
├── Group<G>                  — schema node: nested group
├── Subcommand<S>             — schema node: subcommand
│   └── Choice                — set of subcommand declarations (OneOf-shaped)
└── Schema
    ├── Definition<Root>      — ordered [any Schema.Node]; the schema-as-data root
    ├── Node                  — protocol; double-dispatches to Visitor
    └── Visitor               — protocol; receives typed dispatch per kind
```

Each combinator type (`Positional<V>`, `Option<V>`, …) conforms to `Argument.Schema.Node`, supplying its own `accept(_:)` that dispatches the visitor to its kind-specific `visit(...)` method. The visitor recovers the static value type `V` at the visit site through double-dispatch.

Tokenization (POSIX 12.2, GNU long-options) is owned by the L3 package `swift-ieee-1003`. Parsing argv to a `Root`, schema-builder DSL, help-text emission, env-var resolution, and exit-code dispatch are owned by the L4 package `swift-arguments`.

---

## Platform Support

[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswift-molecules%2Fswift-argument%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/swift-molecules/swift-argument)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswift-molecules%2Fswift-argument%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swift-molecules/swift-argument)

Compiles on every platform with a Swift 6.3+ toolchain. No Foundation dependency, no platform-specific code.

---

## Error Handling

`Argument.Error` is the parse-time error domain. Cases carry an `Argument.Position` (argv index + byte offset) and an instance `.severity` accessor returning `Diagnostic.Severity` (`.error` by default; L4 layers may demote per case).

```swift
let position = Argument.Position(argvIndex: 1, byteOffset: 0)
switch Argument.Error.unknownOption(name: "--unknown", position: position) {
case .unknownOption(let name, let pos):       handleUnknown(name, at: pos)
case .missingValue(let name, let pos):        handleMissingValue(name, at: pos)
case .invalidValue(let name, let value, let pos): handleInvalid(name, value, at: pos)
case .missingPositional(let name, let pos):   handleMissingPositional(name, at: pos)
case .unexpectedPositional(let value, let pos): handleUnexpected(value, at: pos)
case .missingSubcommand(let pos):             handleMissingSubcommand(at: pos)
case .unknownSubcommand(let name, let pos):   handleUnknownSubcommand(name, at: pos)
case .validationFailed(let reason, let pos):  handleValidationFailure(reason, at: pos)
}
```

Construction errors (`Argument.Name.Short.Error`, `Argument.Name.Long.Error`) are separate domains thrown at construction time. They are never thrown by parsing — only by callers building schema nodes from untrusted strings.

---

## Related Packages

- [`swift-tagged`](https://github.com/swift-molecules/swift-tagged) — phantom-typed `Tagged<Tag, Underlying>`, used here for `Argument.Environment.Variable.Name`.
- [`swift-text`](https://github.com/swift-molecules/swift-text) — `Text.Range`, used inside `Argument.Token` for source byte-range provenance.
- [`swift-diagnostic`](https://github.com/swift-molecules/swift-diagnostic) — `Diagnostic.Severity`, used by `Argument.Error.severity`.
- [`swift-parser`](https://github.com/swift-molecules/swift-parser) — `Parser.Protocol` substrate. L2 combinator targets depend on it so future schema-bound parsers can be expressed.
- `swift-ieee-1003` (L3 standards, planned) — POSIX 12.2 utility-syntax tokenization.
- `swift-arguments` (L4 compositions, planned) — schema-bound argv parser, help-text emitter, subcommand dispatch.

---

## Stability

Pre-1.0. The public API surface — type names, case layouts, initializer parameters — is stable for the v1 scope (covered in `Research/2026-05-15-swift-arguments-ecosystem-design.md` in the swift-institute repo). Additions are SemVer-additive; renames or case structure changes are SemVer-breaking.

Consumers tracking `main` should expect occasional additions; pinned tags will not break their existing call sites within the same minor.

---

## License

Apache 2.0 — see [LICENSE.md](./LICENSE.md).

---

## Community

<!-- discussion-link:start -->
<!-- discussion-link:end -->
