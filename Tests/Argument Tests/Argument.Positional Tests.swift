import Testing

@testable import Argument

extension Argument.Positional<String> {
    @Suite
    struct `Positional arguments preserve fields defaults and value type independence` {
        @Suite struct `Positional construction and equality preserve declared fields` {
            @Test func `initializer carries explicit fields`() {
                let positional = Argument.Positional<String>(
                    name: "phrase",
                    placeholder: "phrase",
                    arity: .exactly(1),
                    visibility: .visible,
                    help: .init(abstract: "The phrase to repeat.")
                )
                #expect(positional.name == "phrase")
                #expect(positional.placeholder == "phrase")
                #expect(positional.arity == .exactly(1))
                #expect(positional.visibility == .visible)
                #expect(positional.help.abstract == "The phrase to repeat.")
            }

            @Test func `default arity is exactly(1)`() {
                let positional = Argument.Positional<String>(name: "x", placeholder: "x")
                #expect(positional.arity == .exactly(1))
            }

            @Test func `default visibility is visible`() {
                let positional = Argument.Positional<String>(name: "x", placeholder: "x")
                #expect(positional.visibility == .visible)
            }

            @Test func `An integer positional argument retains its supplied name`() {
                let positional = Argument.Positional<Int>(name: "count", placeholder: "count")
                #expect(positional.name == "count")
            }

            @Test func `Positional argument equality distinguishes different names`() {
                let a = Argument.Positional<String>(name: "x", placeholder: "x")
                let b = Argument.Positional<String>(name: "x", placeholder: "x")
                let c = Argument.Positional<String>(name: "y", placeholder: "x")
                #expect(a == b)
                #expect(a != c)
            }
        }

        @Suite struct `No positional argument boundary cases are defined` {}

        @Suite struct `No positional argument integration cases are defined` {}
    }
}
