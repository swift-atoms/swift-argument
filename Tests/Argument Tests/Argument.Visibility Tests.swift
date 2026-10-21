import Testing

@testable import Argument

extension Argument.Visibility {
    @Suite
    struct Test {
        @Suite struct Unit {
            @Test func `Visible and hidden visibility cases differ`() {
                #expect(Argument.Visibility.visible != Argument.Visibility.hidden)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {}
    }
}
