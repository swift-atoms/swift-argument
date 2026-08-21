public import Finite_Primitives

extension Argument.Flag {

    public protocol Enumerable: Finite.Enumerable, Hashable {

        static func name(for value: Self) -> Argument.Name.Long

        static func help(for value: Self) -> Argument.Help
    }
}
