//
//  ContentView.swift
//  FeedFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit

/// Minimal host view used to run a single `MicroFeature`
/// (the Feed feature) in isolation on a simulator or  a real device.
struct ContentView: View {
    
    /// The micro feature under test, injected from the app entry point.
    let feature: MicroFeature

    var body: some View {
        feature.makeRootView()
    }
}
