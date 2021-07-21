//
//  AudioListViewModel.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

struct TrackListViewModel {
    var trackViewModelList: [TrackViewModel] = []
    
    init(trackViewModelList: [TrackViewModel]) {
        self.trackViewModelList = trackViewModelList
    }
}

extension TrackListViewModel {
    func getItem(at index:Int) -> TrackViewModel {
        return trackViewModelList[index]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return trackViewModelList.count
    }
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
}

struct TrackViewModel {
    private let track: Track
//    private var favorite: Favorite?
    
    var title: String {
        return track.trackName
    }
    
    var artist: String {
        return track.artistName
    }
    
    var genre: String {
        return track.primaryGenreName
    }
    
    var image_url: String {
        return track.artworkUrl100
    }
    
    var price: String {
        let formattedPrice = "\(track.currency) \(track.trackPrice)"
        return formattedPrice
    }
    
//    var is_favorite: Bool
    
    init(with track: Track) {
        self.track = track
//        is_favorite = isFavorite(trackId: track.trackId)
    }
    
//    private func isFavorite(with audioId: String) -> Bool {
//        get favorite record with Id
//    }
}
