import Testing

@testable import Argument

extension Argument.Visibility {
    @Suite
    struct `Argument visibility cases remain distinct` {
        @Suite struct `Visible and hidden argument visibility cases differ` {
            @Test func `Visible and hidden visibility cases differ`() {
                #expect(Argument.Visibility.visible != Argument.Visibility.hidden)
            }
        }

        @Suite struct `No argument visibility boundary cases are defined` {}

        @Suite struct `No argument visibility integration cases are defined` {}
    }
}
