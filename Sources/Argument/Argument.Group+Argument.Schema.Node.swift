extension Argument.Group: Argument.Schema.Node {

    @inlinable
    public func accept<Visitor: Argument.Schema.Visitor>(
        _ visitor: inout Visitor
    ) throws(Visitor.Failure) {
        try visitor.visit(group: self)
    }
}
