//
//  LocationManager.swift
//  LocationDemo
//
//  Created by Sergey Pritula on 18.07.2023.
//

import SwiftUI
import CoreLocation
import MapKit
import FirebaseStorage
import FirebaseDatabase

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        configureLocationManager()
    }
    
    func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func startFetching() {
        locationManager.startUpdatingLocation()
    }
    
    func stopFetching() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        
        Task {
            await uploadLocationDataToFirebase()
        }
    }
    
    func uploadLocationDataToFirebase() async {
        guard let userLocation = userLocation else { return }
        
        do {
            let location = LocationData(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            try await Database.database().reference()
                .child("locations")
                .childByAutoId()
                .setValue(location.toDictionnary)
        } catch {
            print("Coding or uploading error")
        }
    }
}

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 37.819527098978355,
                longitude:  -122.47854602016669
            ),
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
    }
    
    func getBinding() -> Binding<MKCoordinateRegion>? {
        return Binding<MKCoordinateRegion>(.constant(self))
    }
}
