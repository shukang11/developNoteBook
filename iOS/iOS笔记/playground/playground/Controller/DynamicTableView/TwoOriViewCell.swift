//
//  TwoOriViewCell.swift
//  playground
//
//  Created by tree on 2018/11/2.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class TwoOriViewCell: UITableViewCell {
    lazy var titleLable: UILabel = {
        let o = UILabel.init()
        o.textColor = UIColor.randomColor()
        o.numberOfLines = 0
        return o
    }()
    
    lazy var view2: UIView = {
        let o = UIView.init()
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLable)
        self.contentView.addSubview(self.view2)
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.view2.snp.right)
            make.right.centerY.equalToSuperview()
        }
        
        self.view2.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(200.0)
            make.top.equalToSuperview().offset(10.0)
            make.bottom.equalToSuperview().offset(-20.0)
            make.height.equalTo(300.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
