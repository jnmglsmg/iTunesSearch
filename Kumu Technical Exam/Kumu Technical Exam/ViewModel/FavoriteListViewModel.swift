//
//  FavoriteListViewModel.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/21/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import Foundation



class FavoriteListViewModel {
    var favoriteViewModelList: [FavoriteTrackViewModel]
    
    init() {
        favoriteViewModelList = []
    }
    
    init(favoriteViewModelList: [FavoriteTrackViewModel]) {
        self.favoriteViewModelList = favoriteViewModelList
    }
    
}

//Extension For Code Management Only
extension FavoriteListViewModel {
    
    func itemAt(index:Int) -> FavoriteTrackViewModel {
        return favoriteViewModelList[index]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return favoriteViewModelList.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    //Fetch Favorite Items from API
    func fetchItems(completion:@escaping (_ trackListViewModel: FavoriteListViewModel?, _ error: Error?) -> Void) {
        FavoriteListService().fetchAllTrackList { (result, error) in
            if let result = result, error == nil {
                //use map instead
                var favoritesVMList: [FavoriteTrackViewModel] = []
                for item in result.results {
                    let favoriteTrackViewModel = FavoriteTrackViewModel(track: item)
                    favoritesVMList.append(favoriteTrackViewModel)
                }
                
                self.favoriteViewModelList = favoritesVMList
                completion(self, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func setLastVisitFor(row: Int) {
        let favoriteTrackViewModel = itemAt(index: row)
        favoriteTrackViewModel.setLastVisit()
    }
    
    //prepare 2nd Screen View Model
    func getDetailsViewModelAt(row: Int) -> MovieDetailViewModel {
        let movieListViewModel = itemAt(index: row)
        let movieDetailViewModel = MovieDetailViewModel(track: movieListViewModel.track, showDelete: true)
        
        return movieDetailViewModel
    }
    
    func deleteFavorite(at indexPath: IndexPath) {
        let favoriteTrackViewModel = itemAt(index: indexPath.row)
        favoriteViewModelList.remove(at: indexPath.row)
        favoriteTrackViewModel.deleteFavorite()
    }
}


struct FavoriteTrackViewModel {
    fileprivate let track: Track
    private let favoriteService = FavoritesService()
    private let visitedService = VisitedTracksService()
    
    
    var title: String {
        return track.trackName ?? ""
    }
    
    var kind: String {
        return track.kind ?? ""
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
    
    var is_favorite: Bool {
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

extension FavoriteTrackViewModel {
    
    func setLastVisit() {
        guard let trackId = self.track.trackId else {
            return
        }
        
        let currentDate = Date()
        visitedService.setVisitDate(trackId: trackId, currentDate: currentDate)
    }
    
    func deleteFavorite() {
        guard let trackId = track.trackId else {
            return
        }
        
        //fetch favorite record then delete
        if favoriteService.fetchFavoriteWith(id: trackId) != nil {
            favoriteService.deleteFavorite(trackId: trackId)
        }
    }
}
