//
//  AudioListViewModel.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import Foundation

class MovieListViewModel {
    let movieListService = MovieListService()
    var movieViewModelList: [MovieViewModel]
    var shouldReloadWhenCleared: Bool = true
    
    init() {
        movieViewModelList = []
    }
    
    init(movieViewModelList: [MovieViewModel]) {
        self.movieViewModelList = movieViewModelList
    }
    
}

//Extension for Functions. For Code Management Only
extension MovieListViewModel {
    
    func itemAt(index:Int) -> MovieViewModel {
        return movieViewModelList[index]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return movieViewModelList.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    //Fetch Base API
    func fetchItems(completion:@escaping (_ movieListViewModel: MovieListViewModel?, _ error: Error?) -> Void) {
        movieListService.fetchMovies { (result, error) in
            DispatchQueue.main.async {
                if let result = result, error == nil {
                    
                    //set reload flag to false to avoid wasting data of user
                    self.shouldReloadWhenCleared = false
                    //use map instead
                    var movieVMList: [MovieViewModel] = []
                    for item in result.results {
                        let movieViewModel = MovieViewModel(track: item)
                        movieVMList.append(movieViewModel)
                    }
                    
                    self.movieViewModelList = movieVMList
                    completion(self, nil)
                    
                    
                } else {
                    completion(nil, error)
                }
            }
        }
    }
    
    func fetchItemsWithPhrase(searchPhrase: String, completion:@escaping (_ movieListViewModel: MovieListViewModel?, _ error: Error?) -> Void) {
        shouldReloadWhenCleared = true
        movieListService.fetchTrackWithPhrase(phrase: searchPhrase) { (result, error) in
            if let result = result, error == nil {
                //use map instead
                var movieVMList: [MovieViewModel] = []
                for item in result.results {
                    let movieViewModel = MovieViewModel(track: item)
                    movieVMList.append(movieViewModel)
                }
                
                self.movieViewModelList = movieVMList
                completion(self, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    func setLastVisitFor(row: Int) {
        let movieViewModel = itemAt(index: row)
        movieViewModel.setLastVisit()
    }
    
    func getDetailsViewModelAt(row: Int) -> MovieDetailViewModel {
        let movieListViewModel = itemAt(index: row)
        let movieDetailViewModel = MovieDetailViewModel(track: movieListViewModel.track)
        
        return movieDetailViewModel
    }
    
    func didTapFavorite(indexPath: IndexPath) {
        var movieViewModel = itemAt(index: indexPath.row)
        if movieViewModel.isFavorite {
            movieViewModel.isFavorite = false
        } else {
            movieViewModel.isFavorite = true
        }
    }
}

struct MovieViewModel {
    fileprivate let track: Track
    private let favoriteService = FavoritesService()
    private let visitedService = VisitedTracksService()
    
    
    var title: String {
        return track.trackName ?? ""
    }
    
    var artist: String {
        return track.artistName ?? ""
    }
    
    var genre: String {
        return track.primaryGenreName ?? ""
    }
    
    var image_url: String {
        return track.artworkUrl100 ?? ""
    }
    
    var trackPrice: String {
        if let trackPrice = track.trackPrice, let currency = track.currency {
            return "\(currency) \(trackPrice)"
        } else {
            return "N/A"
        }
    }
    
    var rentalPrice: String {
        if let trackPrice = track.trackRentalPrice, let currency = track.currency {
            return "\(currency) \(trackPrice)"
        } else {
            return "N/A"
        }
    }
    
    var isFavorite: Bool {
        get {
            guard let trackId = track.trackId else {
                return false
            }
            
            if favoriteService.fetchFavoriteWith(id: trackId) != nil {
                return true
            } else {
                return false
            }
        }
        
        set {
            guard let trackId = track.trackId else {
                return
            }
            
            //if track is favorite then delete. else add to table
            if favoriteService.fetchFavoriteWith(id: trackId) != nil {
                favoriteService.deleteFavorite(trackId: trackId)
            } else {
                favoriteService.setFavoriteTrack(track: track)
            }
        }
    }
    
    var lastVisit: String {
        get {
            guard let trackId = track.trackId else {
                return ""
            }
            guard let visitedTrack = visitedService.fetchVisitedTrackWith(id: trackId) else {
                return ""
            }
            
            if let visitDate = visitedTrack.lastVisit {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, h:mm a"
                let formattedDate = formatter.string(from: visitDate)
                
                return formattedDate
            } else {
                return ""
            }
        }
    }
    
    init(track: Track) {
        self.track = track
    }
    
}

extension MovieViewModel {
    
    func setLastVisit() {
        guard let trackId = self.track.trackId else {
            return
        }
        
        let currentDate = Date()
        visitedService.setVisitDate(trackId: trackId, currentDate: currentDate)
    }
}
