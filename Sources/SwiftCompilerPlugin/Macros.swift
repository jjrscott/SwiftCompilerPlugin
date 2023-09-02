//
//  File.swift
//  
//
//  Created by John Scott on 02/09/2023.
//

public protocol Macro {}

extension CompilerPluginMessageHandler {
    /// Expand `@freestainding(XXX)` macros.
    func expandFreestandingMacro(
      macro: PluginMessage.MacroReference,
      macroRole pluginMacroRole: PluginMessage.MacroRole?,
      discriminator: String,
      expandingSyntax: PluginMessage.Syntax
    ) throws {
        let response: PluginToHostMessage
        let diagnostics: [PluginMessage.Diagnostic] = []
        let expandedSource: String? = nil
        if hostCapability.hasExpandMacroResult {
          response = .expandMacroResult(expandedSource: expandedSource, diagnostics: diagnostics)
        } else {
          // TODO: Remove this  when all compilers have 'hasExpandMacroResult'.
          response = .expandFreestandingMacroResult(expandedSource: expandedSource, diagnostics: diagnostics)
        }
        try self.sendMessage(response)
    }
    
    /// Expand `@attached(XXX)` macros.
    func expandAttachedMacro(
      macro: PluginMessage.MacroReference,
      macroRole: PluginMessage.MacroRole,
      discriminator: String,
      attributeSyntax: PluginMessage.Syntax,
      declSyntax: PluginMessage.Syntax,
      parentDeclSyntax: PluginMessage.Syntax?,
      extendedTypeSyntax: PluginMessage.Syntax?,
      conformanceListSyntax: PluginMessage.Syntax?
    ) throws {
        let response: PluginToHostMessage
        let diagnostics: [PluginMessage.Diagnostic] = []
        let expandedSources: [String] = []
        if hostCapability.hasExpandMacroResult {
          response = .expandMacroResult(expandedSource: expandedSources.first, diagnostics: diagnostics)
        } else {
          response = .expandAttachedMacroResult(expandedSources: expandedSources, diagnostics: diagnostics)
        }
        try self.sendMessage(response)
    }
}
