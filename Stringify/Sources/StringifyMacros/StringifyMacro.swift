import SwiftCompilerPlugin

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: FreestandingMacro {
    public static func expandFreestandingMacro(
        macro: PluginMessage.MacroReference,
        macroRole: PluginMessage.MacroRole?,
        discriminator: String,
        expandingSyntax: PluginMessage.Syntax
    ) throws -> (expandedSource: String?,
                 diagnostics: [PluginMessage.Diagnostic]) {
        let source = expandingSyntax.source
        let start = source.index(source.startIndex, offsetBy: "#stringify(".count)
        let end = source.index(source.endIndex, offsetBy:  0 - ")".count)
        let argument = source[start..<end]
        
        return ("(\(argument), \"\(argument)\")", [])
    }
}

@main
struct StringifyPlugin: CompilerPlugin {

    
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
    ]
}
