import Testing

@testable import Argument

private struct Network: Sendable {}

extension Argument.Group<Network> {
    @Suite
    struct `Argument groups preserve explicit fields and default visibility` {
        @Suite struct `Group construction retains supplied fields and defaults to visible` {
            @Test func `initializer carries explicit fields`() {
                let group = Argument.Group<Network>(
                    name: "network",
                    visibility: .visible,
                    help: .init(abstract: "Network configuration.")
                )
                #expect(group.name == "network")
                #expect(group.visibility == .visible)
                #expect(group.help.abstract == "Network configuration.")
            }

            @Test func `default visibility is visible`() {
                let group = Argument.Group<Network>(name: "network")
                #expect(group.visibility == .visible)
            }
        }

        @Suite struct `No argument group boundary cases are defined` {}

        @Suite struct `No argument group integration cases are defined` {}
    }
}
