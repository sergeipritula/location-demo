//
//  ForegroundImageView.swift
//  LocationDemo
//
//  Created by Sergey Pritula on 19.07.2023.
//

import Foundation
import SwiftUI

struct ForegroundImageView: View {
    @State private var backgroundImage: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            if let image = backgroundImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray
            }
            
            Button(action: {
                Task {
                    await loadImage()
                }
            }, label: {
                Text("Load Background")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding()
            .disabled(isLoading)
            .opacity(isLoading ? 0.5 : 1.0)
        }
    }
    
    private func loadImage() async {
        isLoading = true
        
        do {
            guard let imageURL = URL(string: "https://images.unsplash.com/photo-1533450718592-29d45635f0a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80") else {
                return
            }
            
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            if let loadedImage = UIImage(data: data) {
                backgroundImage = loadedImage
            }
        } catch {
            print("Error loading image: \(error)")
        }
        
        isLoading = false
    }
}

struct ForegroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        ForegroundImageView()
    }
}
