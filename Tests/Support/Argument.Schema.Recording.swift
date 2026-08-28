extension Argument.Schema {

    public struct Recording: Sendable {

        public private(set) var events: [Event]

        public init() {
            self.events = []
        }
    }
}

extension Argument.Schema.Recording {

    public enum Event: Sendable, Hashable, Equatable {
        case positional
        case option
        case flag
        case group
        case subcommand
    }
}

extension Argument.Schema.Recording: Argument.Schema.Visitor {
    public typealias Failure = Never

    public mutating func visit<V: Sendable & Equatable>(
        positional: Argument.Positional<V>
    ) throws(Never) {
        events.append(.positional)
    }

    public mutating func visit<V: Sendable & Equatable>(
        option: Argument.Option<V>
    ) throws(Never) {
        events.append(.option)
    }

    public mutating func visit(flag: Argument.Flag) throws(Never) {
        events.append(.flag)
    }

    public mutating func visit<G: Sendable>(group: Argument.Group<G>) throws(Never) {
        events.append(.group)
    }

    public mutating func visit<S: Sendable>(
        subcommand: Argument.Subcommand<S>
    ) throws(Never) {
        events.append(.subcommand)
    }
}
