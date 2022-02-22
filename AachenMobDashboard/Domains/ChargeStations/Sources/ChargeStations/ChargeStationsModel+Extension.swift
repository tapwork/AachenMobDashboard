//
//  ChargeStationsModel+Extension.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 21.02.22.
//

import Foundation
import CoreLocation

extension ChargeStationsModel.Value {
    var coordinates: CLLocationCoordinate2D? {
        guard let lat = Double(properties.props.chargePointLocation.lat),
              let lng = Double(properties.props.chargePointLocation.lon) else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }

    func distance(from location: CLLocation) -> Double? {
        guard let coordinates = coordinates else { return nil }
        return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude).distance(from: location)
    }

    var appleMapsURL: URL {
        URL(string: "https://maps.apple.com/?daddr=\(coordinates?.latitude ?? 0.0),\(coordinates?.longitude ?? 0.0)&dirflg=d")!
    }

    var googleMapsURL: URL {
        URL(string: "https://www.google.com/maps?saddr=My+Location&daddr=\(coordinates?.latitude ?? 0.0),\(coordinates?.longitude ?? 0.0)")!
    }
}

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
