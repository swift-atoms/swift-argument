import Testing

@testable import Argument

extension Argument.Name {
    @Suite
    struct `Argument names expose their declared short and long forms` {
        @Suite struct `Argument name variants and literal factories preserve validated forms` {
            @Test func `short-only case exposes short, not long`() throws(Argument.Name.Short.Error)
            {
                let name = Argument.Name.short(try .init("v"))
                #expect(name.short?.character == "v")
                #expect(name.long == nil)
            }

            @Test func `long-only case exposes long, not short`() throws(Argument.Name.Long.Error) {
                let name = Argument.Name.long(try .init("verbose"))
                #expect(name.short == nil)
                #expect(name.long?.string == "verbose")
            }

            @Test func `both case exposes short and long`() {
                let name = Argument.Name.both(

                    short: try! .init("v"),

                    long: try! .init("verbose")
                )
                #expect(name.short?.character == "v")
                #expect(name.long?.string == "verbose")
            }

            @Test func `Argument.Name.Long.literal constructs validated long name without try`() {
                let name = Argument.Name.Long.literal("verbose")
                #expect(name.string == "verbose")
            }

            @Test func `Argument.Name.Short.literal constructs validated short name without try`() {
                let name = Argument.Name.Short.literal("v")
                #expect(name.character == "v")
            }

            @Test func `Argument.Name.Long.literal accepts hyphenated form`() {
                let name = Argument.Name.Long.literal("dry-run")
                #expect(name.string == "dry-run")
            }

            @Test func `canonical dotted-name forms compose at production sites`() {

                let names: [Argument.Name] = [
                    .long(.literal("verbose")),
                    .short(.literal("v")),
                    .both(short: .literal("h"), long: .literal("help")),
                ]
                #expect(names.count == 3)
                #expect(names[0].long?.string == "verbose")
                #expect(names[1].short?.character == "v")
                #expect(names[2].short?.character == "h")
                #expect(names[2].long?.string == "help")
            }
        }

        @Suite struct `No argument name boundary cases are defined` {}

        @Suite struct `No argument name integration cases are defined` {}
    }
}
