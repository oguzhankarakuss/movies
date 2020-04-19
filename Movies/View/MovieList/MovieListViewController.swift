//
//  MovieListViewController.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

protocol MovieListViewControllerDelegate: class {
    func searchMovie(with text: String)
    func reset()
}

final class MovieListViewController: BaseViewController {
    
    private let dataSource = MovieListDataSource()
    
    weak var delegate: MovieListViewControllerDelegate?
    
    private var movieSearchViewController: MovieSearchViewController?
    
    private lazy var viewModel: MovieListViewModel? = {
        return MovieListViewModel(dataSource: self.dataSource)
    }()
    
    private var page = 1
    private var lastSearchText: String = ""
    
    // MARK: - UI
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(style: .grouped,
                                      cells: [MovieListTableViewCell.self],
                                      separatorStyle: .singleLine)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        movieSearchViewController = MovieSearchViewController(movieListViewController: self)
        movieSearchViewController?.delegate = self
        let searchController = UISearchController(searchResultsController: movieSearchViewController)
        searchController.searchBar.delegate = dataSource
        searchController.searchResultsUpdater = dataSource
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Movie"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie List"
        dataSource.viewController = self
        dataSource.delegate = self
        navigationItem.searchController = searchController
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        self.viewModel?.getUpcoming(with: page, completion: nil)
    }
    
    //    MARK: - Setup
    override func setupView() {
        super.setupView()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - MovieListDelegate
extension MovieListViewController: MovieListDelegate {
    func resetSearchMovie() {
        lastSearchText = ""
        delegate?.reset()
    }
    
    func updateList() {
        viewModel?.updateList()
    }
    
    func searchMovie(with text: String) {
        if text != lastSearchText {
            lastSearchText = text
            delegate?.searchMovie(with: text)
            
        }
    }
}

// MARK: - MovieSearchVCDelegate
extension MovieListViewController: MovieSearchVCDelegate {
    func selectedMovie(with id: Int) {
        let detailViewController = MovieDetailViewController()
        detailViewController.movieId = id
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
