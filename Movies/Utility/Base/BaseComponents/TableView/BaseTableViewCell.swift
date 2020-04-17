//
//  BaseTableViewCell.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        setupLayout()
    }
    
    func setupViews() {
        selectionStyle = .none
    }
    
    func setupLayout() {}
    
    final lazy var padding: CGFloat = {
        return 16
    }()
    
}

// MARK: - Reusable
extension BaseTableViewCell: Reusable {
    
    /// Reuse identifier _(default is type(of: self))_.
    public static var reuseIdentifier: String {
        return "\(type(of: self))"
    }
    
}
