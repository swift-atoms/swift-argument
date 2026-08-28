extension Argument.Subcommand {

    public struct Choice: Sendable {

        public let declarations: [Argument.Subcommand<S>]

        @inlinable
        public init(declarations: [Argument.Subcommand<S>]) {
            self.declarations = declarations
        }
    }
}
