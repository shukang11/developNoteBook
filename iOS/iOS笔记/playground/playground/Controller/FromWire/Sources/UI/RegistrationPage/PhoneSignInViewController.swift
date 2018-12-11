//
//  PhoneSignInViewController.swift
//  playground
//
//  Created by tree on 2018/11/22.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class PhoneSignInViewController: UIViewController {
    var contentLabel: UILabel = {
        let o = UILabel.init()
        o.font = UIFont.largeLightFont
        o.textColor = UIColor.white
        return o
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createContentLabel()
        self.createConstraints()
    }
}

extension PhoneSignInViewController {
    func createContentLabel() {
        view.addSubview(self.contentLabel)
    }

    func createConstraints() {
        self.contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
