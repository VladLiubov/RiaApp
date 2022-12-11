//
//  Models.swift
//  RiaApp
//
//  Created by Admin on 11.12.2022.
//

import Foundation
import MapKit

struct MapInfo: Identifiable {
    var id = UUID()
    var region: MKCoordinateRegion
    var location: [LocationInfo]
}

struct LocationInfo: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
