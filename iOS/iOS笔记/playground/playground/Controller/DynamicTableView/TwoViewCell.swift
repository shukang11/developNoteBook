//
//  TwoViewCell.swift
//  playground
//
//  Created by tree on 2018/11/2.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
class TwoViewCell: UITableViewCell {
    lazy var firstLabel: UILabel = {
        let o = UILabel.init()
        o.textColor = UIColor.randomColor()
        o.numberOfLines = 0
        return o
    }()
    
    lazy var secondLabel: UILabel = {
        let o = UILabel.init()
        o.textColor = UIColor.randomColor()
        o.numberOfLines = 0
        return o
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.firstLabel)
        self.contentView.addSubview(self.secondLabel)
        self.firstLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20)
        }
        self.secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.firstLabel.snp.bottom).offset(120.5)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20)
             // key code
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
