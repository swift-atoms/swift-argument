#if Index
    public import Byte
    public import Index
    internal import Ordinal

    extension Argument {

        public struct Position: Sendable, Hashable, Equatable {

            public let index: Index<String>

            public let offset: Index<Byte>.Offset

            @inlinable
            public init(argvIndex: Index<String>, byteOffset: Index<Byte>.Offset) {
                self.index = argvIndex
                self.offset = byteOffset
            }
        }
    }
#endif
