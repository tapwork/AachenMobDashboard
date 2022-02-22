//
//  File.swift
//  
//
//  Created by Christian Menschel on 22.02.22.
//

import Foundation

extension URL {
    static var chargeStationsAPI: URL {
        URL(string: "https://verkehr.aachen.de/api/sensorthings/Things?$count=false&$filter=properties/type%20eq%20%27E-Ladestation%27%20and%20properties/archive%20eq%20%27false%27&$expand=Locations(%24select%3D%40iot.id%2Clocation),Datastreams(%24select%3D%40iot.id%2Cname%2Cproperties),Datastreams%2FObservedProperty(%24select%3D%40iot.id%2Cname),Datastreams%2FObservations(%24top%3D1%3B%24orderby%3DphenomenonTime%20desc%3B%24select%3Dresult%2CphenomenonTime%2Cparameters)&$top=300&$select=@iot.id,description,name,properties&$orderBy=description")!
    }
}
