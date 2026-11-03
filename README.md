# swift-argument

Use this package when you need the vocabulary for describing a command line, not a parser: you declare positionals, options, flags, groups and subcommands as values, collect them in an `Argument.Schema.Definition<Root>`, and walk them with your own `Argument.Schema.Visitor`. It also supplies the shared building blocks a parser reports in, such as `Argument.Name`, `Argument.Arity`, `Argument.Token`, `Argument.Position` and `Argument.Error`. To parse argv, render help or run a command, use the sibling composition package swift-arguments, which builds on these types.

## Laws

- Every declaration here is descriptive metadata. Nothing in this package reads argv or the environment, counts values or occurrences against an `Argument.Arity`, hides anything marked `Argument.Visibility.hidden`, or applies `Argument.Help.defaults`. A consumer gives these their meaning.
- The generic parameters of `Argument.Positional<V>`, `Argument.Option<V>`, `Argument.Group<G>`, `Argument.Subcommand<S>` and `Argument.Schema.Definition<Root>` are phantom tags. No value of them is stored, and nothing checks that the nodes in a definition belong to its `Root`.
- `Argument.Schema.Definition.accept(_:)` visits each node once, in the order of `nodes`, and each node calls the one visitor method for its own kind. The first failure a visitor throws ends the walk, and later nodes are not visited.
- `Argument.Subcommand.Choice` keeps its declarations in the order given.
- A checked `Argument.Name.Long` starts with an ASCII letter, followed only by ASCII letters, ASCII digits and hyphens. A checked `Argument.Name.Short` is one ASCII letter or digit. The `_unchecked` initializers skip these checks. The `literal` factories run them and stop the program on an invalid name.
- `Argument.Option.environment` holds only the name of an environment variable. The `Argument.Environment.Variable.Name` initializer stores that name's underlying string.
- Every `Argument.Error` has severity `.error`.
