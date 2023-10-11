//
//  WhyStore.swift
//  UrgeSuppressor
//
//  Created by Joe Monem on 11/10/2023.
//

import SwiftUI

@MainActor
class WhyStore: ObservableObject {
    @Published var whys: [String] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("whys.data")
    }
    
    func load() async throws {
        let task = Task<[String], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                // If we couldn't load the user's data, it means that it's a first time user
                return []
            }
            let whys = try JSONDecoder().decode([String].self, from: data)
            return whys
        }
        let whys = try await task.value
        self.whys = whys
    }
    
    func save(whys: [String]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(whys)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
