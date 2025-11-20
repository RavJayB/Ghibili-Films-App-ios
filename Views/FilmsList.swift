//
//  FilmsList.swift
//  Ghibili-try-01
//
//  Created by Ravindu Bandara on 2025-11-20.
//

import SwiftUI

struct FilmsList: View {
    let films: [Films]
    var body: some View {
        List(films) { film in
            NavigationLink{
                FilmDetails(film: film)
            }
            label:{
                VStack(alignment: .leading){
                    
                    Text(film.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(film.director)
                        .foregroundStyle(.secondary)
                }
                
                HStack(){
                                   
                    if let url = URL(string: film.image) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image.resizable().scaledToFit()
                                            case .failure(_):
                                                Image(systemName: "book.closed")
                                            case .empty:
                                                ProgressView()
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        .frame(height: 200)
                                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }
            
        }
        
    }
}

#Preview {
    NavigationStack{
        FilmsList(films: [.sampleFilm])
    }
}
