//
//  HUD.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 19.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit
import Lottie

class ProgressHUD: BaseView {
    
    lazy var loadingLottieAnimation: AnimationView = {
        let view = AnimationView(name: "loading")
        view.center = self.center
        view.contentMode = .scaleAspectFill
        view.animationSpeed = 2
        view.loopMode = .loop
        view.play()
        return view
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.96)
        addSubview(loadingLottieAnimation)
    }
    
    override func setupLayout() {
        loadingLottieAnimation.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(70)
        }
    }
}
