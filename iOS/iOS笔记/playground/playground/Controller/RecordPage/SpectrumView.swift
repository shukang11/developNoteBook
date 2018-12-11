//
//  SpectrumView.swift
//  NlsRealTalk
//
//  Created by tree on 2018/7/18.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

// 布局方式
public enum SpectrumLayoutSide {
    case both // 向两边扩散
    case left // 向左扩散
    case right // 向右扩散
}

public class SpectrumView: UIView {
    /// 线条宽度
    public var lineWidth: Float = 10.0 {
        willSet { self.updateLines() }
    }
    
    /// 线条的间隔
    public var lineSpace: Float = 10 {
        willSet { self.updateLines() }
    }
    
    /// 布局方式
    public var layoutSide: SpectrumLayoutSide = .both {
        willSet { self.updateLines() }
    }
    public var lineColor: UIColor = UIColor.blue {
        willSet { self.updateLines() }
    }
    
    /// 中间的间隔
    public var middlePadding: Float = 40.0 {
        willSet { self.updateLines() }
    }
    
    /// 最大条数
    public var maxLineCount: Int = 100 {
        willSet { self.updateLines() }
    }
    
    private var lineLayers: [CAShapeLayer] = []
    
    private var levels: [NSNumber] = []
    
    private var displayLink: CADisplayLink?
    
    
    //MARK:lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-
    //MARK:method
    func setUp() -> Void {}
    /// 开始
    func start() -> Void {}
    
    func append(_ value: Float) -> Void {
        self.levels.insert(NSNumber.init(value: value), at: 0)
        self.lineLayers.insert(self.getLineLayer(), at: 0)
        if self.maxLineCount > 0 &&
            self.levels.count > self.maxLineCount {
            let _ = self.levels.removeLast()
            let _ = self.lineLayers.removeLast()
        }
        self.updateLines()
    }
    /// 结束
    func stop() -> Void {
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
   
}
// 工厂方法
extension SpectrumView {
    func getLineLayer() -> CAShapeLayer {
        let line = CAShapeLayer.init()
        line.lineCap = kCALineCapButt
        line.lineJoin = kCALineJoinRound
        line.strokeColor = UIColor.clear.cgColor
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = self.lineColor.cgColor
        line.lineWidth = CGFloat(self.lineWidth)
        return line
    }
}

extension SpectrumView {
    //MARK:layout
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func updateLines() -> Void {
        let height = self.bounds.height
        let width = self.bounds.width
        let centerY = height * 0.5 // 垂直中
        let centerX = width * 0.5 //  水平中
        
        var beginOffset = CGFloat(self.middlePadding) // 初始间隔
        let _beginOX = CGFloat(self.middlePadding)
        if let layers = self.layer.sublayers {
            for l in layers {
                l.removeFromSuperlayer()
            }
        }
        guard self.levels.count > 0 else {
            return
        }
        
        for index in 0...self.levels.count - 1 {
            let level = self.levels[index]
            
            let lineHeight = CGFloat(min(max(level.floatValue, 0), Float(height)))
            let pathTop = max(centerY - lineHeight * 0.5, centerY - height * 0.5)
            let pathBottom = min(centerY + lineHeight * 0.5, centerY + lineHeight * 0.5)
            let pathLeftX = centerX - beginOffset
            let pathRightX = centerX + beginOffset
            // 左边
            if self.layoutSide != .right {
                if index == 0 {
                    let px = centerX-_beginOX
                    self.addPointLayer(pointOrigin: CGPoint.init(x: px, y: 15), width: 4, color: self.lineColor)
                    self.addPointLayer(pointOrigin: CGPoint.init(x: px, y: height-15.0), width: 4, color: self.lineColor)
                    self.addLineLayer(pathX: px, pathTop: 15.0, pathBottom: height-15.0)
                }
                self.addLineLayer(pathX: pathLeftX, pathTop: pathTop, pathBottom: pathBottom)
            }
            
            // 右边
            if self.layoutSide != .left {
                if index == 0 {
                    let px = centerX+_beginOX
                    self.addPointLayer(pointOrigin: CGPoint.init(x: px, y: 15), width: 4, color: self.lineColor)
                    self.addPointLayer(pointOrigin: CGPoint.init(x: px, y: height-15.0), width: 4, color: self.lineColor)
                    self.addLineLayer(pathX: px, pathTop: 15.0, pathBottom: height-15.0)
                }
                self.addLineLayer(pathX: pathRightX, pathTop: pathTop, pathBottom: pathBottom)
            }
            beginOffset += CGFloat(self.lineWidth) + CGFloat(self.lineSpace)
            if centerX - beginOffset  < 0 { break }
        }
    }
    
    private func addLineLayer(pathX: CGFloat, pathTop: CGFloat, pathBottom: CGFloat) {
        let path = UIBezierPath.init()
        let line = self.getLineLayer()
        path.move(to: CGPoint.init(x: pathX, y: pathTop))
        path.addLine(to: CGPoint.init(x: pathX, y: pathBottom))
        line.path = path.cgPath
        self.layer.addSublayer(line)
    }
    private func addPointLayer(pointOrigin: CGPoint, width: CGFloat, color: UIColor) {
        let hw = width/2.0
        let pathP = UIBezierPath.init(roundedRect: CGRect.init(x: pointOrigin.x-hw, y: pointOrigin.y-hw, width: width, height: width), cornerRadius: hw)
        let l = CAShapeLayer.init()
        l.fillColor = self.lineColor.cgColor
        l.path = pathP.cgPath
        self.layer.addSublayer(l)
    }
    
}
