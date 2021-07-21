//
//  Audio.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/18/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

class Track: Decodable {
    let wrapperType: String?
    let kind: String?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let trackName: String?
    let collectionName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let trackRentalPrice: Double?
    let collectionHdPrice: Double?
    let trackHdPrice: Double?
    let trackHdRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let contentAdvisoryRating: String?
    let shortDescription: String?
    let longDescription: String?
    let hasITunesExtras: Bool?
}
