#if Tagged
import Argument
import Testing

@Suite
struct `Typed environment options preserve arity metadata` {
    @Test(arguments: [
        Argument.Arity.exactly(0),
        .atMost(3),
        .atLeast(1),
        .range(2...4),
        .range(0...0),
        .count,
        .exactly(Cardinal.max),
        .atMost(Cardinal.max),
        .atLeast(Cardinal.max),
        .range(0...Cardinal.max),
    ])
    func `Typed environment options forward bounded and counting arities`(_ arity: Argument.Arity) {
        let environment: Argument.Environment.Variable.Name = "APP_COUNT"
        let option = Argument.Option<Int>(
            name: .long(.literal("count")),
            placeholder: "count",
            arity: arity,
            help: .init(defaults: "3"),
            environment: environment
        )
        #expect(option.arity == arity)
        #expect(option.environment == "APP_COUNT")
        #expect(option.help.defaults == "3")
    }

    @Test(arguments: [0, 1, Int.max])
    func `Dynamic integer bounds pass through typed environment options`(_ raw: Int)
        throws(Cardinal.Error)
    {
        let lower = try Cardinal(raw)
        let environment: Argument.Environment.Variable.Name = "APP_COUNTS"
        let option = Argument.Option<Int>(
            name: .long(.literal("counts")),
            placeholder: "count",
            arity: .range(lower...Cardinal.max),
            environment: environment
        )
        guard case .range(let bounds) = option.arity else {
            Issue.record("Expected the dynamic closed arity bounds")
            return
        }
        #expect(bounds.lowerBound.rawValue == UInt(raw))
        #expect(bounds.upperBound == Cardinal.max)
        #expect(bounds.contains(lower))
        #expect(bounds.contains(Cardinal.max))
        #expect("\(bounds.lowerBound)" == "\(raw)")
        #expect(option.environment == "APP_COUNTS")
    }

    @Test func `Typed environment options retain their default exact arity`() {
        let environment: Argument.Environment.Variable.Name = "APP_COUNT"
        let option = Argument.Option<Int>(
            name: .long(.literal("count")),
            placeholder: "count",
            environment: environment
        )
        #expect(option.arity == .exactly(1))
        #expect(option.environment == "APP_COUNT")
    }
}
#endif
