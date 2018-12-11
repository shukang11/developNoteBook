//
//  BlurPage.swift
//  playground
//
//  Created by tree on 2018/4/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
import SSExteionComponents

class BlurPage: SYViewController {
    //MARK:property
    var imageView: UIImageView = {
        let o = UIImageView()
        o.contentMode = .scaleToFill
        return o
    }()
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createUI()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        let alpha: CGFloat = 0.99
        DispatchQueue.main.async {
            self.imageView.image = UIImage.init(named: "wallhaven-540738")?.blurredImage(CIContext.init()
                , blurRadius: 5.0)
        }
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.margins.equalToSuperview()
        }
        // ios7
//        let toolbar: UIToolbar = UIToolbar.init()
//        toolbar.barStyle = .blackTranslucent
//        imageView.addSubview(toolbar)
//        toolbar.snp.makeConstraints { (make) in
//            make.left.top.bottom.equalToSuperview()
//            make.width.equalTo(imageView).multipliedBy(0.5)
//        }
        
        let lightEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .light))
        lightEffectView.alpha = alpha
        imageView.addSubview(lightEffectView)
        lightEffectView.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.width.equalTo(imageView).multipliedBy(0.5)
            make.height.equalTo(imageView).multipliedBy(0.2)
        }
        
        let extraLightEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .extraLight))
        extraLightEffectView.alpha = alpha
        imageView.addSubview(extraLightEffectView)
        extraLightEffectView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(lightEffectView.snp.bottom)
            make.width.equalTo(imageView).multipliedBy(0.5)
            make.height.equalTo(imageView).multipliedBy(0.2)
        }
        
        let darkEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
        darkEffectView.alpha = alpha
        imageView.addSubview(darkEffectView)
        darkEffectView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(extraLightEffectView.snp.bottom)
            make.width.equalTo(imageView).multipliedBy(0.5)
            make.height.equalTo(imageView).multipliedBy(0.2)
        }
        
        if #available(iOS 10.0, *) {
            let prominentEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .prominent))
            prominentEffectView.alpha = alpha
            imageView.addSubview(prominentEffectView)
            prominentEffectView.snp.makeConstraints { (make) in
                make.right.equalToSuperview()
                make.top.equalTo(darkEffectView.snp.bottom)
                make.width.equalTo(imageView).multipliedBy(0.5)
                make.height.equalTo(imageView).multipliedBy(0.2)
            }
        }
        
        if #available(iOS 10.0, *) {
            let regularEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .regular))
            regularEffectView.alpha = alpha
            imageView.addSubview(regularEffectView)
            regularEffectView.snp.makeConstraints { (make) in
                make.right.bottom.equalToSuperview()
                make.width.equalTo(imageView).multipliedBy(0.5)
                make.height.equalTo(imageView).multipliedBy(0.2)
            }
        }
        
    }
}
