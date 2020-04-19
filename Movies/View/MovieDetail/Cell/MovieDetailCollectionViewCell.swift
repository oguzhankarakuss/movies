//
//  MovieDetailCollectionView.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieDetailCollectionViewCell: BaseCollectionViewCell {
    
    var similarMovies: SimilarMovies? {
        didSet {
            configure()
        }
    }
    
    //    MARK: - UI
    private lazy var viewContainer: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: BaseLabel = {
        return BaseLabel(numberOfLines: 2,
                         textColor: .gray,
                         font: .systemFont(ofSize: 12),
                         minimumScaleFactor: 0.8)
    }()
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Setups
    override func setupViews() {
        super.setupViews()
        viewContainer.addSubviews([movieImageView,
                                   titleLabel])
        
        addSubview(viewContainer)
    }
    
    override func setupLayout() {
        super.setupLayout()
        viewContainer.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        movieImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(movieImageView.snp.bottom).offset(2)
        }
    }
}

// MARK: - Configure
private extension MovieDetailCollectionViewCell {
    final func configure() {
        if let similarMovies = self.similarMovies {
            movieImageView.setImage(urlString: similarMovies.posterPath,
                                    placeholder: UIImage(named: "noImage"), nil)
            titleLabel.text = similarMovies.title
        }
    }
}
