//
//  ViewHuggingPage.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

/// http://summertreee.github.io/blog/2015/12/13/contentcompressionresistancehe-contenthuggingxiang-jie/
class ViewHuggingPage: SYViewController {
    
    var stage: UIView = {
        let o = UIView.init()
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    var actor: UIView = {
        let o = UIView.init()
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    var backStage: UIView = {
        let o = UIView.init()
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stage)
        stage.addSubview(actor)
        self.view.addSubview(backStage)
        
        stage.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.backStage.snp.top)
        }
        
        actor.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 50.0, height: 50.0))
            make.center.equalToSuperview()
        }
        
        backStage.snp.makeConstraints { (make) in
            make.height.equalTo(240.0)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.right.equalToSuperview()
        }
        
        stage.setContentCompressionResistancePriority(.required, for: .vertical)
        stage.setContentHuggingPriority(.required, for: .vertical)
        
        // 在自动布局的前提下，会根据优先级保证actor视图在竖直方向上的布局
        actor.setContentHuggingPriority(.required, for: .vertical)
        actor.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
