//
//  ContentView.swift
//  Swift-Unsplash
//
//  Created by Lucas BILLY on 1/23/24.
//

import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            // permet à l'image à être redimensionnable en height et en width
            .resizable()
            // permet à l'image de prendre toutes l'espace disponible
            .scaledToFill()
            // définie la taille de l'image
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct ContentView: View {
    @State var images: [UnsplashPhoto] = []
    
    // Déclaration d'une fonction asynchrone
    func loadData() async {
        // Créez une URL avec la clé d'API
        let url = URL(string: "https://api.unsplash.com/photos?client_id=\(ConfigurationManager.instance.plistDictionnary.clientId)")!

        do {
            // Créez une requête avec cette URL
            let request = URLRequest(url: url)
            
            // Faites l'appel réseau
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)

            // Mettez à jour l'état de la vue
            images = deserializedData

        } catch {
            print("Error: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
            HStack{
                Spacer()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 150)),GridItem(.flexible(minimum: 150))], spacing: 8, content: {
                        ForEach(images, id: \.id) { image in
                            AsyncImage(url: URL(string: image.urls.full)!){ image in
                                image
                                    .centerCropped()
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height:150)
                        }
                    })
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            }
            .navigationTitle("Feed")
            Button(action: {
                Task {
                    await loadData()
                }
            }) {
                Text("Load Data")
            }
        }
    }
}

#Preview {
    ContentView()
}
