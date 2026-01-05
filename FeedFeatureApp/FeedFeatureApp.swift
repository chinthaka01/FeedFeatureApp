//
//  FeedFeatureApp.swift
//  FeedFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit
import FeedFeature

@main
struct FeedFeatureApp: App {
    let analytics = AnalyticsImpl()
    let networking = NetworkingImpl()
    let feedAPI: FeedFeatureAPIClient
    let feedDependencies: FeedDependenciesImpl
    let feedFactory: FeedFeatureFactory
    let feature: MicroFeature
    
    init() {
        feedAPI = FeedFeatureAPIClient(networking: networking)
        feedDependencies = FeedDependenciesImpl(feedAPI: feedAPI, analytics: analytics)
        feedFactory = FeedFeatureFactory(dependencies: feedDependencies)
        feature = feedFactory.makeFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(feature: feature)
        }
    }
}
