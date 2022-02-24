//
//  API.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import Foundation

public class API {

    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    public init() {}

    public func request<T: Codable>(_ url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        decoder.dateDecodingStrategy = .iso8601
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}
