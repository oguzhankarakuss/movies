//
//  HeaderCollectionViewCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class HeaderCollectionViewCell: BaseCollectionViewCell {
    
    var nowPlayingContent: NowPlaying? {
        didSet {
            configure()
        }
    }
        
//    MARK: - UI
    private lazy var viewContainer: UIView = {
        return UIView()
    }()
    
    private lazy var movieImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    

    
//    MARK: - Setups
    override func setupViews() {
        super.setupViews()
        
        viewContainer.addSubviews([movieImageView])
        self.addSubview(viewContainer)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        viewContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        movieImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
// MARK: - Configure
private extension HeaderCollectionViewCell {
    final func configure() {
        if let content = nowPlayingContent {
            movieImageView.setImage(urlString: content.posterPath,
                                    placeholder: UIImage(named: "noImage"),
                                    nil)
        }
    }
}
