//
//  BenzierViewController.swift
//  playground
//
//  Created by tree on 2019/3/7.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit

class BenzierViewController: SYViewController {
    
    let containerView: UIView = {
        let view = UIView.init()
        view.frame = CGRect.init(x: 0.0, y: 100.0, width: 100.0, height: 100.0)
        view.backgroundColor = UIColor.yellow
        view.layer.masksToBounds = true
        return view
    }()
    
    var waterLayer: CAShapeLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.containerView)
        self.waterWave(toView: containerView)
        self.startWaterWave()
    }
    
    func waterWave(toView: UIView) {
        let layer: CAShapeLayer = CAShapeLayer.init()
        layer.bounds = toView.bounds
        layer.position = CGPoint.zero
        layer.anchorPoint = CGPoint.zero
        
        func waterBenzier() -> CGPath {
            let w: Double = 100
            let h: Double = 100
            let extend: Double = 5
            let bezierFirst: UIBezierPath = UIBezierPath.init()
            
            let startOffY: Double = extend * Double(sinf(Float(0.0 * Double.pi * 2.0 / w)))
            
            var originOffY: Double = 0.0
            let path: CGMutablePath = CGMutablePath.init()
            path.move(to: CGPoint.init(x: 0, y: Int(startOffY)))
            
            bezierFirst.move(to: CGPoint.init(x: 0, y: Int(startOffY)))
            for i in stride(from: 0.0, to: w * 2.0, by: 0.1) {
                originOffY = extend * Double(sinf(Float(i * Double.pi * 2.0 / w))) + extend
                bezierFirst.addLine(to: CGPoint.init(x: i, y: originOffY))
            }
            bezierFirst.addLine(to: CGPoint.init(x: w * 2.0, y: originOffY))
            bezierFirst.addLine(to: CGPoint.init(x: w * 2.0, y: h))
            bezierFirst.addLine(to: CGPoint(x: 0, y: h))
            bezierFirst.addLine(to: CGPoint(x: 0, y: startOffY))
            bezierFirst.close()
            return bezierFirst.cgPath
        }
        layer.path = waterBenzier()
        layer.fillColor = UIColor.init(red: 34/255.0, green: 116/255.0, blue: 210/255.0, alpha: 1).cgColor
        containerView.layer.addSublayer(layer)
        self.waterLayer = layer
    }
    
    func startWaterWave() {
        let width: Double = 100.0
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.translation.x")
        animation.duration = 2.0
        animation.fromValue = NSNumber.init(value: 0.0)
        animation.toValue = NSNumber.init(value: -width)
        animation.repeatCount = MAXFLOAT
        animation.fillMode = kCAFillModeForwards
        self.waterLayer?.add(animation, forKey: "translation.x")
    }
}
