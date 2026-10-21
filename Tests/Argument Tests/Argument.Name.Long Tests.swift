import Testing

@testable import Argument

extension Argument.Name.Long {
    @Suite
    struct Test {
        @Suite struct Unit {
            @Test func `Long names preserve a simple letter sequence`() throws(Argument.Name.Long
                .Error)
            {
                let name = try Argument.Name.Long("verbose")
                #expect(name.string == "verbose")
            }

            @Test func `Long names preserve hyphenated text`() throws(Argument.Name.Long.Error) {
                let name = try Argument.Name.Long("dry-run")
                #expect(name.string == "dry-run")
            }

            @Test func `Long names preserve a letter followed by digits`() throws(Argument.Name.Long
                .Error)
            {
                let name = try Argument.Name.Long("v2")
                #expect(name.string == "v2")
            }

            @Test func `literal factory constructs validated name without try`() {
                let name = Argument.Name.Long.literal("verbose")
                #expect(name.string == "verbose")
            }

            @Test func `literal factory accepts hyphenated form`() {
                let name = Argument.Name.Long.literal("dry-run")
                #expect(name.string == "dry-run")
            }

            @Test func `literal factory accepts letter-followed-by-digits`() {
                let name = Argument.Name.Long.literal("v2")
                #expect(name.string == "v2")
            }
        }

        @Suite
        struct `Edge Case` {
            @Test func `Long name validation rejects an empty string`() {
                #expect(throws: Argument.Name.Long.Error.empty) {
                    _ = try Argument.Name.Long("")
                }
            }

            @Test func `Long name validation rejects a leading digit`() {
                #expect(throws: Argument.Name.Long.Error.doesNotStartWithLetter(found: "9")) {
                    _ = try Argument.Name.Long("9lives")
                }
            }

            @Test func `Long name validation rejects an underscore`() {
                #expect(throws: Argument.Name.Long.Error.invalidCharacter(found: "_")) {
                    _ = try Argument.Name.Long("dry_run")
                }
            }

            @Test func `Long name validation rejects a non ASCII character`() {
                #expect(throws: Argument.Name.Long.Error.invalidCharacter(found: "ø")) {
                    _ = try Argument.Name.Long("nøde")
                }
            }
        }

        @Suite struct Integration {}
    }
}
