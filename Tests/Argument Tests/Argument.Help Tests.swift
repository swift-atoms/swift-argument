import Testing

@testable import Argument

extension Argument.Help {
    @Suite
    struct `Argument help preserves supplied values and empty defaults` {
        @Suite struct `Help construction retains named values and defaults to empty fields` {
            @Test func `default initializer produces empty fields`() {
                let help = Argument.Help()
                #expect(help.abstract.isEmpty)
                #expect(help.discussion.isEmpty)
                #expect(help.placeholder == nil)
                #expect(help.defaults == nil)
            }

            @Test func `named initializer carries values`() {
                let help = Argument.Help(
                    abstract: "Count",
                    discussion: "The count.",
                    placeholder: "<n>",
                    defaults: "2"
                )
                #expect(help.abstract == "Count")
                #expect(help.discussion == "The count.")
                #expect(help.placeholder == "<n>")
                #expect(help.defaults == "2")
            }
        }

        @Suite struct `No argument help boundary cases are defined` {}

        @Suite struct `No argument help integration cases are defined` {}
    }
}
