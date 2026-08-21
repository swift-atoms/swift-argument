extension Argument.Name.Short {

    public enum Error: Swift.Error, Sendable, Hashable, Equatable {

        case notASCIIAlphanumeric(found: Character)
    }
}
