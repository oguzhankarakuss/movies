//
//  BaseTableView.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    public convenience init(
        style: UITableView.Style = .plain,
        separatorStyle: UITableViewCell.SeparatorStyle = .none,
        separatorInset: UIEdgeInsets = .zero,
        contentInset: UIEdgeInsets = .zero,
        bounces: Bool = true,
        backgroundColor: UIColor? = .white) {
        
        self.init(style: style)
        self.separatorStyle = separatorStyle
        self.separatorInset = separatorInset
        self.contentInset = contentInset
        self.bounces = bounces
        self.tableFooterView = UIView()
        self.backgroundColor = backgroundColor
        self.estimatedRowHeight = 80
        self.rowHeight = UITableView.automaticDimension
        self.estimatedSectionHeaderHeight = 80
        self.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    required init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
