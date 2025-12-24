//
//  ContentView.swift
//  FeedFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit

struct ContentView: View {
    let feature: MicroFeature

    var body: some View {
        feature.makeRootView()
    }
}

//#Preview {
//    ContentView()
//}
