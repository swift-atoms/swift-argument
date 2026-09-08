import Testing

@testable import Argument

extension Argument.Name.Short {
    @Suite
    struct `Short argument names validate ASCII characters and support unchecked construction` {
        @Suite struct `Short names accept ASCII letters and digits and permit unchecked characters` {
            @Test func `Short names preserve an ASCII lowercase letter`() throws(Argument.Name.Short.Error) {
                let name = try Argument.Name.Short("f")
                #expect(name.character == "f")
            }

            @Test func `Short names preserve an ASCII digit`() throws(Argument.Name.Short.Error) {
                let name = try Argument.Name.Short("3")
                #expect(name.character == "3")
            }

            @Test func `Short names preserve an ASCII uppercase letter`() throws(Argument.Name.Short.Error) {
                let name = try Argument.Name.Short("F")
                #expect(name.character == "F")
            }

            @Test func `unchecked initializer bypasses validation`() {
                let name = Argument.Name.Short(_unchecked: "ø")
                #expect(name.character == "ø")
            }

            @Test func `literal factory constructs validated character without try`() {
                let name = Argument.Name.Short.literal("v")
                #expect(name.character == "v")
            }

            @Test func `literal factory accepts ASCII digit`() {
                let name = Argument.Name.Short.literal("3")
                #expect(name.character == "3")
            }

            @Test func `literal factory accepts uppercase letter`() {
                let name = Argument.Name.Short.literal("F")
                #expect(name.character == "F")
            }
        }

        @Suite struct `Short name validation rejects non ASCII letters and punctuation` {
            @Test func `Short name validation rejects a non ASCII letter`() {
                #expect(throws: Argument.Name.Short.Error.notASCIIAlphanumeric(found: "ø")) {
                    _ = try Argument.Name.Short("ø")
                }
            }

            @Test func `Short name validation rejects punctuation`() {
                #expect(throws: Argument.Name.Short.Error.notASCIIAlphanumeric(found: "-")) {
                    _ = try Argument.Name.Short("-")
                }
            }
        }

        @Suite struct `No short argument name integration cases are defined` {}
    }
}
