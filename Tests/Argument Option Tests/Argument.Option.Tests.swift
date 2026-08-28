import Testing

@testable import Argument_Option

extension Argument.Option<Int> {
    @Suite("Argument.Option")
    struct Test {
        @Suite struct Unit {
            @Test func `initializer carries explicit fields`() {
                let option = Argument.Option<Int>(

                    name: .both(short: try! .init("c"), long: try! .init("count")),
                    placeholder: "count",
                    arity: .exactly(1),
                    visibility: .visible,
                    help: .init(abstract: "Repeat count.", defaults: "2")
                )
                #expect(option.placeholder == "count")
                #expect(option.arity == .exactly(1))
                #expect(option.visibility == .visible)
                #expect(option.help.abstract == "Repeat count.")
                #expect(option.help.defaults == "2")
            }

            @Test func `default arity is exactly(1)`() throws(Argument.Name.Long.Error) {
                let option = Argument.Option<Int>(
                    name: .long(try .init("count")),
                    placeholder: "count"
                )
                #expect(option.arity == .exactly(1))
            }

            @Test func `environment variable defaults to nil`() throws(Argument.Name.Long.Error) {
                let option = Argument.Option<Int>(
                    name: .long(try .init("count")),
                    placeholder: "count"
                )
                #expect(option.environment == nil)
            }

            @Test func `environment variable carries name when supplied`() throws(Argument.Name.Long
                .Error)
            {
                let varName = "MYAPP_COUNT"
                let option = Argument.Option<Int>(
                    name: .long(try .init("count")),
                    placeholder: "count",
                    environment: varName
                )
                #expect(option.environment == varName)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
