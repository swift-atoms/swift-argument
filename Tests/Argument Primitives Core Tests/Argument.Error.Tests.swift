import Diagnostic_Primitives
import Testing

@testable import Argument_Primitives_Test_Support

extension Argument.Error {
    @Suite("Argument.Error")
    struct Test {
        @Suite struct Unit {
            @Test func `position accessor returns the case's position payload`() {
                let position = Argument.Position(argvIndex: 1, byteOffset: 0)
                let error = Argument.Error.unknownOption(name: "--foo", position: position)

                #expect(error.position == position)
            }

            @Test func `severity is .error by default for all cases`() {
                let position = Argument.Position(argvIndex: 0, byteOffset: 0)
                let cases: [Argument.Error] = [
                    .unknownOption(name: "--foo", position: position),
                    .missingValue(name: "--foo", position: position),
                    .invalidValue(name: "--foo", value: "x", position: position),
                    .missingPositional(name: "phrase", position: position),
                    .unexpectedPositional(value: "x", position: position),
                    .missingSubcommand(position: position),
                    .unknownSubcommand(name: "x", position: position),
                    .validationFailed(reason: "x", position: position),
                ]
                for error in cases {
                    #expect(error.severity == .error)
                }
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
