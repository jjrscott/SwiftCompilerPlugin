import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
//#if canImport(ExampleMacros)
//import ExampleMacros
//
//let testMacros: [String: Macro.Type] = [
//    "Example": ExampleMacro.self,
//]
//#endif

final class ExampleTests: XCTestCase {
//    func testMacro() throws {
//        #if canImport(ExampleMacros)
//        assertMacroExpansion(
//            """
//            #Example(a + b)
//            """,
//            expandedSource: """
//            (a + b, "a + b")
//            """,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
//
//    func testMacroWithStringLiteral() throws {
//        #if canImport(ExampleMacros)
//        assertMacroExpansion(
//            #"""
//            #Example("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
}
