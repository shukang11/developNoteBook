//
//  ScrollHeaderView.swift
//  playground
//
//  Created by tree on 2018/6/4.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class ScrollHeaderView: UIView {
    
    var imageView: UIImageView = {
        let o = UIImageView.init()
        o.contentMode = .scaleAspectFit
        return o
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(image: UIImage?) -> Void {
        self.imageView.image = image
    }
}
