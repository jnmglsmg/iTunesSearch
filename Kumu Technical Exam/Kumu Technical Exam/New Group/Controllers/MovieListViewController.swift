//
//  ViewController.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavoriteFromIndexPathDelegate, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let activityIndicator = UIActivityIndicatorView()
    var movieListViewModel: MovieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        //show activity indicator
        setupActivityIndicator()
        self.tableView.keyboardDismissMode = .onDrag
        fetchAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: Base Fetching
    private func fetchAll() {
        if !movieListViewModel.shouldReloadWhenCleared {
            return
        }
        
        showActivityIndicator()
        movieListViewModel.fetchItems(completion: { (movieListViewModel, error) in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                guard let movieListViewModel = movieListViewModel, error == nil else {
                    self.showAlert(title: "Failed", message: error?.localizedDescription ?? "")
                    return
                }
                self.movieListViewModel = movieListViewModel
                self.tableView.reloadData()
            }
        })
    }
    
    //MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCellID, for: indexPath) as! MovieListTableViewCell
        
        let movieViewModel = movieListViewModel.itemAt(index: indexPath.row)
        cell.setViewModel(movieViewModel: movieViewModel)
        cell.delegate = self
        
        //used for referencing the position of the selected item
        cell.indexPath = indexPath
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Set Last Visit
        movieListViewModel.setLastVisitFor(row: indexPath.row)
        
        //prepare view model for 2nd screen
        let movieDetailViewModel = movieListViewModel.getDetailsViewModelAt(row: indexPath.row)
        let movieDetailViewController = MovieDetailViewController.initWithMovieDetailViewModel(movieDetailViewModel: movieDetailViewModel)
        
        //navigate to next screen
        navigationController?.pushViewController(movieDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //to remove separator lines with no or few items are displayed
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    //Set Favorite Delegate Method
    func setFavorite(with indexPath: IndexPath) {
        movieListViewModel.didTapFavorite(indexPath: indexPath)
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
    
    //MARK: Search Delegate Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showActivityIndicator()
        movieListViewModel.fetchItemsWithPhrase(searchPhrase: searchBar.text ?? "") { (movieListViewModel, error) in
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                
                guard let movieListViewModel = movieListViewModel, error == nil else {
                    return //show alert
                }
                self.movieListViewModel = movieListViewModel
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            fetchAll()
        }
    }
    
    //MARK: Alert for Error Handling
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.fetchAll()
        }
        alertController.addAction(retryAction)
        present(alertController, animated: true, completion: nil)
    }
}

