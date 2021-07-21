//
//  AudioListTableViewCell.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit
import SDWebImage

protocol FavoriteFromIndexPathDelegate {
    func setFavorite(with indexPath: IndexPath)
}

let MovieListTableViewCellID = "MovieListTableViewCellID"
class MovieListTableViewCell: UITableViewCell {
    @IBOutlet var artworkImageView: UIImageView! // Custom Class
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var trackPriceLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var rentalPriceValueLabel: UILabel!
    @IBOutlet var rentalPriceLabel: UILabel!
    @IBOutlet var lastVisitLabel: UILabel!
    
    var movieViewModel: MovieViewModel?
    var delegate: FavoriteFromIndexPathDelegate? = nil
    var indexPath: IndexPath = IndexPath()
    var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setViewModel(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
        self.isFavorite = movieViewModel.isFavorite
        setupLabels()
    }
    
    //label configuration
    private func setupLabels() {
        titleLabel.text = movieViewModel?.title
        artistLabel.text = movieViewModel?.artist
        genreLabel.text = movieViewModel?.genre
        trackPriceLabel.text = movieViewModel?.trackPrice
        rentalPriceValueLabel.text = movieViewModel?.rentalPrice
        artworkImageView.sd_setImage(with: URL(string: movieViewModel?.image_url ?? ""), placeholderImage: UIImage(named: "no_image"))
        lastVisitLabel.text = movieViewModel?.lastVisit
        setFavoriteButtonImage()
    }
    
    //Update favorite icon. Refresh Row makes cell jittery and ocassionally move
    private func setFavoriteButtonImage() {
           if isFavorite {
               favoriteButton.setImage(UIImage(named: "selected_heart_icn"), for: .normal)
           } else {
               favoriteButton.setImage(UIImage(named: "unselected_heart_icn"), for: .normal)
           }
       }
    
    @IBAction func didTapAddToFavorite(_ sender: Any) {
        if let delegate = delegate {
            delegate.setFavorite(with: indexPath)
            isFavorite = !isFavorite
            setupLabels()
        }
    }

}
