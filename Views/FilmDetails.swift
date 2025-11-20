//
//  FilmDetails.swift
//  Ghibili-try-01
//
//  Created by Ravindu Bandara on 2025-11-20.
//

import SwiftUI

struct FilmDetails: View {
    
    let film : Films
    @Environment(FilmsViewModel.self) private var viewModel
    @State private var isFavorite = false
    
    var body: some View {
       
        ScrollView{
            VStack(alignment: .center, spacing: 8){
                
                if     let url = URL(string: film.movieBanner) {
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
                                    .frame(height: 300)
                                    .containerRelativeFrame(.horizontal)
                                }

                
                Text(film.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(film.releaseDate)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(film.director)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(film.description)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
            }
        }
        .navigationTitle("Film Details")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                }
            }
        }
        .onAppear {
            viewModel.refreshFavorites()
            isFavorite = viewModel.isFavorite(film)
        }
        
    }
    
    private func toggleFavorite(){
        viewModel.toggleFavorite(film)
        isFavorite = viewModel.isFavorite(film)
    }
}

#Preview {
    NavigationStack{
        FilmDetails(film: .sampleFilm)
            .environment(FilmsViewModel())
    }
}
