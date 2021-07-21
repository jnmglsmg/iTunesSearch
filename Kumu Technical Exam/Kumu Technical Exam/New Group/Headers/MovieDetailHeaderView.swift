//
//  TrackDetailHeaderView.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/18/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit
import SDWebImage

protocol FavoriteFromDetailViewDelegate {
    func didTapFavorite()
}

let TrackDetailHeaderViewID = "TrackDetailHeaderViewID"
class MovieDetailHeaderView: UIView {
    @IBOutlet var trackTitleLabel: UILabel!
    @IBOutlet var advisoryRatingLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var rentalPriceLabel: UILabel!
    @IBOutlet var trackPriceLabel: UILabel!
    @IBOutlet var addToFavoriteButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    var delegate: FavoriteFromDetailViewDelegate?
    var isFavorite: Bool = false
    var shouldShowDelete: Bool = false
    
    func setup(trackTitle: String, artist: String, advisoryRating: String, rentalPrice: String, trackPrice: String, isFavorite: Bool, imageUrl: String, showDelete: Bool) {
        trackTitleLabel.text = trackTitle
        advisoryRatingLabel.text = advisoryRating
        rentalPriceLabel.text = rentalPrice
        trackPriceLabel.text = trackPrice
        imageView.sd_setImage(with: URL(string:imageUrl), placeholderImage: UIImage(named: "no_image"))
        artistLabel.text = artist
        self.isFavorite = isFavorite
        shouldShowDelete = showDelete
        setFavoriteButtonImage()
    }
    
    @IBAction func didTapAddtoFavorite() {
        if let delegate = delegate {
            delegate.didTapFavorite()
            isFavorite = !isFavorite
            setFavoriteButtonImage()
        } else {
            return
        }
    }
    
    private func setFavoriteButtonImage() {
        if shouldShowDelete {
            addToFavoriteButton.setImage(UIImage(named: "trash_icn"), for: .normal)
            return
        }
        
        if isFavorite {
            addToFavoriteButton.setImage(UIImage(named: "selected_heart_icn"), for: .normal)
        } else {
            addToFavoriteButton.setImage(UIImage(named: "unselected_heart_icn"), for: .normal)
        }
    }
}
