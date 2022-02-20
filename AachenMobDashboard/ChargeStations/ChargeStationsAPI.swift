//
//  ChargeStationsAPI.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import Foundation

class ChargeStationsAPI: ObservableObject {

    static let url = URL(string: "https://verkehr.aachen.de/api/sensorthings/Things?$count=false&$filter=properties/type%20eq%20%27E-Ladestation%27%20and%20properties/archive%20eq%20%27false%27&$expand=Locations(%24select%3D%40iot.id%2Clocation),Datastreams(%24select%3D%40iot.id%2Cname%2Cproperties),Datastreams%2FObservedProperty(%24select%3D%40iot.id%2Cname),Datastreams%2FObservations(%24top%3D1%3B%24orderby%3DphenomenonTime%20desc%3B%24select%3Dresult%2CphenomenonTime%2Cparameters)&$top=300&$select=@iot.id,description,name,properties&$orderBy=description")!

    let session = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    @Published var isFetching = false
    @Published var values = [ChargeStationsModel.Value]()

    @MainActor
    func fetch() async throws {
        isFetching = true
        let root: ChargeStationsModel.Root = try await request()
        values = root.value
        isFetching = false
    }

    func request<T: Codable>() async throws -> T {
        let (data, _) = try await session.data(from: Self.url)
        var resultError: Error
        do {
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            resultError = error
            log(error)
        }
        throw resultError
    }

    func log(_ error: Error) {
        if let error = error as? DecodingError {
            switch error {
            case .typeMismatch(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .valueNotFound(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .keyNotFound(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .dataCorrupted(let key):
                print("error \(key), and ERROR: \(error.localizedDescription)")
            default:
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
