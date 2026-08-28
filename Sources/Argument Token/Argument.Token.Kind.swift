public import Argument_Primitive

extension Argument.Token {

    public enum Kind: Sendable, Hashable, Equatable {

        case long(String)

        case shortCluster(String)

        case value(String)

        case separator

        case positional(String)

        case endOfOptions
    }
}
