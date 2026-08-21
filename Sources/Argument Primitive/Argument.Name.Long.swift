extension Argument.Name {

    public struct Long: Sendable, Hashable, Equatable {

        public let string: String

        @inlinable
        public init(_unchecked string: String) {
            self.string = string
        }
    }
}

extension Argument.Name.Long {

    @inlinable
    public init(_ string: String) throws(Error) {
        guard let first = string.first else {
            throw .empty
        }
        guard first.isASCII, first.isLetter else {
            throw .doesNotStartWithLetter(found: first)
        }
        for character in string.dropFirst() {
            guard character.isASCII else {
                throw .invalidCharacter(found: character)
            }
            guard character.isLetter || character.isNumber || character == "-" else {
                throw .invalidCharacter(found: character)
            }
        }
        self.string = string
    }
}

extension Argument.Name.Long {

    @inlinable
    public static func literal(_ name: StaticString) -> Argument.Name.Long {
        let string = "\(name)"
        do throws(Error) {
            return try Argument.Name.Long(string)
        } catch {
            preconditionFailure(
                "Argument.Name.Long.literal: '\(string)' is not a valid GNU long option name (\(error))"
            )
        }
    }
}
