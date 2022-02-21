//
//  ChargeStationsModel+Extension.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 21.02.22.
//

import Foundation

extension ChargeStationsModel.Datastream {


    struct Socket {
        enum State: String {
            case available
            case charging
            case defect
            case unknown

            init(observation: ChargeStationsModel.Observation?) {
                switch observation?.result {
                case .charging: self = .charging
                case .available: self = .available
                case .outoforder: self = .defect
                case .none: self = .defect
                }
            }
        }

        var state: State
        var power: Int
        var type: String
        var name: String
    }

    var socket: Socket {
        Socket(state: .init(observation: observations.first),
               power: properties.ratings.maximumPower,
               type: properties.chargePointType.rawValue,
               name: properties.connectors.first?.connectorStandard.connectorStandard.name ?? "")
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
