extension Argument {

    public struct Group<G: Sendable>: Sendable {

        public let name: String

        public let visibility: Argument.Visibility

        public let help: Argument.Help

        @inlinable
        public init(
            name: String,
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.visibility = visibility
            self.help = help
        }
    }
}
