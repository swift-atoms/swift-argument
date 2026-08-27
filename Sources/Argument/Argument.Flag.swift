extension Argument {

    public struct Flag: Sendable, Hashable, Equatable {

        public let name: Argument.Name

        public let arity: Argument.Arity

        public let visibility: Argument.Visibility

        public let help: Argument.Help

        @inlinable
        public init(
            name: Argument.Name,
            arity: Argument.Arity = .atMost(1),
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.arity = arity
            self.visibility = visibility
            self.help = help
        }
    }
}
