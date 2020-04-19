//
//  MovieDetailTableViewCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieDetailTableViewCell: BaseTableViewCell {
    
    var movieDetail: MovieDetail? {
        didSet {
            configure()
        }
    }
    
    //    MARK: - UI
    private lazy var viewContainer: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: BaseLabel = {
        return BaseLabel(font: .boldSystemFont(ofSize: 18))
    }()
    
    private lazy var descriptionLabel: BaseLabel = {
        return BaseLabel(numberOfLines: 0,
                         textColor: .gray,
                         font: .systemFont(ofSize: 14))
    }()
    
    private lazy var bottomViewContainer: UIView = {
        return UIView()
    }()
    
    private lazy var starImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "star"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var rateLabel: BaseLabel = {
        return BaseLabel(textColor: .gray,
                         font: .systemFont(ofSize: 14))
    }()
    
    private lazy var dateLabel: BaseLabel = {
        return BaseLabel(textColor: .gray,
                         font: .systemFont(ofSize: 14))
    }()
    
    private lazy var imdbButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "imdb"), for: .normal)
        button.addTarget(self,
                         action: #selector(imdbButtonTapped(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var starImageViewContainer: UIView = {
        return UIView()
    }()
    
    //     MARK: - Setups
    override func setupViews() {
        super.setupViews()
        viewContainer.addSubviews([titleLabel,
                                   descriptionLabel,
                                   bottomViewContainer])
        
        starImageViewContainer.addSubviews([starImageView,
                                            rateLabel])
        
        bottomViewContainer.addSubviews([starImageViewContainer,
                                         dateLabel,
                                         imdbButton])
        
        addSubview(viewContainer)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        viewContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(padding)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        bottomViewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        starImageViewContainer.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
        }
        
        imdbButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(starImageViewContainer.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        
        rateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(starImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
        }
    }
}

private extension MovieDetailTableViewCell {
    
    final func configure() {
        if let movieDetail = self.movieDetail {
            titleLabel.text = movieDetail.title
            descriptionLabel.text = movieDetail.overview
            dateLabel.text = movieDetail.releaseDate
            if let voteAverage = movieDetail.voteAverage {
                rateLabel.text = "\(voteAverage)"
            }
        }
    }
    
    @objc final func imdbButtonTapped(_ sender: UIButton) {
        if let imdbId = movieDetail?.imdbID, let url = URL(string: ServiceConstants.ProductionServer.imdbBaseUrl + imdbId) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
// MARK: - Identifier
extension MovieDetailTableViewCell {
    static var identifier: String {
        return "MovieDetailTableViewCell"
    }
}
