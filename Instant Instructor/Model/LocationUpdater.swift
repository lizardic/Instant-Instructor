//
//  LocationManager.swift
//  Instant Instructor
//
//  Created by Christian Lizardi on 7/28/20.
//  Copyright © 2020 Find A Coach. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationUpdaterDelegate {
    func didUpdateLocation(_ locationUpdater: LocationUpdater, _ location: CLLocation)
    func didFailWithError(error: Error)
}
struct LocationUpdater {
    var delegate: LocationUpdaterDelegate?
    var location: CLLocation?
    
    func applyLocation(_ location: CLLocation) {
        self.delegate?.didUpdateLocation(self, location)
        
    }

}
