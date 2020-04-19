//
//  BaseLabel.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    public convenience init(text:String? = nil,
                            textAlignment: NSTextAlignment = .natural,
                            numberOfLines: Int = 1,
                            textColor: UIColor? = .black,
                            font: UIFont? = nil,
                            minimumScaleFactor: CGFloat = 1.0,
                            lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                            backgroundColor: UIColor? = .white) {
        
        self.init()
        
        if let text = text {
            self.text = text
        }
        
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        
        if let aFont = font {
            self.setFont(textStyle: .headline, font: aFont)
        }
        
        if minimumScaleFactor < 1 {
            self.adjustsFontSizeToFitWidth = true
            self.minimumScaleFactor = minimumScaleFactor
        }
        
        self.lineBreakMode = lineBreakMode
        self.backgroundColor = backgroundColor
        
    }
    
}

