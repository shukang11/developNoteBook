//
//  UINavigationBarContainer.swift
//  playground
//
//  Created by tree on 2018/11/29.
//  Copyright © 2018 treee. All rights reserved.
//

import UIKit
import SnapKit

class UINavigationBarContainer: UIViewController {

    let landscapeTopMargin: CGFloat = 20.0
    let landscapeNavbarHeight: CGFloat = 30.0
    let portraitNavbarHeight: CGFloat = 44.0

    var navigationBar: UINavigationBar

    init(_ navigationBar: UINavigationBar) {
        self.navigationBar = navigationBar
        super.init(nibName: nil, bundle: nil)
        super.view.addSubview(navigationBar)
        self.view.backgroundColor = UIColor.white
        createConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createConstraints() {
        self.navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(portraitNavbarHeight)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let orientation = UIApplication.shared.statusBarOrientation
        let deviceType = UIDevice.current.userInterfaceIdiom


        self.navigationBar.snp.updateConstraints {
            if orientation.isLandscape && deviceType == .phone {
                $0.height.equalTo(landscapeNavbarHeight)
            }else {
                $0.height.equalTo(portraitNavbarHeight)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

