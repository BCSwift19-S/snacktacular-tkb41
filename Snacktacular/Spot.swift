//
//  Spot.swift
//  Snacktacular
//
//  Created by Kyle Burns on 3/27/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import MapKit

class Spot: NSObject, MKAnnotation {
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var averageRating: Double
    var numberOfReviews: Int
    var postingUserID: String
    var documentID: String
    
    var longitude: CLLocationDegrees {
        return coordinate.longitude
    }
    
    var latitude: CLLocationDegrees{
        return coordinate.latitude
    }
    var location: CLLocation{
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    var title: String? {
        return address
    }
    var dictionary: [String: Any]{
        return ["name":name, "address":address, "longitude":longitude, "numberofReviews":numberOfReviews, "postingUserID":postingUserID]
    }
    
    init(name: String, addresss: String, coordinate: CLLocationCoordinate2D, averageRating: Double, numberOfReviews: Int, postingUserID: String, documentID: String){
        self.name = name
        self.address = addresss
        self.coordinate = coordinate
        self.averageRating = averageRating
        self.numberOfReviews = numberOfReviews
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    convenience override init() {
        self.init(name: "", addresss: "", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: "")
    }
    convenience init(dictionary: [String: Any]){
        let name = dictionary["name"] as! String? ?? ""
        let address = dictionary["address"] as! String? ?? ""
        let latitude = dictionary["latitude"] as! CLLocationDegrees? ?? 0.0
        let longitude = dictionary["longitude"] as! CLLocationDegrees? ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let averageRating = dictionary["averageRating"] as! Double? ?? 0.0
        let numberOfReviews = dictionary["numberOfReviews"] as! Int? ?? 0
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, addresss: address, coordinate: coordinate, averageRating: averageRating, numberOfReviews: numberOfReviews, postingUserID: postingUserID, documentID: "")
    }
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        //grab user id
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            return completed(false)
    
        }
        self.postingUserID = postingUserID
        // creating a dictionary
        let dataToSave = self.dictionary
        // if record is saved we'll have an corresponing ID
        if self.documentID != ""{
            let ref = db.collection("spots").document(self.documentID)
            
            ref.setData(dataToSave) { (error) in
            if let error = error {
                print("error updating document")
                completed(false)
                
            } else{
                print("documented updated with \(ref.documentID)")
                completed(true)
                }
            }
            } else {
                var ref: DocumentReference? = nil
                ref = db.collection("spots").addDocument(data: (dataToSave)) { error in
                    if let error = error {
                        print("error creating new document")
                        completed(false)
                        
                    } else{
                        print("documented created with \(ref?.documentID)")
                        completed(true)
              }
           }
        }
     }
  }
