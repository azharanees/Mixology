//
//  LandmarkAnnotation.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-27.
//

import MapKit
import UIKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
            }
}
