//
//  FetchObservableObject.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import Foundation

class FetchObservableObject: ObservableObject {
    @Published var isFetching = false
    let api = API()

    @MainActor
    func fetch<T: Codable>(_ endpoint: API.Endpoint) async throws -> T {
        isFetching = true
        defer {
            isFetching = false
        }
        return try await api.request(endpoint)
    }
}
