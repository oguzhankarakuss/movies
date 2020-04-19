//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieDetailViewController: BaseViewController {
    private let dataSource = MovieDetailDataSource()
    
    private var page = 1
    var movieId: Int? {
        didSet {
            getMovieDetail(with: self.movieId)
        }
    }
    
    private lazy var viewModel: MovieDetailViewModel? = {
        return MovieDetailViewModel(dataSource: self.dataSource)
    }()
    
    // MARK: - UI
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(style: .grouped,
                                      cells: [],
                                      separatorStyle: .singleLine)
        tableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: MovieDetailTableViewCell.identifier)
        tableView.register(MovieDetailSimilarMoviesTVCell.self, forCellReuseIdentifier: MovieDetailSimilarMoviesTVCell.identifier)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Detail"
        dataSource.viewController = self
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] (asd) in
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

extension MovieDetailViewController {
    final func getMovieDetail(with movieId: Int?) {
        if let movieId = self.movieId {
            viewModel?.getMovieDetail(with: movieId) { [weak self] in
                guard let self = self else { return }
                self.viewModel?.getSimilarMovies(with: movieId, page: self.page)
            }
        }
    }
}
