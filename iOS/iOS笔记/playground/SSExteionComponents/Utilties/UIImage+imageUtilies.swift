//
//  UIImage+imageUtilies.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

public extension UIImage {
    
    /// create a image with one pixel filled by color
    static func singlePixelImage(_ color: UIColor) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    /// scale a image by scaleFactory
    public func imageScale(_ scaleFactory: CGFloat) -> UIImage {
        let size = __CGSizeApplyAffineTransform(self.size, CGAffineTransform.init(scaleX: scaleFactory, y: scaleFactory))
        let scale: CGFloat = 0.0
        
        let hasAlpha = false
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        let scaledImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let s = scaledImg { return s }
        return self
    }
    
    /// desaturated a image
    public func desaturated(_ context: CIContext, sturation: NSNumber) -> UIImage {
        let i = CIImage.init(image: self)
        let filter = CIFilter.init(name: "CIColorControls")
        filter?.setValue(i, forKey: kCIInputImageKey)
        filter?.setValue(sturation, forKey: "InputSaturation")
        if let result: CIImage = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let img = UIImage.init(ciImage: result)
            return img
        }
        return self
    }
    
    /// fill color to image
    public func image(color: UIColor) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: self.size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        self.draw(in: rect)
        color.setFill()
        UIRectFillUsingBlendMode(rect, .sourceAtop)
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            return img
        }
        return self
    }
    
    public static func image(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        if let img = UIGraphicsGetImageFromCurrentImageContext() {
            return img
        }
        return nil
    }
    
    /// scale image with insets, fill space with backgroundColor
    public func image(_ insets: UIEdgeInsets, backgroundColor: UIColor) -> UIImage {
        
        let newSize = CGSize.init(width: self.size.width + insets.left + insets.right, height: self.size.height + insets.top + insets.bottom)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        backgroundColor.setFill()
        UIRectFill(CGRect.init(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height))
        self.draw(in: CGRect.init(x: insets.left, y: insets.top, width: self.size.width, height: self.size.height))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    // make self to a blur image 
    public func blurredImage(_ context: CIContext, blurRadius: CGFloat) -> UIImage {
        var outImg = CIImage.init(image: self)
        
        let extent = outImg?.extent
        
        let blurFilter = CIFilter.init(name: "CIGaussianBlur")
        blurFilter?.setValue(NSNumber.init(value: Float(blurRadius)), forKey: kCIInputRadiusKey)
        blurFilter?.setValue(outImg, forKey: kCIInputImageKey)
        outImg = blurFilter?.outputImage
        if let e = extent {
            outImg?.cropped(to: e)
        }
        if let o = outImg {
            return UIImage.init(ciImage: o, scale: scale, orientation: self.imageOrientation)
        }
        return self
    }
    
    public static func shadowImage(_ inset: CGFloat, color: UIColor) -> UIImage? {
        let middleSize: CGFloat = 10.0
        let rect = CGRect.init(x: 0.0, y: 0.0, width: Double(ceilf(Float(inset * 2.0))), height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect.init(x: inset, y: 0.0, width: middleSize, height: 1.0))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        return img
    }
    
}
