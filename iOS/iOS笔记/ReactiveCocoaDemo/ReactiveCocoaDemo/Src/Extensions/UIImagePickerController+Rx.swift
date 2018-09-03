//
//  UIImagePickerController+Rx.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/28.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
#if os(iOS)
    
    import RxCocoa
    import RxSwift
    import UIKit
    
    extension Reactive where Base: UIImagePickerController {
        public var didFinishPickingMediaWithInfo: Observable<[String: AnyObject]> {
            return delegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
                .map({ (a) in
                    return try castOrThrow(Dictionary<String, AnyObject>.self, a[1])
                })
        }
        
        public var didCancel: Observable<()> {
            return delegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
                .map({ (_) in })
        }
    }

#endif

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
