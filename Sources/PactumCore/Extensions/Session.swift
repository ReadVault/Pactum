import Vapor

extension Session {
    enum OidcKey {
        static let nonce = "nonce"
        static let pkce = "pkce"
    }

    func setNonce(_ nonce: String?) throws {
        try self.set(OidcKey.nonce, to: nonce)
    }

    func nonce() -> String? {
        return try? self.get(OidcKey.nonce, as: String.self)
    }

    func setPKCE(_ pkce: String?) throws {
        try self.set(OidcKey.pkce, to: pkce)
    }

    func pkce() -> String? {
        return try? self.get(OidcKey.pkce, as: String.self)
    }
}
