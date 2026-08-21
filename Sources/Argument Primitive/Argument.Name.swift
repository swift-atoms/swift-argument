extension Argument {

    public enum Name: Sendable, Hashable, Equatable {

        case short(Argument.Name.Short)

        case long(Argument.Name.Long)

        case both(short: Argument.Name.Short, long: Argument.Name.Long)
    }
}

extension Argument.Name {

    @inlinable
    public var short: Argument.Name.Short? {
        switch self {
        case .short(let value): return value
        case .long: return nil
        case .both(let short, _): return short
        }
    }

    @inlinable
    public var long: Argument.Name.Long? {
        switch self {
        case .short: return nil
        case .long(let value): return value
        case .both(_, let long): return long
        }
    }
}
