//
//  LocationService.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-18.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func turnOnLocationServices()
    func didFailWithError(error: Error)
    func didUpdateLocation(location: CLLocation)
    func didCheckAuthorizationStatus(status: CLAuthorizationStatus)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    
    // MARK: - Variables and Properties
    
    weak var delegate: LocationServiceDelegate?
    var locationManager: CLLocationManager!
    private var lastLocation: CLLocation?
    public var defaultLocation = CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.985130)
    public var userLocation: CLLocationCoordinate2D? {
        get {
            guard let location = locationManager.location?.coordinate else { return nil }
            return location
        }
    }
    public let regionInMeters: Double = 1000
    
    override init() {
        super.init()
        initLocationServices()
    }
    
    private func initLocationServices() {
        self.locationManager = CLLocationManager()
        checkLocationServices()
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.delegate = self
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            turnOnLocationServicesAlert()
        }
    }
    
    private func checkLocationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            /// Request permission to use location services
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            turnOnLocationServicesAlert()
        @unknown default:
            fatalError("CLAuthorizationStatus is unknown.")
        }
        didCheckAuthorizationStatus(status: status)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        updateLocation(currentLocation: location)
        print("DID UPDATE LOCATIONS")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        updateLocationDidFailWithError(error: error)
    }
    
    // MARK: - Private Functions

    func startUpdatingLocation() {
        print("Starting Location Updates")
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        locationManager.stopUpdatingLocation()
    }
    
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else { return }
        delegate.didUpdateLocation(location: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: Error) {
        guard let delegate = self.delegate else { return }
        delegate.didFailWithError(error: error)
    }
    
    private func turnOnLocationServicesAlert() {
        /// - ALERT: "Turn on Location Services"
        guard let delegate = self.delegate else { return }
        delegate.turnOnLocationServices()
    }
    
    private func didCheckAuthorizationStatus(status: CLAuthorizationStatus) {
        guard let delegate = self.delegate else { return }
        delegate.didCheckAuthorizationStatus(status: status)
    }

}
