import Testing

@testable import Argument

extension Argument.Flag {
    @Suite
    struct `Argument flags preserve explicit fields and default arity` {
        @Suite struct `Flag construction retains supplied fields and supports count arity` {
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

        @Suite struct `No argument flag boundary cases are defined` {}

        @Suite struct `No argument flag integration cases are defined` {}
    }
}
