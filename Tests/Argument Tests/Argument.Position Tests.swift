#if Index
    import Testing

    import Byte
    import Index
    import Ordinal
    import Tagged
    @testable import Argument

    extension Argument.Position {
        @Suite
        struct Test {
            @Suite struct Unit {
                @Test func `initializer carries argvIndex and byteOffset`() {
                    let position = Argument.Position(argvIndex: 2, byteOffset: 5)
                    #expect(position.index == 2)
                    #expect(position.offset == 5)
                }

                @Test func `equality compares fields`() {
                    let a = Argument.Position(argvIndex: 0, byteOffset: 0)
                    let b = Argument.Position(argvIndex: 0, byteOffset: 0)
                    let c = Argument.Position(argvIndex: 0, byteOffset: 1)
                    #expect(a == b)
                    #expect(a != c)
                }
            }

            @Suite struct `Edge Case` {}

            @Suite struct Integration {}
        }
    }

#endif
