public import Argument_Position_Primitives
public import Argument_Primitive
public import Diagnostic_Primitives

extension Argument {

    public enum Error: Swift.Error, Sendable, Hashable, Equatable {

        case unknownOption(name: String, position: Argument.Position)

        case missingValue(name: String, position: Argument.Position)

        case invalidValue(name: String, value: String, position: Argument.Position)

        case missingPositional(name: String, position: Argument.Position)

        case unexpectedPositional(value: String, position: Argument.Position)

        case missingSubcommand(position: Argument.Position)

        case unknownSubcommand(name: String, position: Argument.Position)

        case validationFailed(reason: String, position: Argument.Position)
    }
}

extension Argument.Error {

    @inlinable
    public var position: Argument.Position {
        switch self {
        case .unknownOption(_, let position),
            .missingValue(_, let position),
            .invalidValue(_, _, let position),
            .missingPositional(_, let position),
            .unexpectedPositional(_, let position),
            .missingSubcommand(let position),
            .unknownSubcommand(_, let position),
            .validationFailed(_, let position):
            return position
        }
    }

    @inlinable
    public var severity: Diagnostic.Severity {
        .error
    }
}
