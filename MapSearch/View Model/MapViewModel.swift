//
//  MapViewModel.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-16.
//  Copyright © 2021 Apple. All rights reserved.
//

import MapKit

class MapViewModel: NSObject {
    
    func createAnnotation(on mapView: MKMapView, business: Business) {
        let annotation = MKPointAnnotation()
        annotation.title = business.name
        if let lat = business.coordinates?.latitude, let lon = business.coordinates?.longitude {
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        mapView.addAnnotation(annotation)
    }
    
    func createLocation(business: Business) -> CLLocationCoordinate2D {
        guard let lat = business.coordinates?.latitude, let lon = business.coordinates?.longitude else { return CLLocationCoordinate2D() }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
}
