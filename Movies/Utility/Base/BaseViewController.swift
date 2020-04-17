//
//  BaseViewController.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    final lazy var padding: CGFloat = {
        return 20
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    
    // MARK: - Setups
    func setupView() {}
    func setupLayout() {}
}
