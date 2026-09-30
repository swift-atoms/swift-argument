#if Finite
public import Finite

extension Argument.Flag {

    public protocol Enumerable: Finite.Enumerable, Hashable, Sendable {

        static func name(for value: Self) -> Argument.Name.Long

        static func help(for value: Self) -> Argument.Help
    }
}
#endif
