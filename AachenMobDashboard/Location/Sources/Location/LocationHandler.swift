//
//  LocationHandler.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 22.02.22.
//

import Foundation
import CoreLocation
import UIKit
import Combine

public class LocationHandler: NSObject {

    lazy var locationManager = CLLocationManager()
    public var locationUpdater: ((CLLocation) -> Void)?
    public var lastLocation: CLLocation?
    private var subscriptions = [AnyCancellable]()

    public override init() {}

    public func start(_ updater: @escaping (CLLocation) -> Void) {
        locationUpdater = updater
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        addObserver()
    }

    private func addObserver() {
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
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //update(locations)
        DispatchQueue.main.async {
            self.update(locations)
        }
    }

//    @MainActor
    func update(_ locations:  [CLLocation]) {
        guard let location = locations.sorted(by: {$0.timestamp > $1.timestamp }).first else { return }
        lastLocation = location
        locationUpdater?(location)
    }
}
