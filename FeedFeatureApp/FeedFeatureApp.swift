//
//  FeedFeatureApp.swift
//  FeedFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit
import FeedFeature

/// Standalone app for run the Feed feature on a simulator or a real device.
///
/// Wires up the platform dependencies and launches the Feed micro feature
/// on its own, without the full Wefriendz shell.
@main
struct FeedFeatureApp: App {
    
    /// Shared analytics implementation for this demo host.
    let analytics = AnalyticsImpl()
    
    /// Shared networking implementation used by the feed API.
    let networking = NetworkingImpl()
    
    /// Concrete API client for the Feed feature.
    let feedAPI: FeedFeatureAPIClient
    
    /// Dependency container passed into the Feed feature factory.
    let feedDependencies: FeedDependenciesImpl
    
    /// Factory that builds the Feed micro feature.
    let feedFactory: FeedFeatureFactory
    
    /// The Feed `MicroFeature` instance rendered by this demo app.
    let feature: MicroFeature
    
    init() {
        feedAPI = FeedFeatureAPIClient(networking: networking)
        feedDependencies = FeedDependenciesImpl(feedAPI: feedAPI, analytics: analytics)
        feedFactory = FeedFeatureFactory(dependencies: feedDependencies)
        feature = feedFactory.makeFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            // Minimal host view that renders only the Feed feature.
            ContentView(feature: feature)
        }
    }
}
