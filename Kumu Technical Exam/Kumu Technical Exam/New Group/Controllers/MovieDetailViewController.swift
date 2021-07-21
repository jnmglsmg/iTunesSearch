//
//  AudioDetailViewController.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit

enum MovieDetailRowType: Int {
    case description = 0
    case information
}

let MovieDetailViewControllerID = "MovieDetailViewControllerID"
class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteFromDetailViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    private var movieDetailViewModel: MovieDetailViewModel?
    
    //instancetype
    static func initWithMovieDetailViewModel(movieDetailViewModel: MovieDetailViewModel) -> MovieDetailViewController {
        //Details View Controller Instance Type with Method Injection
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: MovieDetailViewControllerID) as MovieDetailViewController
        viewController.movieDetailViewModel = movieDetailViewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movieDetailViewModel = movieDetailViewModel else {
            return 0
        }
        return movieDetailViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieDetailViewModel = movieDetailViewModel else {
            return UITableViewCell()
        }
        
        switch (indexPath.row) {
        case MovieDetailRowType.description.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailDescriptionTableViewCellID, for: indexPath) as! MovieDetailDescriptionTableViewCell
            cell.setup(description: movieDetailViewModel.longDescription)
            return cell
            
        case MovieDetailRowType.information.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailInformationTableViewCellID, for: indexPath) as! MovieDetailInformationTableViewCell
            cell.setup(genre: movieDetailViewModel.genre, releaseDate: movieDetailViewModel.released)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let movieDetailViewModel = movieDetailViewModel else {
            return UIView()
        }
        let headerView = Bundle.main.loadNibNamed("MovieDetailHeaderView", owner: self, options: nil)?.first as! MovieDetailHeaderView
        headerView.layoutIfNeeded()
        headerView.delegate = self
        
        headerView.setup(trackTitle: movieDetailViewModel.title, artist: movieDetailViewModel.artistName, advisoryRating: movieDetailViewModel.advisoryRating, rentalPrice: movieDetailViewModel.rentalPrice, trackPrice: movieDetailViewModel.trackPrice, isFavorite: movieDetailViewModel.isFavorite, imageUrl: movieDetailViewModel.imageUrl, showDelete: movieDetailViewModel.showDelete)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 170
    }
    
    //MARK: Favorite Delegate Method
    
    func didTapFavorite() {
        if let showDelete =  movieDetailViewModel?.showDelete, showDelete {
            showDeleteConfirmationAlert()
            return
        }
        movieDetailViewModel?.didTapFavorite()
        viewWillAppear(false)
    }

    func showDeleteConfirmationAlert() {
        let alertController = UIAlertController(title: "Delete Favorite?", message: "Remove \(movieDetailViewModel?.title ?? "") to your favorites?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.movieDetailViewModel?.didTapFavorite()
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
    
