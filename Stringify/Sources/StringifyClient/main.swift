import Stringify
import Foundation

let a = 17
let b = 25

let (result, code) = #ExpressionMacro(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

#DeclarationMacro("unsupported configuration")


// https://jllnmercier.medium.com/swift-peer-macros-1cb1469d83fe
class Webservice {
    @PeerMacro
    func fetch(completion: (Data) -> Void) {
        completion(Data())
    }
}

@MemberAttributeMacro
struct Animal {
    var age = 10
    var name: String
}

class User {
    @AccessorMacro var username = "Taylor"
    var age = 26
}


extension User {
    @ExtensionMacro<Int>
    private struct B {}
}

print(User().username)
