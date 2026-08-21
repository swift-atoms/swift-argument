extension Argument.Name {

    public struct Short: Sendable, Hashable, Equatable {

        public let character: Character

        @inlinable
        public init(_unchecked character: Character) {
            self.character = character
        }
    }
}

extension Argument.Name.Short {

    @inlinable
    public init(_ character: Character) throws(Error) {
        guard character.isASCII, character.isLetter || character.isNumber else {
            throw .notASCIIAlphanumeric(found: character)
        }
        self.character = character
    }
}

extension Argument.Name.Short {

    @inlinable
    public static func literal(_ name: Character) -> Argument.Name.Short {
        do throws(Error) {
            return try Argument.Name.Short(name)
        } catch {
            preconditionFailure(
                "Argument.Name.Short.literal: '\(name)' is not a single ASCII alphanumeric (\(error))"
            )
        }
    }
}
