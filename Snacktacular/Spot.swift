//
//  Spot.swift
//  Snacktacular
//
//  Created by Kyle Burns on 3/27/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import CoreLocation

class Spot {
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var averageRating: Double
    var numberOfReviews: Int
    var postingUserID: String
    var documentID: String
    
    init(name: String, addresss: String, coordinate: CLLocationCoordinate2D, averageRating: Double, numberOfReviews: Int, postingUserID: String, documentID: String){
        self.name = name
        self.address = addresss
        self.coordinate = coordinate
        self.averageRating = averageRating
        self.numberOfReviews = numberOfReviews
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    convenience init() {
        self.init(name: "", addresss: "", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: "")
    }
    
}
