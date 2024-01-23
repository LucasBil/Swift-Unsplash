//
//  FeedState.swift
//  Swift-Unsplash
//
//  Created by Lucas BILLY on 1/23/24.
//

import Foundation

class FeedState : ObservableObject {
    let unsplashAPI : UnsplashAPI = UnsplashAPI()
    
    @Published var homeFeed: [UnsplashPhoto]?

    func fetchHomeFeed() async {
        guard let url = unsplashAPI.feedUrl() else {
            return
        }
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            homeFeed = deserializedData

        } catch {
            print("Error: \(error)")
        }
    }
}
