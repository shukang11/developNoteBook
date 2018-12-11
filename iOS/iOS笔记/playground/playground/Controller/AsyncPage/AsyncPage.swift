//
//  AsyncPage.swift
//  playground
//
//  Created by tree on 2018/5/29.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class AsyncPage: SYViewController {
    //MARK:property
    
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
        let imageView = UIImageView.init()
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.margins.equalToSuperview()
        }
        let img = UIImage.init(named: "wallhaven-540738")
        imageView.image = img
//        img?.cornerImage(size: CGSize.init(width: self.view.width, height: self.view.height), radiu: 50.0, fillColor: UIColor.randomColor()) { (image) in
//            imageView.image = image?.copy() as? UIImage
//        }
        UIImage.imageBy(color: UIColor.randomColor(), size: CGSize.init(width: self.view.ss_width, height: self.view.ss_height)) { (image) in
            imageView.image = image
        }
    }
    
    //异步切圆角
    
}

fileprivate extension UIImage {
    func cornerImage(size: CGSize, radiu: CGFloat, fillColor: UIColor, completion: @escaping ((_ image: UIImage?) -> ())) -> Void {
        // 异步裁剪
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            let rect = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
            
            fillColor.setFill()
            UIRectFill(rect)
            
            let path = UIBezierPath.init(roundedRect: rect, cornerRadius: radiu)
            path.addClip()
            
            self.draw(in: rect)
            
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                completion(resultImage)
            }
        }
    }
    
    class func imageBy(color: UIColor, size: CGSize, completion: @escaping ((_ image: UIImage?) -> ())) {
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            let rect = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
            
            color.setFill()
            UIRectFill(rect)
            
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
