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
    public static func authorizeWithAccessToken(accessToken:DropboxAccessToken) {
        precondition(DropboxOAuthManager.sharedOAuthManager != nil, "Call `DropboxClientsManager.setupWithAppKey` or `DropboxClientsManager.setupWithTeamAppKey` before calling this method")
        precondition(DropboxClientsManager.authorizedClient == nil && DropboxClientsManager.authorizedTeamClient == nil, "A Dropbox client is already authorized")
        if DropboxOAuthManager.sharedOAuthManager.storeAccessToken(accessToken) {
            if let token = DropboxOAuthManager.sharedOAuthManager.getFirstAccessToken() {
                DropboxClientsManager.authorizedClient = DropboxClient(accessToken: token.accessToken)
            }
        }
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
