// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.

// Creates a piece of code that returns a value
@freestanding(expression)
public macro ExpressionMacro<T>(_ value: T) -> (T, String) = #externalMacro(module: "StringifyMacros", type: "ExpressionMacro")

// Creates one or more declarations
@freestanding(declaration)
public macro DeclarationMacro(_ message: String) = #externalMacro(module: "StringifyMacros", type: "DeclarationMacro")

// Adds new declarations alongside the declaration it’s applied to
@attached(peer, names: overloaded)
public macro PeerMacro() = #externalMacro(module: "StringifyMacros", type: "PeerMacro")

// Adds accessors to a property
@attached(accessor)
public macro AccessorMacro(_ key: String? = nil) = #externalMacro(module: "StringifyMacros", type: "AccessorMacro")

// Adds attributes to the declarations in the type/extension it’s applied to
@attached(memberAttribute)
public macro MemberAttributeMacro() = #externalMacro(module: "StringifyMacros", type: "MemberAttributeMacro")

// Adds new declarations inside the type/extension it’s applied to
@attached(member)
public macro MemberMacro() = #externalMacro(module: "StringifyMacros", type: "MemberMacro")

// Adds conformances to the type/extension it’s applied to
@attached(extension, conformances:Codable)
public macro ExtensionMacro<RawType>() = #externalMacro(module: "StringifyMacros", type: "ExtensionMacro")
