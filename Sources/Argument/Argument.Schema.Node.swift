extension Argument.Schema {

    public protocol Node: Sendable {

        func accept<V: Argument.Schema.Visitor>(_ visitor: inout V) throws(V.Failure)
    }
}
