extension Argument.Schema {

    public protocol Visitor {

        associatedtype Failure: Swift.Error = Never

        mutating func visit<V: Sendable & Equatable>(
            positional: Argument.Positional<V>
        ) throws(Failure)

        mutating func visit<V: Sendable & Equatable>(
            option: Argument.Option<V>
        ) throws(Failure)

        mutating func visit(flag: Argument.Flag) throws(Failure)

        mutating func visit<G: Sendable>(group: Argument.Group<G>) throws(Failure)

        mutating func visit<S: Sendable>(
            subcommand: Argument.Subcommand<S>
        ) throws(Failure)
    }
}
