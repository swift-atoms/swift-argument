extension Argument.Positional: Argument.Schema.Node {

    @inlinable
    public func accept<Visitor: Argument.Schema.Visitor>(
        _ visitor: inout Visitor
    ) throws(Visitor.Failure) {
        try visitor.visit(positional: self)
    }
}
