extension Argument.Name.Long {

    public enum Error: Swift.Error, Sendable, Hashable, Equatable {

        case empty

        case doesNotStartWithLetter(found: Character)

        case invalidCharacter(found: Character)
    }
}
