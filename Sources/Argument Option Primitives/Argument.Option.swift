extension Argument {

    public struct Option<V: Sendable & Equatable>: Sendable, Equatable {

        public let name: Argument.Name

        public let placeholder: String

        public let arity: Argument.Arity

        public let visibility: Argument.Visibility

        public let help: Argument.Help

        public let environment: Argument.Environment.Variable.Name?

        @inlinable
        public init(
            name: Argument.Name,
            placeholder: String,
            arity: Argument.Arity = .exactly(1),
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init(),
            environment: Argument.Environment.Variable.Name? = nil
        ) {
            self.name = name
            self.placeholder = placeholder
            self.arity = arity
            self.visibility = visibility
            self.help = help
            self.environment = environment
        }
    }
}
