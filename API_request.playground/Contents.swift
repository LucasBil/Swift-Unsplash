import UIKit

struct Movie: Codable {
    let title: String
    let releaseYear: Int
    let genre: String
    let director : Director?
}

struct Director: Codable {
    let firstname : String
    let lastname : String
    
    func toString() -> String {
        return "\(firstname) \(lastname.uppercased())"
    }
}

let jsonString = """
[
    {
        "title": "Inception",
        "releaseYear": 2010,
        "genre": "Sci-Fi"
    },
    {
        "title": "The Dark Knight",
        "releaseYear": 2008,
        "genre": "Action",
        "director": {
                        "firstname" : "hop",
                        "lastname" : "poh"
                    }
    }
]
"""

if let jsonData = jsonString.data(using: .utf8) {
    do {
        let movies = try JSONDecoder().decode([Movie].self, from: jsonData)
        // Ici, vous avez un tableau de films que vous pouvez utiliser.
        for movie in movies {
            print("Film: \(movie.title), Année de sortie: \(movie.releaseYear), Genre: \(movie.genre)" + ((movie.director != nil) ? ", Realisateur : \(String(describing: movie.director?.toString()))" : ""))
        }
    } catch {
        print("Erreur de décodage: \(error)")
    }
}
print("END")
