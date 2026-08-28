public import Argument_Primitive
public import Text

extension Argument {

    public struct Token: Sendable, Hashable, Equatable {

        public let kind: Argument.Token.Kind

        public let range: Text.Range

        @inlinable
        public init(kind: Argument.Token.Kind, range: Text.Range) {
            self.kind = kind
            self.range = range
        }
    }
}
