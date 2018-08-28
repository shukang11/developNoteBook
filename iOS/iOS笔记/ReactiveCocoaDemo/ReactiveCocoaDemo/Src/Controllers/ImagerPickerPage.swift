//
//  ImagerPickerPage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/28.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ImagePickerPage: SYViewController {
    let disposeBag: DisposeBag = DisposeBag()
    
    let imageView: UIImageView = {
        let o = UIImageView.init()
        o.contentMode = .scaleAspectFit
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    let gallery: UIButton = {
        let o = UIButton.init()
        o.setTitle("相册", for: .normal)
        o.setTitleColor(UIColor.randomColor(), for: .normal)
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.gallery)
        self.view.addSubview(self.imageView)
        
        self.gallery.snp.makeConstraints { (make) in
            make.center.width.equalTo(self.view)
        }
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp.topMargin)
            make.bottom.equalTo(self.gallery.snp.top)
        }
        
        setup()
    }
}


extension ImagePickerPage {
    func setup() -> Void {
        gallery.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                    }
                    .flatMap {
                        $0.rx.didFinishPickingMediaWithInfo
                    }
                    .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}

