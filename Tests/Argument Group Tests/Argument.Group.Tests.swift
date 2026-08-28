import Testing

@testable import Argument_Group

private struct Network: Sendable {}

extension Argument.Group<Network> {
    @Suite("Argument.Group")
    struct Test {
        @Suite struct Unit {
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

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
