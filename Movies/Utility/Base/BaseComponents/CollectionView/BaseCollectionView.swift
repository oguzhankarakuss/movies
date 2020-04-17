//
//  BaseCollectionView.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    public convenience init(
        layout: UICollectionViewLayout,
        cells: [BaseCollectionViewCell.Type],
        allowsSelection: Bool = true,
        allowsMultipleSelection: Bool = false,
        isPagingEnabled: Bool = false,
        showsVerticalScrollIndicator: Bool = true,
        showsHorizontalScrollIndicator: Bool = true,
        scrollIndicatorInsets: UIEdgeInsets = .zero,
        bounces: Bool = true,
        backgroundColor: UIColor? = .white) {
        
        self.init(frame: .zero, collectionViewLayout: layout)
        
        for cell in cells {
            register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
        }
        
        self.allowsSelection = allowsSelection
        self.allowsMultipleSelection = allowsMultipleSelection
        self.isPagingEnabled = isPagingEnabled
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.scrollIndicatorInsets = scrollIndicatorInsets
        self.bounces = bounces
        
        self.backgroundColor = backgroundColor
    }
}
