//
//  ChargeStationsModel+Extension.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 21.02.22.
//

import Foundation

extension ChargeStationsModel.Datastream {
    var isAvailble: Bool {
        properties.status.chargePointStatusType == .operative &&
        ((observations.first(where: {$0.result == .available})) != nil)
    }

    var isCharging: Bool {
        observations.first(where: {$0.result == .charging}) != nil
    }

    var power: Int {
        properties.ratings.maximumPower
    }

    var isDC: Bool {
        properties.chargePointType == .dc
    }

    var chargeType: String {
        properties.chargePointType.rawValue
    }

    var socket: String {
        properties.connectors.first?.connectorStandard.connectorStandard.name ?? ""
    }
}

extension ChargeStationsModel.ConnectorStandardEnum {
    var name: String {
        switch self {
        case .chademo: return "Chademo"
        case .domesticF: return "Schuko"
        case .iec62196_T2: return "Typ 2"
        case .iec62196_T2Combo: return "CCS"
        }
    }
}
