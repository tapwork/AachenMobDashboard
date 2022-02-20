//
//  ChargeStationsAPI.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import Foundation

class ChargeStationsAPI: ObservableObject {
    @Published var isFetching = false
    @Published var values = [ChargeStationsModel.Value]()
    let api = API()

    @MainActor
    func fetch() async throws {
        isFetching = true
        let root: ChargeStationsModel.Root = try await api.request(.chargeStations)
        values = root.value
        isFetching = false
    }
}
