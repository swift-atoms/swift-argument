#if Finite
import Testing

import Argument

private enum Operation: Argument.Flag.Enumerable, CaseIterable {
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
    @Suite
    struct `Enumerable flags provide names and help for each case` {
        @Suite struct `Enumerable flags preserve case identity and metadata` {
            @Test func `Enumerable flags enumerate every case`() {
                let all = Operation.allCases
                #expect(all == [.add, .multiply])
            }

            @Test func `Enumerable flag names match their cases`() {
                #expect(Operation.name(for: .add).string == "add")
                #expect(Operation.name(for: .multiply).string == "multiply")
            }

            @Test func `Enumerable flag help matches each case`() {
                #expect(Operation.help(for: .add).abstract == "Add operands.")
                #expect(Operation.help(for: .multiply).abstract == "Multiply operands.")
            }

            @Test func `Enumerable flag names are distinct`() {
                let names = Operation.allCases.map { Operation.name(for: $0).string }
                #expect(Set(names).count == names.count)
            }

            @Test func `Enumerable flags remain distinct in a set`() {
                #expect(Set(Operation.allCases).count == Operation.allCases.count)
            }
        }

        @Suite struct `No enumerable flag boundary cases are defined` {}

        @Suite struct `Enumerable flags satisfy the finite enumeration protocol` {
            @Test
            func
                `Enumerable flags retain their cases through the finite enumeration protocol`()
            {
                func cases<E: Finite.Enumerable>(of type: E.Type) -> Finite.Enumeration<E> {
                    type.allCases
                }

                #expect(Array(cases(of: Operation.self)) == [.add, .multiply])
            }
        }
    }
}
#endif
