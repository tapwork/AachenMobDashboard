//
//  LocationHandler.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 22.02.22.
//

import Foundation
import CoreLocation


class LocationHandler: NSObject {

    lazy var locationManager = CLLocationManager()
    var locationUpdater: ((CLLocation) -> Void)?
    var lastLocation: CLLocation?

    func start(_ updater: @escaping (CLLocation) -> Void) {
        locationUpdater = updater
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //update(locations)
        DispatchQueue.main.async {
            self.update(locations)
        }
    }

   // @MainActor
    func update(_ locations:  [CLLocation]) {
        guard let location = locations.sorted(by: {$0.timestamp > $1.timestamp }).first else { return }
        lastLocation = location
        locationUpdater?(location)
    }
}
