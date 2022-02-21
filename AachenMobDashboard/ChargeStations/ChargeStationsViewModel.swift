//
//  ChargeStationsViewModel.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import Foundation

class ChargeStationsViewModel: FetchObservableObject {

    @Published var values = [ChargeStationsModel.Value]()

    func fetch() async throws {
        let root: ChargeStationsModel.Root = try await fetch(.chargeStations)
        values = root.value
    }
}
