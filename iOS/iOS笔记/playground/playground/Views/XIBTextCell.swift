//
//  XIBTextCell.swift
//  playground
//
//  Created by tree on 2018/11/2.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class XIBTextCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
