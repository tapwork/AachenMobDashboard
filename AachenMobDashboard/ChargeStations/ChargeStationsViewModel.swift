//
//  ChargeStationsViewModel.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import Foundation

class ChargeStationsViewModel: FetchObservableObject {

    @Published var values = [ChargeStationsModel.Value]()
    @Published var searchTerm = ""

    var content: [ChargeStationsModel.Value] {
        if searchTerm.count < 2 {
            return values
        } else {
            return values.filter {$0.valueDescription.contains(searchTerm)}
        }
    }

    func fetch() async throws {
        let root: ChargeStationsModel.Root = try await fetch(.chargeStations)
        values = root.value
    }
}
