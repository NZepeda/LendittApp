
import Foundation
import KeychainSwift

class KeychainStore {
    
    private static let keychain = KeychainSwift();
    
    static func fetchTokenFromKeychain () -> String? {
        if let token: String = keychain.get("authToken") {
            return token;
        }
        else {
            return nil;
        }
    }
    
    static func insertTokenIntoKeychain(token: String) {
        keychain.set(token, forKey: "authToken");
    }
    
    
}
