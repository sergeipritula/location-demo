//
//  ContentView.swift
//  LocationDemo
//
//  Created by Sergey Pritula on 18.07.2023.
//

import SwiftUI

struct ContentView: View {
   
    @State private var isSwitched = true
    
    var body: some View {
        
        VStack {
            Button(self.isSwitched ? "Image Loading": "Location") {
                self.isSwitched.toggle()
            }
            Group {
                if isSwitched {
                    LocationMapView()
                } else {
                    ForegroundImageView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
