//
//  ItemDetailPageCells.swift
//  playground
//
//  Created by tree on 2018/6/4.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class ScrollHeaderCell: UITableViewCell {
    var headerView: ScrollHeaderView = {
        let o = ScrollHeaderView.init(frame: CGRect.zero)
        return o
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
