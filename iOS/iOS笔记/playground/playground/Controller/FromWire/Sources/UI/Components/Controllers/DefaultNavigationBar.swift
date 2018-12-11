//
//  DefaultNavigationBar.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
import SSExteionComponents

class DefaultNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    func configure() {
        isTranslucent = false
        tintColor = UIColor.white
        barTintColor = UIColor.black
        setBackgroundImage(UIImage.singlePixelImage(UIColor.black), for: .default)
        shadowImage = UIImage.singlePixelImage(UIColor.clear)
        titleTextAttributes = DefaultNavigationBar.titleTextAttributes(for: UIColor.red)
        
        let backIndicatorInsets = UIEdgeInsets(top: 0, left: 4, bottom: 2.5, right: 0)
        backIndicatorImage = UIImage.singlePixelImage(UIColor.orange).image(backIndicatorInsets, backgroundColor: UIColor.clear)
        backIndicatorTransitionMaskImage = UIImage.singlePixelImage(UIColor.orange).image(backIndicatorInsets, backgroundColor: UIColor.clear)
    }
    
    static func titleTextAttributes(for color: UIColor) -> [NSAttributedString.Key : Any] {
        return [.font: UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.semibold),
                .foregroundColor: color,
                .baselineOffset: 1.0]
    }
}
