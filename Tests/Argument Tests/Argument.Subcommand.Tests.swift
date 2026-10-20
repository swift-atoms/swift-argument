import Testing

@testable import Argument

private struct PushResult: Sendable {}

private enum Result: Sendable {
    case push
    case pull
}

extension Argument.Subcommand<PushResult> {
    @Suite
    struct `Argument subcommands preserve supplied fields and default aliases` {
        @Suite struct `Subcommand construction retains explicit fields and defaults to visible` {
            @Test func `initializer carries explicit fields`() {
                let subcommand = Argument.Subcommand<PushResult>(
                    name: "push",
                    aliases: ["p"],
                    visibility: .visible,
                    help: .init(abstract: "Push.")
                )
                #expect(subcommand.name == "push")
                #expect(subcommand.aliases == ["p"])
                #expect(subcommand.visibility == .visible)
                #expect(subcommand.help.abstract == "Push.")
            }

            @Test func `default aliases is empty`() {
                let subcommand = Argument.Subcommand<PushResult>(name: "push")
                #expect(subcommand.aliases.isEmpty)
            }

            @Test func `default visibility is visible`() {
                let subcommand = Argument.Subcommand<PushResult>(name: "push")
                #expect(subcommand.visibility == .visible)
            }
        }

        @Suite struct `No argument subcommand boundary cases are defined` {}

        @Suite struct `No argument subcommand integration cases are defined` {}
    }
}

extension Argument.Subcommand<Result>.Choice {
    @Suite
    struct `Subcommand choices preserve declaration order` {
        @Suite struct `Subcommand choice construction retains declarations in their supplied order` {
            @Test func `Subcommand choices retain declarations in their supplied order`() {
                let choice = Argument.Subcommand<Result>.Choice(declarations: [
                    .init(name: "push"),
                    .init(name: "pull"),
                ])
                #expect(choice.declarations.count == 2)
                #expect(choice.declarations[0].name == "push")
                #expect(choice.declarations[1].name == "pull")
            }
        }

        @Suite struct `No argument subcommand choice boundary cases are defined` {}

        @Suite struct `No argument subcommand choice integration cases are defined` {}
    }
}
