extension Argument {

    public struct Subcommand<S: Sendable>: Sendable {

        public let name: String

        public let aliases: [String]

        public let visibility: Argument.Visibility

        public let help: Argument.Help

        @inlinable
        public init(
            name: String,
            aliases: [String] = [],
            visibility: Argument.Visibility = .visible,
            help: Argument.Help = .init()
        ) {
            self.name = name
            self.aliases = aliases
            self.visibility = visibility
            self.help = help
        }
    }
}
