// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct ChargeStationsModel {

    struct Root: Codable {
        let value: [Value]
    }

    // MARK: - Value
    struct Value: Codable, Identifiable {
        let valueDescription: String
        let iotID: Int
        let name: String
        let properties: ValueProperties
        let locations: [Location]
        let datastreams: [Datastream]
        var id: Int {
            iotID
        }

        enum CodingKeys: String, CodingKey {
            case valueDescription = "description"
            case name
            case iotID = "@iot.id"
            case properties
            case locations = "Locations"
            case datastreams = "Datastreams"
        }
    }

    // MARK: - Datastream
    struct Datastream: Codable {
        let iotID: Int
        let name: String
        let properties: DatastreamProperties
        let observedProperty: ObservedProperty
        let observationsIotNextLink: String
        let observations: [Observation]

        enum CodingKeys: String, CodingKey {
            case iotID = "@iot.id"
            case name, properties
            case observedProperty = "ObservedProperty"
            case observationsIotNextLink = "Observations@iot.nextLink"
            case observations = "Observations"
        }
    }

    // MARK: - Observation
    struct Observation: Codable {
        let phenomenonTime: String
        let parameters: Parameters
        let result: Result?
    }

    // MARK: - Parameters
    struct Parameters: Codable {
        let allocationID: String
    }

    enum Result: String, Codable {
        case available = "available"
        case charging = "charging"
        case outoforder = "outoforder"
    }

    // MARK: - ObservedProperty
    struct ObservedProperty: Codable {
        let iotID: Int
        let name: Name

        enum CodingKeys: String, CodingKey {
            case iotID = "@iot.id"
            case name
        }
    }

    enum Name: String, Codable {
        case status = "Status"
    }

    // MARK: - DatastreamProperties
    struct DatastreamProperties: Codable {
        let type: PurpleType
        let state: State
        let evseID: String
        let status: Status
        let archive: Bool
        let assetID: String
        let ratings: Ratings
        let species: PurpleSpecies
        let location: PropertiesLocation
        let timeZone: TimeZone
        let timestamp: Timestamp
        let connectors: [Connector]
        let authMethods: [AuthMethod]
        let chargePointType: ChargePointType
        let relatedLocation: [RelatedLocation]?
        let relatedResource: [RelatedResource]?
        let userInterfaceLang: [LocationNameLang]
        let chargePointLocation: ChargePointLocation

        enum CodingKeys: String, CodingKey {
            case type, state
            case evseID = "evseId"
            case status, archive, assetID, ratings, species, location, timeZone, timestamp, connectors, authMethods, chargePointType, relatedLocation, relatedResource, userInterfaceLang, chargePointLocation
        }
    }

    // MARK: - AuthMethod
    struct AuthMethod: Codable {
        let authMethodType: AuthMethodType
    }

    enum AuthMethodType: String, Codable {
        case ochpDirectAuth = "OchpDirectAuth"
        case operatorAuth = "OperatorAuth"
        case rfidMifareCls = "RfidMifareCls"
        case rfidMifareDES = "RfidMifareDes"
    }

    // MARK: - ChargePointLocation
    struct ChargePointLocation: Codable {
        let lat, lon: String
    }

    enum ChargePointType: String, Codable {
        case ac = "AC"
        case dc = "DC"
    }

    // MARK: - Connector
    struct Connector: Codable {
        let connectorFormat: ConnectorFormatClass
        let connectorStandard: ConnectorStandardClass
    }

    // MARK: - ConnectorFormatClass
    struct ConnectorFormatClass: Codable {
        let connectorFormat: ConnectorFormatEnum
    }

    enum ConnectorFormatEnum: String, Codable {
        case cable = "Cable"
        case socket = "Socket"
    }

    // MARK: - ConnectorStandardClass
    struct ConnectorStandardClass: Codable {
        let connectorStandard: ConnectorStandardEnum
    }

    enum ConnectorStandardEnum: String, Codable {
        case chademo = "Chademo"
        case domesticF = "DOMESTIC_F"
        case iec62196_T2 = "IEC_62196_T2"
        case iec62196_T2Combo = "IEC_62196_T2_COMBO"
    }

    // MARK: - PropertiesLocation
    struct PropertiesLocation: Codable {
        let generalLocationType: GeneralLocationType
    }

    enum GeneralLocationType: String, Codable {
        case generalLocationTypePrivate = "private"
        case onStreet = "on-street"
        case parkingGarage = "parking-garage"
        case parkingLot = "parking-lot"
        case unknown = "unknown"
    }

    // MARK: - Ratings
    struct Ratings: Codable {
        let maximumPower: Int
    }

    // MARK: - RelatedLocation
    struct RelatedLocation: Codable {
        let lat, lon: String
        let type: RelatedLocationType
    }

    enum RelatedLocationType: String, Codable {
        case entrance = "entrance"
    }

    // MARK: - RelatedResource
    struct RelatedResource: Codable {
        let uri: String
        let clazz: RelatedResourceClazz
    }

    enum RelatedResourceClazz: String, Codable {
        case operatorPayment = "operatorPayment"
    }

    enum PurpleSpecies: String, Codable {
        case ladepunkt = "Ladepunkt"
    }

    enum State: String, Codable {
        case inoperative = "Inoperative"
        case operative = "Operative"
    }

    // MARK: - Status
    struct Status: Codable {
        let chargePointStatusType: State
    }

    enum TimeZone: String, Codable {
        case europeBerlin = "Europe/Berlin"
    }

    // MARK: - Timestamp
    struct Timestamp: Codable {
        let dateTime: Date
    }

    enum PurpleType: String, Codable {
        case eLadepunkt = "E-Ladepunkt"
    }

    enum LocationNameLang: String, Codable {
        case deu = "DEU"
    }

    // MARK: - Location
    struct Location: Codable {
        let iotID: Int
        let location: LocationLocation

        enum CodingKeys: String, CodingKey {
            case iotID = "@iot.id"
            case location
        }
    }

    // MARK: - LocationLocation
    struct LocationLocation: Codable {
        let type: LocationType
        let geometry: Geometry
    }

    // MARK: - Geometry
    struct Geometry: Codable {
        let type: GeometryType
        let coordinates: [Double]
    }

    enum GeometryType: String, Codable {
        case point = "Point"
    }

    enum LocationType: String, Codable {
        case feature = "Feature"
    }

    // MARK: - ValueProperties
    struct ValueProperties: Codable {
        let type: FluffyType
        let props: Props
        let state: State
        let topic: Topic
        let active, archive: Bool
        let assetID, created: String
        let species: FluffySpecies
        let updated: String
    }

    // MARK: - Props
    struct Props: Codable {
        let evseID: String
        let images: [Image]
        let status: Status
        let ratings: Ratings
        let location: PropertiesLocation
        let timeZone: TimeZone
        let timestamp: Timestamp
        let connectors: [Connector]
        let locationID: String
        let authMethods: [AuthMethod]
        let parkingSpot: [ParkingSpot]
        let locationName: String
        let openingTimes: OpeningTimes
        let chargePointType: ChargePointType
        let relatedLocation: [RelatedLocation]?
        let relatedResource: [RelatedResource]?
        let telephoneNumber: String
        let locationNameLang: LocationNameLang
        let chargePointAddress: ChargePointAddress
        let chargePointLocation: ChargePointLocation

        enum CodingKeys: String, CodingKey {
            case evseID = "evseId"
            case images, status, ratings, location, timeZone, timestamp, connectors
            case locationID = "locationId"
            case authMethods, parkingSpot, locationName, openingTimes, chargePointType, relatedLocation, relatedResource, telephoneNumber, locationNameLang, chargePointAddress, chargePointLocation
        }
    }

    // MARK: - ChargePointAddress
    struct ChargePointAddress: Codable {
        let city: City
        let address: String
        let country: LocationNameLang
        let zipCode, houseNumber: String
    }

    enum City: String, Codable {
        case aachen = "Aachen"
    }

    // MARK: - Image
    struct Image: Codable {
        let uri: String
        let type: ImageType
        let clazz: ImageClazz
        let thumbURI: String

        enum CodingKeys: String, CodingKey {
            case uri, type, clazz
            case thumbURI = "thumbUri"
        }
    }

    enum ImageClazz: String, Codable {
        case networkLogo = "networkLogo"
        case operatorLogo = "operatorLogo"
        case ownerLogo = "ownerLogo"
    }

    enum ImageType: String, Codable {
        case png = "png"
    }

    // MARK: - OpeningTimes
    struct OpeningTimes: Codable {
        let regularHours: [RegularHour]?
        let closedCharging: Bool
        let twentyfourseven: Bool?
    }

    // MARK: - RegularHour
    struct RegularHour: Codable {
        let weekday: Int
        let periodEnd: PeriodEnd
        let periodBegin: PeriodBegin
    }

    enum PeriodBegin: String, Codable {
        case the0600 = "06:00"
        case the0700 = "07:00"
        case the0800 = "08:00"
        case the0900 = "09:00"
        case the1800 = "18:00"
    }

    enum PeriodEnd: String, Codable {
        case the1400 = "14:00"
        case the1700 = "17:00"
        case the1800 = "18:00"
        case the2000 = "20:00"
        case the2100 = "21:00"
        case the2200 = "22:00"
        case the2359 = "23:59"
    }

    // MARK: - ParkingSpot
    struct ParkingSpot: Codable {
        let parkingID: String
        let restriction: [Restriction]?
        let floorLevel, parkingSpotNumber: String?

        enum CodingKeys: String, CodingKey {
            case parkingID = "parkingId"
            case restriction, floorLevel, parkingSpotNumber
        }
    }

    // MARK: - Restriction
    struct Restriction: Codable {
        let restrictionType: RestrictionType
    }

    enum RestrictionType: String, Codable {
        case customers = "customers"
        case disabled = "disabled"
        case evonly = "evonly"
        case plugged = "plugged"
    }

    enum FluffySpecies: String, Codable {
        case ladestation = "Ladestation"
    }

    enum Topic: String, Codable {
        case verkehr = "Verkehr"
    }

    enum FluffyType: String, Codable {
        case eLadestation = "E-Ladestation"
    }

}
