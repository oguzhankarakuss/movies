//
//  Extensions.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - UIWindow
extension UIWindow {
    
    /// Create a UIWindow and set its rootViewController in one line.
    ///
    /// - Parameter rootViewController: The root view controller for the window.
    ///   - backgroundColor: window's background color _(default is .black)_.
    public convenience init(rootViewController: UIViewController, backgroundColor: UIColor? = .black) {
        self.init()
        
        self.rootViewController = rootViewController
        self.backgroundColor = backgroundColor
        self.makeKeyAndVisible()
    }
    
    /// Switch current root view controller with a new view controller.
    ///
    /// - Parameters:
    ///   - viewController: new view controller.
    ///   - animated: set to true to animate view controller change _(default is true)_.
    ///   - duration: animation duration in seconds _(default is 0.5)_.
    ///   - options: animataion options _(default is .transitionFlipFromRight)_.
    ///   - completion: optional completion handler called when view controller is changed.
    public func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionFlipFromRight,
        _ completion: (() -> Void)? = nil) {
        
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
    
}

// MARK: - UILabel
extension UILabel {
    
    /// Set label's accessibility font size.
    /// - Parameters:
    ///   - textStyle: Text style of the label.
    ///   - font: Font type of the label.
    func setFont(textStyle: UIFont.TextStyle, font: UIFont) {
        if #available(iOS 11.0, *) {
            self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        } else {
            self.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
        adjustsFontForContentSizeCategory = true
    }
    
}

// MARK: - UIImageView
extension UIImageView {
    
    /// Set image view's image by using kingfisher.
    ///
    /// - Parameters:
    ///   - url: url of the image.
    ///   - placeholder: placeholder image of the image view.
    func setImage(urlString: String?, placeholder: UIImage? = nil, _ completion: ((_ image: UIImage?) -> Void)? = nil) {
        guard let urlStr = urlString, let aUrl = URL(string: urlStr) else {
            image = placeholder
            return
        }
        guard let imageURL = URL(string:"\(ServiceConstants.ProductionServer.imageBaseURL)\(aUrl.absoluteString)") else {
            image = placeholder
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
        
        kf.setImage(with: imageURL) { (result) in
            switch result {
            case .failure(_):
                activityIndicator.stopAnimating()
                self.image = placeholder
            case .success(let response):
                activityIndicator.stopAnimating()
                self.image = response.image
            }
        }
    }
    
}

// MARK: - UIView
extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}

// MARK: - UIViewController - UIAlertController
extension UIViewController {
    @discardableResult func presentAlert(
        title: String? = "Oopss :(",
        message: String? = "An unexpected error has occurred.",
        preferredStyle: UIAlertController.Style = .alert,
        tintColor: UIColor? = nil,
        actions: [UIAlertAction] = [],
        animated: Bool = true,
        completion: (() -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if actions.isEmpty {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
        }
        
        for action in actions {
            alert.addAction(action)
        }
        
        if let color = tintColor {
            alert.view.tintColor = color
        }
        
        present(alert, animated: animated, completion: completion)
        
        if let color = tintColor {
            alert.view.tintColor = color
        }
        
        return alert
    }
    
}
