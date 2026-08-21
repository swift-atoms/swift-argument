public import Argument_Primitive
public import Byte_Primitives
public import Index_Primitives

extension Argument {

    public struct Position: Sendable, Hashable, Equatable {

        public let argvIndex: Index<String>

        public let byteOffset: Index<Byte>.Offset

        @inlinable
        public init(argvIndex: Index<String>, byteOffset: Index<Byte>.Offset) {
            self.argvIndex = argvIndex
            self.byteOffset = byteOffset
        }
    }
}
