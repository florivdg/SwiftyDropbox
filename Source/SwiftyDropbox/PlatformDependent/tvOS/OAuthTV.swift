//
//  OAuthTV.swift
//  SwiftyDropbox
//
//  Created by Florian Weich on 21.09.16.
//  Copyright © 2016 Dropbox. All rights reserved.
//

import Foundation
import SystemConfiguration

extension DropboxClientsManager {
    
    /// Authorize the `DropboxClientsManager` with a short-lived access token and associated refresh token.
    public static func authorizeWithAccessToken(accessToken: String, uid: String, refreshToken: String, tokenExpirationTimestamp: TimeInterval) {
        precondition(DropboxOAuthManager.sharedOAuthManager != nil, "Call `DropboxClientsManager.setupWithAppKey` or `DropboxClientsManager.setupWithTeamAppKey` before calling this method")
        precondition(DropboxClientsManager.authorizedClient == nil && DropboxClientsManager.authorizedTeamClient == nil, "A Dropbox client is already authorized")
        
        /// Create DropboxAccessToken
        let shortLivedToken = DropboxAccessToken(accessToken: accessToken, uid: uid,
                                                 refreshToken: refreshToken, tokenExpirationTimestamp: tokenExpirationTimestamp)
        
        /// Store the token
        if DropboxOAuthManager.sharedOAuthManager.storeAccessToken(shortLivedToken) {
            /// Create a short-lived access token provider from access token
            let provider = DropboxOAuthManager.sharedOAuthManager.accessTokenProviderForToken(shortLivedToken)
            
            /// Set the authorized client with the given provider
            DropboxClientsManager.authorizedClient = DropboxClient.init(accessTokenProvider: provider)
        }
    }
    
    /// Authorize the `DropboxClientsManager` with a long-lived legacy access token.
    public static func authorizeWithAccessToken(accessToken: String, uid: String) {
        precondition(DropboxOAuthManager.sharedOAuthManager != nil, "Call `DropboxClientsManager.setupWithAppKey` or `DropboxClientsManager.setupWithTeamAppKey` before calling this method")
        precondition(DropboxClientsManager.authorizedClient == nil && DropboxClientsManager.authorizedTeamClient == nil, "A Dropbox client is already authorized")
        
        /// Create DropboxAccessToken
        let longLivedToken = DropboxAccessToken(accessToken: accessToken, uid: uid)
        
        /// Create a long-lived access token provider from access token
        let provider = DropboxOAuthManager.sharedOAuthManager.accessTokenProviderForToken(longLivedToken)
        
        /// Set the authorized client with the given provider
        DropboxClientsManager.authorizedClient = DropboxClient.init(accessTokenProvider: provider)
    }
    
    public static func setupWithAppKey(_ appKey: String, transportClient: DropboxTransportClient? = nil) {
        setupWithOAuthManager(appKey, oAuthManager: DropboxOAuthManager(appKey: appKey), transportClient: transportClient)
    }
    
    public static func setupWithAppKeyMultiUser(_ appKey: String, transportClient: DropboxTransportClient? = nil, tokenUid: String?) {
        setupWithOAuthManagerMultiUser(appKey, oAuthManager: DropboxOAuthManager(appKey: appKey), transportClient: transportClient, tokenUid: tokenUid)
    }
    
    public static func setupWithTeamAppKey(_ appKey: String, transportClient: DropboxTransportClient? = nil) {
        setupWithOAuthManagerTeam(appKey, oAuthManager: DropboxOAuthManager(appKey: appKey), transportClient: transportClient)
    }
    
    public static func setupWithTeamAppKeyMultiUser(_ appKey: String, transportClient: DropboxTransportClient? = nil, tokenUid: String?) {
        setupWithOAuthManagerMultiUserTeam(appKey, oAuthManager: DropboxOAuthManager(appKey: appKey), transportClient: transportClient, tokenUid: tokenUid)
    }
}
