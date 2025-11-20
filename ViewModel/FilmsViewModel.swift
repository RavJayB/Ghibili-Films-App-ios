//
//  FilmsViewModel.swift
//  Ghibili-try-01
//
//  Created by Ravindu Bandara on 2025-11-20.
//

import Foundation
import Observation
import SwiftUI

@Observable
class FilmsViewModel {
    private let storage = UserDefaults.standard
    private let favoritesKey = AppStorageKeys.favoriteFilms
    
    var appsState: AppStates = .idle
    var filmResponse: FilmResponse?
    var films: [Films] = []
    var errorMessage: String?
    var favoriteFilms: [Films] = []
    
    init() {
        refreshFavorites()
    }
    
    func fetchFilms() async {
        guard appsState != .loading else { return }
        
        appsState = .loading
        
        let urlString = "https://ghibliapi.vercel.app/films"
        
        guard let url = URL(string: urlString) else {
            errorMessage = APIErrors.invalidURL.errorDescription
            appsState = .failure
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponses = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponses.statusCode) else {
                errorMessage = APIErrors.invalidResponse.errorDescription
                appsState = .failure
                return
            }
            
            let decodeData = try JSONDecoder().decode(FilmResponse.self, from: data)
            filmResponse = decodeData
            films = decodeData
            appsState = .success
            
        } catch {
            errorMessage = APIErrors.unknown.errorDescription
            appsState = .failure
        }
    }
    
    func search(with text: String) {
        guard let allFilms = filmResponse else { return }
        
        guard !text.isEmpty else {
            films = allFilms
            return
        }
        
        let lowercased = text.lowercased()
        
        films = allFilms.filter {
            $0.title.lowercased().contains(lowercased)
        }
    }
    
    func refreshFavorites() {
        favoriteFilms = loadFavorites()
    }
    
    func toggleFavorite(_ films: Films) {
        if let index = favoriteFilms.firstIndex(where: { $0.title == films.title }) {
            favoriteFilms.remove(at: index)
        } else {
            favoriteFilms.append(films)
        }
        persistFavorites()
    }
    
    func removeFavorite(at offsets: IndexSet) {
        favoriteFilms.remove(atOffsets: offsets)
        persistFavorites()
    }
    
    func isFavorite(_ films: Films) -> Bool {
        favoriteFilms.contains { $0.title == films.title }
    }
    
    private func loadFavorites() -> [Films] {
        guard let data = storage.data(forKey: favoritesKey),
              let decoded = try? JSONDecoder().decode([Films].self, from: data) else {
            return []
        }
        return decoded
    }
    
    private func persistFavorites() {
        guard let data = try? JSONEncoder().encode(favoriteFilms) else { return }
        storage.set(data, forKey: favoritesKey)
    }
}

