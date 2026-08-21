import Testing

@testable import Argument_Primitives_Test_Support

extension Argument.Visibility {
    @Suite("Argument.Visibility")
    struct Test {
        @Suite struct Unit {
            @Test func `cases distinct`() {
                #expect(Argument.Visibility.visible != Argument.Visibility.hidden)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
