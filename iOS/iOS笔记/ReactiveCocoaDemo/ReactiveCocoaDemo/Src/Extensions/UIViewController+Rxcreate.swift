//
//  UIViewController+Rxcreate.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/28.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

func dismissViewController(_ viewController: UIViewController, animated: Bool) {
    if viewController.isBeingDismissed || viewController.isBeingPresented {
        DispatchQueue.main.async {
            dismissViewController(viewController, animated: animated)
        }
        return
    }
    if viewController.presentationController != nil {
        viewController.dismiss(animated: animated, completion: nil)
    }
}

extension Reactive where Base: UIImagePickerController {
    static func createWithParent(_ parent: UIViewController?, animated: Bool = true, configureImagePicker: @escaping (UIImagePickerController) throws -> () = { x in }) -> Observable<UIImagePickerController> {
        return Observable.create { [weak parent] observer in
            let imagePicker = UIImagePickerController()
            let dismissDisposable = imagePicker.rx
                .didCancel
                .subscribe(onNext: { [weak imagePicker] _ in
                    guard let imagePicker = imagePicker else {
                        return
                    }
                    dismissViewController(imagePicker, animated: animated)
                })
            
            do {
                try configureImagePicker(imagePicker)
            }
            catch let error {
                observer.on(.error(error))
                return Disposables.create()
            }
            
            guard let parent = parent else {
                observer.on(.completed)
                return Disposables.create()
            }
            
            parent.present(imagePicker, animated: animated, completion: nil)
            observer.on(.next(imagePicker))
            
            return Disposables.create(dismissDisposable, Disposables.create {
                dismissViewController(imagePicker, animated: animated)
            })
        }
    }
}

