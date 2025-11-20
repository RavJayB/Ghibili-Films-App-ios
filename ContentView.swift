//
//  ContentView.swift
//  Ghibili-try-01
//
//  Created by Ravindu Bandara on 2025-11-20.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = FilmsViewModel()
    
    
    var body: some View {
        TabView{
            NavigationStack{
                VStack{
                    switch viewModel.appsState {
                    case .success:
                        FilmsList(films: viewModel.films)
                    case .failure:
                        Text(viewModel.errorMessage ?? "Something is wrong")
                    case .loading:
                        ProgressView()
                    case .idle:
                        EmptyView()
                    }
                }
                .navigationTitle("Books App")
                .task {
                    await viewModel.fetchFilms()
                }
            }
            .tabItem{
                Label("Browse", systemImage: "tv")
            }
            
            NavigationStack{
                FavoritesView()
            }
            
            .tabItem{
                Label("Favorits", systemImage: "bookmark.fill")
            }
        }
        .environment(viewModel)
    }
}

#Preview {
    ContentView()
}
