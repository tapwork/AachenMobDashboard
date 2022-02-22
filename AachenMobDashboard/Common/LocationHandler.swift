//
//  LocationHandler.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 22.02.22.
//

import Foundation
import CoreLocation
import UserNotifications
import UIKit
import Combine

class LocationHandler: NSObject {

    lazy var locationManager = CLLocationManager()
    var locationUpdater: ((CLLocation) -> Void)?
    var lastLocation: CLLocation?
    private var subscriptions = [AnyCancellable]()

    func start(_ updater: @escaping (CLLocation) -> Void) {
        locationUpdater = updater
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        addObserver()
    }

    func addObserver() {
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification, object: nil)
            .sink {[weak self] _ in
                guard let self = self else { return }
                self.locationManager.startUpdatingLocation()
        }.store(in: &subscriptions)

        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification, object: nil)
            .sink {[weak self] _ in
                guard let self = self else { return }
                self.locationManager.stopUpdatingHeading()
        }.store(in: &subscriptions)
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
