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
    private let locationHandler = LocationHandler()

    override init() {
        super.init()
        locationHandler.start {[weak self] location in
            guard let self = self else { return }
            self.sortValues()
        }
    }

    var content: [ChargeStationsModel.Value] {
        if searchTerm.count < 2 {
            return values
        } else {
            return values.filter {$0.valueDescription.contains(searchTerm)}
        }
    }

    func fetch() async throws {
        let root: ChargeStationsModel.Root = try await fetch(.chargeStations)
        values = sortedValues(root.value)
    }

    func sortValues() {
        values = sortedValues(values)
    }

    func sortedValues(_ values: [ChargeStationsModel.Value]) -> [ChargeStationsModel.Value] {
        guard let location = locationHandler.lastLocation else { return values }
        return values.sorted(by: { val1, val2 in
            if let distance1 = val1.distance(from: location), let distance2 = val2.distance(from: location) {
                return distance1 < distance2
            }
            return val1.name < val2.name
        })
    }
}
