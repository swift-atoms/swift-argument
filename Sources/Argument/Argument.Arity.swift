public import Cardinal

extension Argument {

    public enum Arity: Sendable, Hashable, Equatable {

        case exactly(Cardinal)

        case atMost(Cardinal)

        case atLeast(Cardinal)

        case range(ClosedRange<Cardinal>)

        case count
    }
}
