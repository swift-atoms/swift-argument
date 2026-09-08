import Testing

import Argument

extension Argument.Arity {
    @Suite
    struct `Argument arities distinguish exact counts and range bounds` {
        @Suite struct `Argument arity equality distinguishes cases and stored range bounds` {
            @Test func `Exact arity differs from every other arity case`() {
                let exact: Argument.Arity = .exactly(1)
                let atMost: Argument.Arity = .atMost(2)
                let atLeast: Argument.Arity = .atLeast(0)
                let range: Argument.Arity = .range(1...3)
                let count: Argument.Arity = .count
                #expect(exact != atMost)
                #expect(exact != atLeast)
                #expect(exact != range)
                #expect(exact != count)
            }

            @Test func `Arity ranges compare equal only when their bounds match`() {
                let a: Argument.Arity = .range(1...3)
                let b: Argument.Arity = .range(1...3)
                let c: Argument.Arity = .range(0...3)
                #expect(a == b)
                #expect(a != c)
            }
        }

        @Suite struct `Arity bounds preserve zero and counts above the signed limit` {
            @Test(arguments: [UInt.zero, 1, UInt(Int.max), UInt(Int.max) + 1, UInt.max])
            func `Single arity bounds preserve their unsigned counts and decimal text`(_ raw: UInt) {
                let bound = Cardinal(raw)
                let arities: [Argument.Arity] = [.exactly(bound), .atMost(bound), .atLeast(bound)]
                for arity in arities {
                    switch arity {
                    case .exactly(let stored), .atMost(let stored), .atLeast(let stored):
                        #expect(stored.rawValue == raw)
                        #expect("\(stored)" == "\(raw)")
                    case .range, .count:
                        Issue.record("Expected an arity with a single count bound")
                    }
                    #expect(arity != .count)
                }
            }

            @Test func `Closed arity ranges include zero and maximum endpoints`() {
                let ranges: [ClosedRange<Cardinal>] = [
                    0...0,
                    0...Cardinal.max,
                    Cardinal.max...Cardinal.max,
                ]
                for expected in ranges {
                    let arity = Argument.Arity.range(expected)
                    guard case .range(let stored) = arity else {
                        Issue.record("Expected an arity with closed bounds")
                        continue
                    }
                    #expect(stored == expected)
                    #expect(stored.contains(expected.lowerBound))
                    #expect(stored.contains(expected.upperBound))
                }
            }
        }

        @Suite struct `No argument arity integration cases are defined` {}
    }
}
