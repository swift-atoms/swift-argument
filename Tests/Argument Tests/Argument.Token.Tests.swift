#if Text
import Testing

import Argument

extension Argument.Token {
    @Suite
    struct `Argument tokens preserve their kind and source range` {
        @Suite struct `Argument token metadata retains its stored values` {
            @Test func `Argument tokens preserve the supplied kind and source range`() {
                let start: Text.Position = 0
                let end: Text.Position = 6
                let range = Text.Range(start: start, end: end)
                let token = Argument.Token(kind: .long("verbose"), range: range)
                #expect(token.kind == .long("verbose"))
                #expect(token.range == range)
            }

            @Test func `Argument token kinds distinguish their cases`() {
                let long: Argument.Token.Kind = .long("foo")
                let short: Argument.Token.Kind = .shortCluster("xyz")
                let value: Argument.Token.Kind = .value("v")
                let separator: Argument.Token.Kind = .separator
                let positional: Argument.Token.Kind = .positional("path")
                let eoo: Argument.Token.Kind = .endOfOptions
                #expect(long != short)
                #expect(value != positional)
                #expect(separator != eoo)
            }
        }

        @Suite struct `No argument token boundary cases are defined` {}

        @Suite struct `No argument token integration cases are defined` {}
    }
}
#endif
