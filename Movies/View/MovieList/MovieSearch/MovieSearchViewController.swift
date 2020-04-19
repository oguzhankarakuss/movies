//
//  MovieSearchViewController.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 19.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

protocol MovieSearchVCDelegate: class {
    func selectedMovie(with id: Int)
}

final class MovieSearchViewController: BaseViewController {
    
    convenience init(movieListViewController: MovieListViewController) {
        self.init()
        self.movieListViewController = movieListViewController
    }
    weak var delegate: MovieSearchVCDelegate?
    private var movieListViewController: MovieListViewController?
    private let dataSource = MovieSearchDataSource()
    var lastSearchText = ""
    
    private lazy var viewModel: MovieSearchViewModel? = {
        return MovieSearchViewModel(dataSource: self.dataSource)
    }()
    
    // MARK: - UI
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(cells: [MovieSearchTableViewCell.self],
                                      separatorStyle: .singleLine)
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListViewController?.delegate = self
        dataSource.viewController = self
        dataSource.delegate = self
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
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

// MARK: - MovieSearchDelegate
extension MovieSearchViewController: MovieSearchDelegate {
    func selectedMovie(with id: Int) {
        delegate?.selectedMovie(with: id)
    }
    
    func updateList() {
        viewModel?.updateList(with: lastSearchText)
    }
}

// MARK: - MovieListViewControllerDelegate
extension MovieSearchViewController: MovieListViewControllerDelegate {
    func reset() {
        viewModel?.reset()
    }
    
    func searchMovie(with text: String) {
        lastSearchText = text
        viewModel?.isUpdating = false
        viewModel?.searchMovie(with: text)
    }
}
