//
//  BaseCollectionViewCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        setupLayout()
    }
    
    /// Setup cell and its subviews here.
    open func setupViews() {
        backgroundColor = .white
    }
    
    /// Setup cell and its subviews autolayout here.
    open func setupLayout() {}
    
    
    final lazy var padding: CGFloat = {
        return 16
    }()
    
}

// MARK: - Reusable
extension BaseCollectionViewCell: Reusable {
    
    /// Reuse identifier _(default is type(of: self))_.
    public static var reuseIdentifier: String {
        return "\(type(of: self))"
    }
    
}
