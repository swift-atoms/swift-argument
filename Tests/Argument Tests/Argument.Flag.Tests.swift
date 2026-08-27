import Testing

@testable import Argument

extension Argument.Flag {
    @Suite("Argument.Flag")
    struct Test {
        @Suite struct Unit {
            @Test func `initializer carries explicit fields`() throws(Argument.Name.Long.Error) {
                let flag = Argument.Flag(
                    name: .long(try .init("verbose")),
                    arity: .atMost(1),
                    visibility: .visible,
                    help: .init(abstract: "Verbose output.")
                )
                #expect(flag.arity == .atMost(1))
                #expect(flag.visibility == .visible)
                #expect(flag.help.abstract == "Verbose output.")
            }

            @Test func `default arity is atMost(1)`() throws(Argument.Name.Long.Error) {
                let flag = Argument.Flag(name: .long(try .init("verbose")))
                #expect(flag.arity == .atMost(1))
            }

            @Test func `count arity supports verbosity-style flag`() throws(Argument.Name.Short
                .Error)
            {
                let flag = Argument.Flag(
                    name: .short(try .init("v")),
                    arity: .count
                )
                #expect(flag.arity == .count)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
