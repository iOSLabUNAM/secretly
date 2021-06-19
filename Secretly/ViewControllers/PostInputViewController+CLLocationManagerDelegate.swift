//
//  PostInputViewController+UICollectionViewDataSource.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 12/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit
import CoreLocation

extension PostInputViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        self.currentLocation = lastLocation.coordinate
    }
}
