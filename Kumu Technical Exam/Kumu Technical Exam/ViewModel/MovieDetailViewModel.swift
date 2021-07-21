//
//  TrackDetailsViewModel.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/18/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//
import Foundation

struct MovieDetailViewModel {
    fileprivate let track: Track
    private let favoriteService = FavoritesService()

    var title: String {
        return track.trackName ?? ""
    }
    
    var artistName: String {
        return track.artistName ?? ""
    }
    
    var advisoryRating: String {
        return track.contentAdvisoryRating ?? ""
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
    
    var imageUrl: String {
        return track.artworkUrl100 ?? ""
    }
    
    var longDescription: String {
        return track.longDescription ?? "N/A"
    }
    
    var genre: String {
        return track.primaryGenreName ?? "N/A"
    }
    
    var released: String {
        let dateFormatter = DateFormatter()
        let dateFormatter2 = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter2.timeZone = NSTimeZone.local
        guard let publishedAtDate = dateFormatter.date(from: track.releaseDate ?? "") else {
            return "N/A"
        }
        
        dateFormatter2.dateFormat = "MMM d, yyyy"
        let finalDate = dateFormatter2.string(from: publishedAtDate)
        return finalDate
    }
    
    var isFavorite: Bool {
        get {
            guard let trackId = track.trackId else {
                return false
            }
            
            //Fetch Favorite Record in Core Data
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
    
    var showDelete: Bool = false
    
    init(track: Track) {
        self.track = track
    }
    
    init(track: Track, showDelete: Bool) {
        self.track = track
        self.showDelete = showDelete
    }
}

//Extension for Code Management Only. Methods go here
extension MovieDetailViewModel {
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 2
    }
    
    mutating func didTapFavorite() {
        isFavorite = !isFavorite
    }
}
