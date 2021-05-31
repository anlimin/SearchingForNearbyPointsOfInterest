//
//  Time+Extension.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-18.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

extension Double {
    func toDisplayString() -> String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60
        if totalSeconds < 3600 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
}
