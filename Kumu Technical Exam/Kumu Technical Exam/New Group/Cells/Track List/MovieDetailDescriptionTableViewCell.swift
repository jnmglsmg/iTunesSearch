//
//  TrackDetailDescriptionTableViewCell.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/18/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit

let MovieDetailDescriptionTableViewCellID = "MovieDetailDescriptionTableViewCellID"
class MovieDetailDescriptionTableViewCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(description: String) {
        descriptionLabel.text = description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
