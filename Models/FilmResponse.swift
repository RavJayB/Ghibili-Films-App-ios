//
//  FilmResponse.swift
//  Ghibili-try-01
//
//  Created by Ravindu Bandara on 2025-11-20.
//

import Foundation

struct Films: Codable, Identifiable {
    let id = UUID()
    let title: String
    let director: String
    let image: String
    let description: String
    let originalTitle: String
    let releaseDate: String
    let movieBanner:String
    
    
    enum CodingKeys : String, CodingKey {
        case title
        case director
        case image
        case description
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case movieBanner = "movie_banner"
    }
}

typealias FilmResponse = [Films]


extension Films{
    static let sampleFilm = Films (title: "Dark Knight", director: "Ravindu Bandara", image: "https://i5.walmartimages.com/seo/DC-Comics-Movie-The-Dark-Knight-Rises-One-Sheet-Wall-Poster-14-725-x-22-375_f135424f-fe0c-4a54-ad8e-3d88087d9119.4ff2a3dd7c8185ae9eb894b53e7051e6.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF", description: "he Dark Knight is a 2008 superhero film directed by Christopher Nolan. It follows Batman's alliance with Lieutenant Jim Gordon and District Attorney Harvey Dent to dismantle organized crime in Gotham City, a plan that is derailed by the anarchist mastermind known as the Joker. The film explores the conflict between chaos and order, with Batman's struggle against the Joker testing his principles and forcing him to confront his role as Gotham's vigilante. ", originalTitle: "ƒ¨ç˚ ¥ø¨", releaseDate: "2025", movieBanner: "https://metro.co.uk/wp-content/uploads/2012/05/article-1337943628840-1349f527000005dc-104908_636x300.jpg?quality=90&strip=all&zoom=1&resize=480%2C226")
}
