extension Argument.Schema {

    public struct Definition<Root: Sendable>: Sendable {

        public let nodes: [any Argument.Schema.Node]

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
