#if Tagged
import Argument
import Testing

extension Argument.Environment.Variable.Name {
    @Suite
    struct `Environment variable names preserve their tagged strings` {
        @Suite struct `Environment variable names support strings and equality` {
            @Test func `Environment variable names preserve their underlying strings`() {
                let name = Argument.Environment.Variable.Name(_unchecked: "MYAPP_VERBOSITY")
                #expect(name.underlying == "MYAPP_VERBOSITY")
            }

            @Test func `Environment variable names accept string literals`() {
                let name: Argument.Environment.Variable.Name = "MYAPP_VERBOSITY"
                #expect(name.underlying == "MYAPP_VERBOSITY")
            }

            @Test func `Environment variable names compare by their underlying strings`() {
                let a: Argument.Environment.Variable.Name = "FOO"
                let b: Argument.Environment.Variable.Name = "FOO"
                #expect(a == b)
            }
        }

        @Suite struct `No environment variable name boundary cases are defined` {}

        @Suite struct `No environment variable name integration cases are defined` {}
    }
}
#endif
