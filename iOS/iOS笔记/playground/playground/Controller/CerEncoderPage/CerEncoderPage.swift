//
//  CerEncoderPage.swift
//  playground
//
//  Created by tree on 2018/6/6.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class CerEncoderPage: SYViewController {
    //MARK:property
    
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createUI()
       
        /*
         iOS非对称加密RSA（公钥解密）
         参考https://www.jianshu.com/p/3d24a74e72ae
         */
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        if let path = Bundle.main.path(forResource: "jmmapp", ofType: "cer"),
            let data = NSData.init(contentsOfFile: path) {
//            let caref = SecCertificateCreateWithData(nil, data),
            let content = String.init(data: data as Data, encoding: String.Encoding.unicode)
            print("\(content)")
        }
    }
    
}

