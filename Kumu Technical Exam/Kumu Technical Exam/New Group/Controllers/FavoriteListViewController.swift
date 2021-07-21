//
//  FavoritesViewController.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/21/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var favoriteTrackListViewModel: FavoriteListViewModel = FavoriteListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAll()
    }
    
    private func fetchAll() {
        showActivityIndicator()
        favoriteTrackListViewModel.fetchItems(completion: { (favoriteTrackListViewModel, error) in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                guard let favoriteTrackListViewModel = favoriteTrackListViewModel, error == nil else {
                    return
                }
                self.favoriteTrackListViewModel = favoriteTrackListViewModel
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTrackListTableViewCellID, for: indexPath) as! FavoriteTrackListTableViewCell
        
        let favoriteTrackViewModel = favoriteTrackListViewModel.itemAt(index: indexPath.row)
        cell.setViewModel(favoriteTrackViewModel: favoriteTrackViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Set Last Visit
        favoriteTrackListViewModel.setLastVisitFor(row: indexPath.row)
        
        //prepare view model for 2nd screen
        let movieDetailViewModel = favoriteTrackListViewModel.getDetailsViewModelAt(row: indexPath.row)
        let movieDetailViewController = MovieDetailViewController.initWithMovieDetailViewModel(movieDetailViewModel: movieDetailViewModel)
        
        //navigate to next screen
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteTrackListViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteConfirmationAlert(for: indexPath)
        }
    }
    
    //MARK: Delete Alert Functions
    
    private func showDeleteConfirmationAlert(for indexPath: IndexPath) {
        let alertController = setupDeleteAlert(for: indexPath)
        present(alertController, animated: true)
    }
    
    private func setupDeleteAlert(for indexPath: IndexPath) -> UIAlertController {
        let favoriteTrackViewModel = favoriteTrackListViewModel.itemAt(index: indexPath.row)
        let alertController = UIAlertController(title: "Delete Favorite?", message: "Remove \(favoriteTrackViewModel.title) to your favorites?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.tableView.beginUpdates()
            self.deleteItem(at: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    private func deleteItem(at indexPath: IndexPath) {
        favoriteTrackListViewModel.deleteFavorite(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //MARK: Activity Indicator
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.systemBlue
        view.addSubview(activityIndicator)
    }
    
    private func showActivityIndicator() {
        tableView.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func hideActivityIndicator() {
        tableView.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    //MARK: Alert for Error Handling
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.fetchAll()
        }
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
