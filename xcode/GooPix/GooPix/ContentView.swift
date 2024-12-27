//
//  ContentView.swift
//  GooPix
//
//  Created by Klaus Wenger on 12/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var photosManager = GooglePhotosManager()
    @State private var selectedPhotos: [MediaItem] = []
    @State private var showingPicker = false
    @State private var error: Error?
    
    var body: some View {
        VStack {
            if selectedPhotos.isEmpty {
                Text("Select photos from Google Photos")
                    .padding()
                Button("Choose Photos") {
                    Task {
                        do {
                            let session = try await photosManager.createPickerSession()
                            // Handle opening picker URI
                            showingPicker = true
                        } catch {
                            self.error = error
                        }
                    }
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(selectedPhotos) { item in
                            AsyncImage(url: URL(string: item.baseUrl)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipped()
                        }
                    }
                }
            }
        }
        .alert("Error", isPresented: .constant(error != nil)) {
            Button("OK") { error = nil }
        } message: {
            Text(error?.localizedDescription ?? "Unknown error")
        }
    }
}

#Preview {
    ContentView()
}
