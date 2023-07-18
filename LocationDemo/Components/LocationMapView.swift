//
//  LocationMapView.swift
//  LocationDemo
//
//  Created by Sergey Pritula on 19.07.2023.
//


import Foundation
import SwiftUI
import MapKit

struct LocationMapView: View {
    @StateObject private var locationManager = LocationManager()
    
    var region: Binding<MKCoordinateRegion>? {
        guard let location = locationManager.userLocation else {
            return MKCoordinateRegion.defaultRegion().getBinding()
        }
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        return region.getBinding()
    }
    
    @State private var isFetching = false
    
    var body: some View {
        VStack {
            Divider()
            Button(self.isFetching ? "Stop monitoring": "Monitor location") {
                self.isFetching.toggle()
                
                if isFetching {
                    locationManager.startFetching()
                } else {
                    locationManager.stopFetching()
                }
            }
            
            if let region = region {
                Map(coordinateRegion: region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow))
                    .ignoresSafeArea()
            }
        }
    }
    
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}
