//
//  RestaurantAnnotationView.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-18.
//  Copyright © 2021 Apple. All rights reserved.
//

import MapKit

// MARK: - Place Annotation View

internal final class PlaceAnnotationView: MKMarkerAnnotationView {
    
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    // MARK: - Properties
    
    internal override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
    
    func configure(with annotation: MKAnnotation) {
        markerTintColor = #colorLiteral(red: 0.2509803922, green: 0, blue: 0.5098039216, alpha: 1)
        clusteringIdentifier = String(describing: PlaceAnnotationView.self)
    }
}

// MARK: - Place Cluster View

internal final class PlaceClusterView: MKMarkerAnnotationView {
    
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    internal override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        centerOffset = CGPoint(x: 0.0, y: -10.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with annotation: MKAnnotation) {
        // Hide MKMarkerAnnotationView's default rendering
        self.glyphText = ""
        self.glyphTintColor = UIColor.clear
        self.markerTintColor = UIColor.clear
        
        guard let annotation = annotation as? MKClusterAnnotation else { return }
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0))
        let count = annotation.memberAnnotations.count
        image = renderer.image { _ in
            
            // Outer Circle
            UIColor(#colorLiteral(red: 0.2509803922, green: 0, blue: 0.5098039216, alpha: 0.25)).setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()

            // Inner Circle
            UIColor(#colorLiteral(red: 0.2509803922, green: 0, blue: 0.5098039216, alpha: 1)).setFill()
            UIBezierPath(ovalIn: CGRect(x: 4, y: 4, width: 32, height: 32)).fill()

            // Finally draw count text vertically and horizontally centered
            let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                               NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0)]
            let text = "\(count)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
