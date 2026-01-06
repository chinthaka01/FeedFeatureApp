# FeedFeatureApp

FeedFeatureApp is a standalone SwiftUI app that embeds the **Feed** micro‑feature without the full Wefriendz shell. It wires up only the minimum shared dependencies (networking and analytics) so the feed can be developed, tested, and demoed independently.

***

## Purpose

- Run the Feed feature on its own, without other tabs or features.
- Verify Feed UI, networking, and analytics behavior quickly in the simulator.  
- Serve as a reference for how to compose a single micro‑feature in a host app.

***

## Architecture

FeedFeatureApp reuses the same platform abstractions as the shell:

- **PlatformKit**
  - `AnalyticsImpl` for logging analytics events.
  - `NetworkingImpl` for making HTTP calls to the demo BFF.
  - `FeedFeatureAPIClient`, `FeedDependenciesImpl`, and `FeedFeatureFactory` to construct the Feed feature graph.
- **FeedFeature**
  - Exposes `FeedFeatureFactory` and the `MicroFeature` entry (`FeedFeatureEntry`) that provides the root SwiftUI view.

The app contains two main types:

### FeedFeatureApp (entry point)

- Creates shared instances:
  - `analytics = AnalyticsImpl()`
  - `networking = NetworkingImpl()`  
- Composes Feed dependencies:
  - `feedAPI = FeedFeatureAPIClient(networking: networking)`
  - `feedDependencies = FeedDependenciesImpl(feedAPI: feedAPI, analytics: analytics)`
  - `feedFactory = FeedFeatureFactory(dependencies: feedDependencies)`
  - `feature = feedFactory.makeFeature()`
- Hosts the feature:
  - In `body`, presents `ContentView(feature: feature)` inside a `WindowGroup`.

### ContentView (host view)

- Holds one property:
  - `let feature: MicroFeature`  
- Renders the feature:
  - `feature.makeRootView()` is returned directly from `body`, so the Feed feature controls all UI beneath it.

***

## Usage

1. Open the **FeedFeatureApp** target in Xcode.  
2. Select an iOS Simulator (for example, the same one used by PlatformKit CI).  
3. Run the app:
   - The simulator launches directly into the Feed feature’s root view.
   - All feed screens, networking calls, and analytics tracking run exactly as they would inside the full Wefriendz shell.

This setup lets the Feed team iterate on the feature quickly while still using the real platform and design system code paths.
