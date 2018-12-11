//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import CoreGraphics
import CoreImage
import CoreText

class MyViewController : UIViewController {
    var contentHeight: Float = 0.0
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    override func loadView() {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 0, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        
        contentHeight += 20
        self.view = view
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let coreV1 = CoreView1.init(frame: CGRect.init(x: 0.0, y: Double(contentHeight), width: Double(width), height: 100.0))
        view.addSubview(coreV1)
        contentHeight += 100.0
        
        let coreV2 = CoreView2.init(frame: CGRect.init(x: 0.0, y: Double(contentHeight), width: Double(width), height: 100.0))
        view.addSubview(coreV2)
        contentHeight += 100.0
        
        let coreV3 = CoreView3.init(frame: CGRect.init(x: 0.0, y: Double(contentHeight), width: Double(width), height: 100.0))
        view.addSubview(coreV3)
        contentHeight += 100.0
        
        (self.view as! UIScrollView).contentSize = CGSize.init(width: self.view.frame.width, height: max(CGFloat(contentHeight), self.view.frame.height))
    }
}

// swift
class CoreView1: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // 只有在drawrect方法中才能拿到上下文
        let context = UIGraphicsGetCurrentContext()
        context?.addRect(rect)
        context?.setFillColor(UIColor.red.cgColor)
        context?.fill(rect)
        super.draw(rect)
    }
}


class CoreView2: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext() // 创建一个画布
        let path = CGMutablePath.init()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint.init(x: rect.width-10.0, y: rect.height))
        context?.addPath(path)
        
        context?.setStrokeColor(UIColor.green.cgColor) // 定义画笔颜色
        context?.setFillColor(UIColor.red.cgColor) // 填充色
        context?.setLineWidth(6.0)
        context?.setLineCap(.butt) // 连接点样式
        let lengths: [CGFloat] = [18, 9, 9, 9, 18, 9, 9, 9]// 虚线样式
        context?.setLineDash(phase: 0, lengths: lengths)
        context?.setShadow(offset: CGSize.init(width: 2.0, height: 2.0), blur: 0)
        context?.drawPath(using: .fillStroke)// 填充类型
    }
}

class CoreView3: UIView {
    // 绘制文字
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState() //
        // 翻转坐标系
        context?.textMatrix = CGAffineTransform.identity
        context?.ctm.translatedBy(x: 0.0, y: rect.size.height)
        context?.ctm.scaledBy(x: 1.0, y: -1.0)
        
        // 设置CTFramesetter
        let attr: CFDictionary = [NSMutableAttributedString.Key.foregroundColor: UIColor.red] as! CFDictionary
        let text = CFAttributedStringCreate(nil, "1111" as CFString, attr)
        
        
        let line = CTLineCreateWithAttributedString(text ?? "" as! CFAttributedString)
        
        let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.useOpticalBounds)
        
        context?.setLineWidth(1.5)
        
        context?.setTextDrawingMode(.stroke)
        
        let xn = bounds.width/2.0;
        let yn = bounds.height/2.0;
        
        context?.textPosition = CGPoint.init(x: xn, y: yn)
        
        CTLineDraw(line, context!)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
