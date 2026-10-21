extension Argument.Schema {

    public struct Definition<Root: Sendable>: Sendable {

        // swiftlint:disable:next no_any_protocol_existential  // reason: schema nodes are heterogeneous
        public let nodes: [any Argument.Schema.Node]

        // swift-linter:disable:next existential parameter
        // REASON: A schema deliberately stores heterogeneous node kinds in declaration order.
        // swiftlint:disable:next no_any_protocol_existential  // reason: schema nodes are heterogeneous
        @inlinable
        public init(nodes: [any Argument.Schema.Node]) {
            self.nodes = nodes
        }
    }
}

extension Argument.Schema.Definition {

    @inlinable
    public func accept<Visitor: Argument.Schema.Visitor>(
        _ visitor: inout Visitor
    ) throws(Visitor.Failure) {
        for node in nodes {
            try node.accept(&visitor)
        }
    }
}
