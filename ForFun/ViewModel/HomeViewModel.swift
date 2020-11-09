//
//  HomeViewModel.swift
//  ForFun
//
//  Created by MD Tanvir Alam on 5/11/20.
//

import Foundation
import CoreLocation
import Firebase
import SwiftUI

class HomeViewModel:NSObject,ObservableObject,CLLocationManagerDelegate {
    @Published var showMenu = false
    @Published var locationManager = CLLocationManager()
    @Published var userLocation:CLLocation!
    @Published var userAddress = ""
    @Published var girls:[Girl] = []
    @Published var filteredGirls:[Girl] = []
    @Published var searchGirl = ""
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorise")
            print(userAddress)
        case .denied:
            print("Denied")
        default:
            print("unknown")
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
        login()
    }
    
    func extractLocation(){
        print("I am in extractLocation")
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { res, error in
            guard let safeData = res else{return}
            var address = ""
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            print(address)
            self.userAddress = address
        }
    }
    
    func login(){
        Auth.auth().signInAnonymously { (res, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            print("Success = \(res!.user.uid)")
            self.fetchItems()
        }
    }
    func fetchItems(){
        let db = Firestore.firestore()
        db.collection("Items").getDocuments { (snap, error) in
            guard let safeItemData = snap else{return}
            self.girls = safeItemData.documents.compactMap({ (doc) -> Girl? in
                let id = doc.documentID
                let girlName = doc.get("girl_name") as! String
                if girlName == ""{
                    print("what the fuck!!")
                }
                let girlAge = doc.get("girl_age") as! NSNumber
                let girlRating = doc.get("girl_rating") as! String
                let girlImage = doc.get("girl_image") as! String
                return Girl(id: id, girl_age: girlAge, girl_name: girlName, girl_image: girlImage, girl_rating: girlRating)
            })
            self.filteredGirls = self.girls
        }
    }
    func filterData(){
        withAnimation(.easeIn){
            filteredGirls = girls.filter{
                return $0.girl_name.lowercased().contains(self.searchGirl.lowercased())
            }
        }
    }
}
