extension Argument {

    public enum Arity: Sendable, Hashable, Equatable {

        case exactly(Int)

        case atMost(Int)

        case atLeast(Int)

        case range(ClosedRange<Int>)

        case count
    }
}
