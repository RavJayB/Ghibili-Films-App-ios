//
//  FavoriteView.swift
//  Ghibili-try-01
//
//  Created by Ravindu Bandara on 2025-11-21.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FilmsViewModel.self) private var viewModel
    
    var body: some View {
        Group {
            if viewModel.favoriteFilms.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    Text("No saved films yet")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Tap the bookmark icon in a Film to add it to your favorites.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List{
                    ForEach(viewModel.favoriteFilms) { film in
                        NavigationLink {
                            FilmDetails(film: film)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(film.title)
                                    .font(.headline)
                                Text(film.director)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.removeFavorite)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.refreshFavorites()
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
            .environment(FilmsViewModel())
    }
}




