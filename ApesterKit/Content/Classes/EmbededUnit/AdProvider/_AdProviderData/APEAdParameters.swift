//
//  APEAdParameters.swift
//  ApesterKit
//
//  Created by Arkadi Yoskovitz on 3/8/23.
//

import Foundation

internal protocol APEAdParameters {
    var identifier: String { get }
    var isVariant: Bool { get }
    var type: APEAdType { get }
}

internal struct AdMobParams: Hashable, APEAdParameters {
    internal let identifier: String
    internal let isVariant: Bool
    internal let type: APEAdType
    
    internal init?(from dictionary: [String: Any]) {
        typealias Keys = Constants.Monetization
        
        guard
            let provider  = dictionary[Keys.adProvider] as? String,
            let adUnitId  = dictionary[Keys.adUnitId  ] as? String,
            let typeStr   = dictionary[Keys.adType    ] as? String,
            let isVariant = dictionary[Keys.isVariant ] as? Bool,
            let adType    = APEAdType(rawValue: typeStr),
            provider == Keys.adMob
        else { return nil }
        
        self.identifier = adUnitId
        self.isVariant = isVariant
        self.type = adType
    }
}

internal struct PubMaticParams: Hashable, APEAdParameters {
    internal let identifier: String
    internal let isVariant: Bool
    internal let type: APEAdType
    
    internal let profileId: Int
    internal let publisherId: String
    internal let appStoreUrl: String
    internal let appDomain: String
    internal let testMode: Bool
    internal let debugLogs: Bool
    internal let bidSummaryLogs: Bool
    internal let timeInView: Int?
     
    internal init?(from dictionary: [String: Any]) {
        typealias Keys = Constants.Monetization
        
        guard
            let provider     = dictionary[Keys.adProvider] as? String,
            let adUnitId     = dictionary[Keys.adUnitId] as? String,
            let typeStr      = dictionary[Keys.adType] as? String,
            let isVariant    = dictionary[Keys.isVariant] as? Bool,
            let profileIdStr = dictionary[Keys.profileId] as? String,
            let appStoreUrl  = dictionary[Keys.appStoreUrl] as? String,
            let publisherId  = dictionary[Keys.publisherId] as? String,
            let adType       = APEAdType(rawValue: typeStr),
            let profileId    = Int(profileIdStr),
            provider == Keys.pubMatic
        else { return nil }
        
        self.identifier     = adUnitId
        self.isVariant      = isVariant
        self.type           = adType
        self.profileId      = profileId
        self.appStoreUrl    = appStoreUrl
        self.publisherId    = publisherId
        self.appDomain      = dictionary[Keys.appDomain] as? String ?? ""
        self.testMode       = dictionary[Keys.testMode] as? Bool ?? false
        self.debugLogs      = dictionary[Keys.debugLogs] as? Bool ?? false
        self.bidSummaryLogs = dictionary[Keys.bidSummaryLogs] as? Bool ?? false
        self.timeInView     = dictionary[Keys.timeInView] as? Int
    }
}
