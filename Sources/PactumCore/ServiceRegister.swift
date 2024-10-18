import Vapor

extension RoutesBuilder {

    /// Registers an OpenID Connect provider's router with
    /// the parent route.
    ///
    /// - Parameters:
    ///   - provider: The provider who's router will be used.
    ///   - authUrl: The path to navigate to authenticate.
    ///   - authenticateCallback: Execute custom code within the authenticate closure before redirection.
    ///   - callback: The path or URL that the provider with
    ///     redirect to when authentication completes.
    ///   - scope: The scopes to get access to on authentication.
    ///   - completion: A callback with the current request and fetched
    ///     access token that is called when auth completes.
    public func oidc<OIDCProvider>(
        from provider: OIDCProvider.Type,
        authenticate authUrl: String,
        authenticateCallback: ((Request) async throws -> Void)? = nil,
        callback: String,
        scope: [String] = [],
        completion: @escaping (Request, String) async throws -> ResponseEncodable
    ) throws -> OIDCProvider
    where OIDCProvider: FederatedService {
        try OIDCProvider(
            routes: self,
            authenticate: authUrl,
            authenticateCallback: authenticateCallback,
            callback: callback,
            scope: scope,
            completion: completion
        )
    }

    /// Registers an OpenID Connect provider's router with
    /// the parent route and a redirection callback.
    ///
    /// - Parameters:
    ///   - provider: The provider who's router will be used.
    ///   - authUrl: The path to navigate to authenticate.
    ///   - authenticateCallback: Execute custom code within the authenticate closure before redirection.
    ///   - callback: The path or URL that the provider with
    ///     redirect to when authentication completes.
    ///   - scope: The scopes to get access to on authentication.
    ///   - redirect: The path/URL to redirect to when auth completes.
    public func oidc<OIDCProvider>(
        from provider: OIDCProvider.Type,
        authenticate authUrl: String,
        authenticateCallback: ((Request) async throws -> Void)? = nil,
        callback: String,
        scope: [String] = [],
        redirect redirectURL: String
    ) throws -> OIDCProvider
    where OIDCProvider: FederatedService {
        try self.oidc(
            from: OIDCProvider.self, authenticate: authUrl,
            authenticateCallback: authenticateCallback, callback: callback, scope: scope
        ) { (request, _) in
            let redirect = request.redirect(to: redirectURL)
            return redirect
        }
    }
}
