//
//  FavoriteTrackListTableViewCell.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/21/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit
import SDWebImage

let FavoriteTrackListTableViewCellID = "FavoriteTrackListTableViewCellID"
class FavoriteTrackListTableViewCell: UITableViewCell {
    
    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var trackPriceLabel: UILabel!
    @IBOutlet var rentalPriceValueLabel: UILabel!
    @IBOutlet var rentalPriceLabel: UILabel!
    @IBOutlet var lastVisitLabel: UILabel!
    var favoriteTrackViewModel: FavoriteTrackViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewModel(favoriteTrackViewModel: FavoriteTrackViewModel) {
        self.favoriteTrackViewModel = favoriteTrackViewModel
        setupLabels()
    }
    
    private func setupLabels() {
            titleLabel.text = favoriteTrackViewModel?.title
            artistLabel.text = favoriteTrackViewModel?.artist
            genreLabel.text = favoriteTrackViewModel?.genre
            trackPriceLabel.text = favoriteTrackViewModel?.trackPrice
            rentalPriceValueLabel.text = favoriteTrackViewModel?.rentalPrice
            artworkImageView.sd_setImage(with: URL(string: favoriteTrackViewModel?.image_url ?? ""), placeholderImage: UIImage(named: "no_image"))
            lastVisitLabel.text = favoriteTrackViewModel?.lastVisit
        }

}
