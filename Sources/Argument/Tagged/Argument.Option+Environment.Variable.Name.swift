#if Tagged
public import Tagged

extension Argument.Option {

    @inlinable
    public init(
        name: Argument.Name,
        placeholder: String,
        arity: Argument.Arity = .exactly(1),
        visibility: Argument.Visibility = .visible,
        help: Argument.Help = .init(),
        environment: Argument.Environment.Variable.Name?
    ) {
        self.init(
            name: name,
            placeholder: placeholder,
            arity: arity,
            visibility: visibility,
            help: help,
            environment: environment?.underlying
        )
    }
}
#endif
