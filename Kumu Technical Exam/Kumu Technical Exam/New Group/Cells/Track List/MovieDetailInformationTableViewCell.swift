//
//  TrackDetailInformationTableViewCell.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/18/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit

let MovieDetailInformationTableViewCellID = "MovieDetailInformationTableViewCellID"
class MovieDetailInformationTableViewCell: UITableViewCell {

    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var releasedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(genre: String, releaseDate: String) {
        genreLabel.text = genre
        releasedLabel.text = releaseDate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
