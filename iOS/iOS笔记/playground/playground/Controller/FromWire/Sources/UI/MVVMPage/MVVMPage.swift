//
//  MVVMPage.swift
//  playground
//
//  Created by tree on 2018/11/8.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

class MVVMPage: SYViewController {
    
    let disposeBage = DisposeBag()
    
    let viewModel = MVVMViewModel()
     
    var stage: UIView = {
        let o = UIView.init()
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    var label: UILabel = {
        let o = UILabel.init()
        o.numberOfLines = 0
        o.textColor = UIColor.randomColor()
        return o
    }()
    
    lazy var slider: UISlider = {
        let o = UISlider.init()
        o.maximumValue = 100.0
        o.value = 50.0
        return o
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(self.stage)
        view.addSubview(self.label)
        view.addSubview(self.slider)
        
        stage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.snp.topMargin)
            make.height.greaterThanOrEqualTo(20.0)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.stage.snp.bottom)
            make.bottom.lessThanOrEqualTo(self.slider.snp.top)
        }
        
        slider.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(50.0)
        }
        stage.setContentCompressionResistancePriority(.required, for: .vertical)
        
        slider.setContentCompressionResistancePriority(.required, for: .vertical)
        slider.setContentHuggingPriority(.required, for: .vertical)
        
        let title = Observable.just("title of MVVP").map({ $0.trimString })
        title.bind(to: self.navigationItem.rx.title).disposed(by: disposeBage)
        title.bind(to: self.label.rx.text).disposed(by: disposeBage)
    }
    
}
