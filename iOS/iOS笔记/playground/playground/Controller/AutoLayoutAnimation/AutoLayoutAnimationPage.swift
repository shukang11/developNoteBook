//
//  AutoLayoutAnimationPage.swift
//  playground
//
//  Created by tree on 2018/10/8.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class AutoLayoutAnimationPage: SYViewController {
    private let square: UIView = {
        let o = UIView.init()
        return o
    }()
    
    private let aVi: AView = {
        let o = AView.init()
        o.frame = CGRect.init(x: 10.0, y: 10.0, width: 10.0, height: 10.0)
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.square.backgroundColor = UIColor.randomColor()
        self.view.addSubview(self.square)
        self.view.addSubview(self.aVi)
        
        self.square.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100.0, height: 100.0))
            make.center.equalToSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3.0, animations: { [weak self] in
            self?.square.snp.remakeConstraints({ (make) in
                make.size.equalTo(self?.view.frame.size ?? CGSize.zero)
            })
            self?.view.layoutIfNeeded()
            self?.square.backgroundColor = UIColor.randomColor()
        })
        
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now()+3.0) {
            UIView.animate(withDuration: 3.0, animations: { [weak self] in
                self?.square.snp.remakeConstraints({ (make) in
                    make.size.equalTo(CGSize.init(width: 100.0, height: 100.0))
                    make.top.equalToSuperview().offset(100.0)
                })
                self?.view.layoutIfNeeded()
                self?.square.backgroundColor = UIColor.randomColor()
            })
        }
        
        trade(trade: .Buy(stack: "APPL", amount: 100))
        trade(trade: .Sell(stack: "TSLA", amount: 100))
        let tower = Desktop.Tower(selectGPU(selectCPU(selectRAM((0, "", "")))))
        DLog(tower)
        
        
    }
    
    
    func trade(trade: Trade) {// 想访问这些值。需要用到匹配模式
        if case let Trade.Buy(stack, amount) = trade {
            DLog("buy \(stack)  \(amount)份")
        }else if case let Trade.Sell(stack, amount) = trade {
            DLog("sell \(stack)  \(amount)份")
        }
    }
    
    func selectRAM(_ config: Config) -> Config {
        return (RAM: 32, CPU: config.CPU, GPU: config.GPU)
    }
    
    func selectCPU(_ config: Config) -> Config {
        return (RAM: config.RAM, CPU: "3.2GHZ", GPU: config.GPU)
    }
    
    func selectGPU(_ config: Config) -> Config {return (RAM: config.RAM, CPU: "3.2GHZ", GPU: "NVidia")}
}

class AView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        DLog("AView layoutSubviews")
    }
}


public enum Trade {// 关联值
    case Buy(stack: String, amount: Int)
    case Sell(stack: String, amount: Int)
}

typealias Config = (RAM: Int, CPU: String, GPU: String)

enum Desktop {
    case Cube(Config)
    case Tower(Config)
    case Rack(Config)
}
