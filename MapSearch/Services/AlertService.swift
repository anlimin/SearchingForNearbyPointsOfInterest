//
//  AlertService.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-18.
//  Copyright © 2021 Apple. All rights reserved.
//

import UIKit

class AlertService {
    private init() {}
    
    public static func showActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }
    
    //MARK: - Alert
    
    static func showLocationServicesAlert(on vc: UIViewController) {
        
        let alert = UIAlertController(title: "Location Services Off", message: "Turn on Location Services in Settings > Privacy to allow this app to determine your current location", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (settingsAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
            vc.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        alert.preferredAction = settingsAction
        
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
    
    static func showDirectionsNotAavailableAlert(on vc: UIViewController) {
        let alert = UIAlertController(title: "Directions Not Available", message: "Unable to retrieve directions", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
    }
}
