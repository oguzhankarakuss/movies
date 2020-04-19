//
//  MovieListTableViewCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieListTableViewCell: BaseTableViewCell {
    
    var upcomingContent: MovieList? {
        didSet {
            configure()
        }
    }
    
//    MARK: - UI
    private lazy var viewContainer: UIView = {
        return UIView()
    }()
    
    private lazy var titleLabel: BaseLabel = {
        return BaseLabel(font: .boldSystemFont(ofSize: 16))
    }()
    
    private lazy var descriptionLabel: BaseLabel = {
        return BaseLabel(numberOfLines: 2,
                         textColor: .gray,
                         font: .systemFont(ofSize: 14))
    }()
    
    private lazy var dateLabel: BaseLabel = {
        return BaseLabel(textAlignment: .right,
                         numberOfLines: 1,
                         textColor: .gray,
                         font: .systemFont(ofSize: 12))
    }()
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var navImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "navIcon"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var labelStackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        view.spacing = 6
        view.distribution = .fill
        view.axis = .vertical
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [movieImageView,
                                                 labelStackView,
                                                 navImageView])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 8
        return view
    }()
    
//    MARK: - Setups
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        viewContainer.addSubview(stackView)
        viewContainer.addSubview(dateLabel)
        addSubview(viewContainer)
    }
    
    override func setupLayout() {
        super.setupLayout()
        viewContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(padding)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(6)

        }
        
        movieImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
        }
        
        navImageView.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(34)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
}
// MARK: - Configure
private extension MovieListTableViewCell {
    final func configure() {
        if let content = upcomingContent {
            titleLabel.text = content.title
            descriptionLabel.text = content.overview
            dateLabel.text = content.releaseDate
            movieImageView.setImage(urlString: content.backdropPath,
                                    placeholder:UIImage(named: "noImage"),
                                    nil)
        }
    }
}
