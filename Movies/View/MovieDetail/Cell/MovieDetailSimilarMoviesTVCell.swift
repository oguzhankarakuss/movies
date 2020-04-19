//
//  MovieDetailSimilarMoviesTVCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieDetailSimilarMoviesTVCell: BaseTableViewCell {

    var dataSource: MovieDetailDataSource? {
        didSet {
            if let dataSource = self.dataSource {
                collectionView.delegate = dataSource
                collectionView.dataSource = dataSource
                collectionView.reloadData()
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                            at: .left,
                                            animated: true)
            }
        }
    }
    
    //    MARK: - UI
    private lazy var viewContainer: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: BaseLabel = {
        return BaseLabel(text: "Similar Movies",
                         numberOfLines: 1,
                         textColor: .gray,
                         font: .systemFont(ofSize: 18))
    }()
    
    lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: 80, height: 120)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero
        
        let view = BaseCollectionView(layout: layout,
                                      cells: [MovieDetailCollectionViewCell.self],
                                      showsVerticalScrollIndicator: false,
                                      showsHorizontalScrollIndicator: false)
        return view
    }()
    
    // MARK: - Setups
    override func setupViews() {
        super.setupViews()
        viewContainer.addSubviews([titleLabel,
                                   collectionView])
        
        addSubview(viewContainer)
    }
    
    override func setupLayout() {
        super.setupLayout()
        viewContainer.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
}

// MARK: - Identifier
extension MovieDetailSimilarMoviesTVCell {
    static var identifier: String {
        return "MovieDetailSimilarMoviesTVCell"
    }
}
