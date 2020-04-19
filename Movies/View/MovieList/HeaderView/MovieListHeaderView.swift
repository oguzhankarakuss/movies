//
//  MovieListHeaderView.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieListHeaderView: BaseView {
    
    convenience init(nowPlaying: [NowPlaying]? = nil,
                     isDataExist: Bool,
                     viewController: MovieListViewController? = nil) {
        self.init()
        if let nowPlaying = nowPlaying {
            pageController.isHidden = isDataExist
            titleLabel.isHidden = isDataExist
            self.dataSource.data.value = nowPlaying
        }
        
        if !isDataExist {
            viewModel?.nowPlaying(with: 1, completion: nil)
            self.dataSource.viewController = viewController
        }
    }
    var isDataExist = false
    private var dataSource = MovieListHeaderDataSource()
    private var nowPlaying: [NowPlaying]?
    var currentIndex: Int = 0 {
        didSet {
            configure()
        }
    }
    
    private lazy var viewModel: MovieListHeaderViewModel? = {
        return MovieListHeaderViewModel(dataSource: self.dataSource)
    }()
    
    //    MARK: - UI
    lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        
        let view = BaseCollectionView(layout: layout,
                                      cells: [HeaderCollectionViewCell.self],
                                      isPagingEnabled: true,
                                      showsVerticalScrollIndicator: false,
                                      showsHorizontalScrollIndicator: false,
                                      bounces: true)
        view.delegate = dataSource
        view.dataSource = dataSource
        return view
    }()
    
    private lazy var pageController: UIPageControl = {
       let view = UIPageControl()
        view.currentPageIndicatorTintColor = .white
        view.pageIndicatorTintColor = .gray
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var titleLabel: BaseLabel = {
        return BaseLabel(textAlignment: .center,
                         textColor: .white,
                         font: .systemFont(ofSize: 16),
                         backgroundColor: .clear)
    }()
    
    //    MARK: - Setups
    override func setupViews() {
        super.setupViews()
        addSubviews([collectionView,
                     pageController,
                     titleLabel])
        
        self.dataSource.headerView = self
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] (nowPlaying) in
            guard let self = self else { return }
            self.pageController.numberOfPages = nowPlaying.count
            self.nowPlaying = nowPlaying
            self.configure()
            self.collectionView.reloadData()
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        pageController.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(6)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(pageController.snp.top).offset(8)
          }
    }
}

// MARK: - Configure
private extension MovieListHeaderView {
    final func configure() {
        if let nowPlaying = self.nowPlaying, !nowPlaying.isEmpty {
            titleLabel.text = nowPlaying[currentIndex].title
            pageController.currentPage = currentIndex
        }
    }
}
