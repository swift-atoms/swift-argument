extension Argument {

    public struct Help: Sendable, Hashable, Equatable {

        public let abstract: String

        public let discussion: String

        public let placeholder: String?

        public let defaults: String?

        @inlinable
        public init(
            abstract: String = "",
            discussion: String = "",
            placeholder: String? = nil,
            defaults: String? = nil
        ) {
            self.abstract = abstract
            self.discussion = discussion
            self.placeholder = placeholder
            self.defaults = defaults
        }
    }
}
