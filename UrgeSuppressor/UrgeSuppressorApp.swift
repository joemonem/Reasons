//
//  UrgeSuppressorApp.swift
//  UrgeSuppressor
//
//  Created by Joe Monem on 06/10/2023.
//

import SwiftUI

@main
struct UrgeSuppressorApp: App {
    @StateObject private var store = WhyStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ContentView(whys: $store.whys) {
                Task {
                    do {
                        try await store.save(whys: store.whys)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }.task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.whys = []
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
