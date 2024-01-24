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
    @StateObject var feedState : FeedState = FeedState()
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal){
                LazyHGrid(rows: [GridItem(.flexible(minimum: 150))], spacing: 13, content: {
                    Spacer().frame(width: 5)
                    if let topics = feedState.topics {
                        ForEach(topics, id: \.id){ topic in
                            VStack{
                                AsyncImage(url: URL(string: topic.cover_photo.urls.full)!){ image in
                                    image
                                        .centerCropped()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 110, height: 70)
                                Text(topic.slug)
                            }
                        }
                    }
                    else{
                        ForEach(1...12, id: \.self) { _ in
                            VStack{
                                Rectangle()
                                    .fill(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .frame(width: 110, height: 70)
                                Text("placholder")
                            }.redacted(reason: .placeholder)
                        }
                    }
                    Spacer().frame(width: 5)
                })
            }
            .frame(height: 140)
            HStack{
                Spacer()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 150)),GridItem(.flexible(minimum: 150))], spacing: 8, content: {
                        if let images = feedState.homeFeed {
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
                        }
                        else{
                            ForEach(1...12, id: \.self) { _ in
                                Rectangle()
                                    .fill(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .frame(height:150)
                            }
                        }
                    })
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            }
            .navigationTitle("Feed")
            Button(action: {
                Task {
                    await feedState.fetchTopics()
                    await feedState.fetchHomeFeed()
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
