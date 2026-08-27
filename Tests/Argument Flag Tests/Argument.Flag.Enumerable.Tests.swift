import Finite
import Testing

@testable import Argument_Test_Support

private enum Operation: Argument.Flag.Enumerable {
    case add
    case multiply
}

extension Operation {
    static func name(for value: Self) -> Argument.Name.Long {
        switch value {
        case .add: return .literal("add")
        case .multiply: return .literal("multiply")
        }
    }

    static func help(for value: Self) -> Argument.Help {
        switch value {
        case .add: return .init(abstract: "Add operands.")
        case .multiply: return .init(abstract: "Multiply operands.")
        }
    }
}

extension Operation {
    @Suite("Argument.Flag.Enumerable")
    struct Test {
        @Suite struct Unit {
            @Test func `CaseIterable enumerates every case`() {
                let all = Operation.allCases
                #expect(all == [.add, .multiply])
            }

            @Test func `name(for:) returns the registered long name`() {
                #expect(Operation.name(for: .add).string == "add")
                #expect(Operation.name(for: .multiply).string == "multiply")
            }

            @Test func `help(for:) carries the per-case abstract`() {
                #expect(Operation.help(for: .add).abstract == "Add operands.")
                #expect(Operation.help(for: .multiply).abstract == "Multiply operands.")
            }

            @Test func `each case maps to a distinct name — schema-builder invariant`() {
                let names = Operation.allCases.map { Operation.name(for: $0).string }
                #expect(Set(names).count == names.count)
            }

            @Test func `Finite.Enumerable bridge derives count from CaseIterable`() {
                #expect(Operation.count == Cardinal(2))
            }

            @Test func `Finite.Enumerable bridge derives ordinal from allCases position`() {
                #expect(Operation.add.ordinal == Ordinal(0))
                #expect(Operation.multiply.ordinal == Ordinal(1))
            }

            @Test func `Finite.Enumerable bridge reconstructs value from ordinal`() {
                #expect(Operation(_unchecked: (), ordinal: Ordinal(0)) == .add)
                #expect(Operation(_unchecked: (), ordinal: Ordinal(1)) == .multiply)
            }

            @Test func `init?(_:) round-trips through ordinal for in-bounds values`() {
                #expect(Operation(Ordinal(0)) == .add)
                #expect(Operation(Ordinal(1)) == .multiply)
                #expect(Operation(Ordinal(2)) == nil)
            }
        }

        @Suite struct `Edge Case` {}

        @Suite struct Integration {
            @Test
            func
                `Argument.Flag.Enumerable conformer is usable wherever Finite.Enumerable is expected`()
            {

                func total<E: Finite.Enumerable>(_: E.Type) -> Cardinal {
                    E.allCases.reduce(Cardinal.zero) { partial, value in
                        partial + Ordinal.zero.distance.unchecked(to: value.ordinal)
                    }
                }

                #expect(total(Operation.self) == Cardinal.one)
            }
        }
    }
}
