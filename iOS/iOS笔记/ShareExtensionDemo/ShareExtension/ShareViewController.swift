//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by tree on 2018/6/26.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: UIViewController, UIWebViewDelegate {
    private var sharedTool: SharedProviderTool = {
        let o = SharedProviderTool.init()
        return o
    }()
    
    var session: URLSession = URLSession.init(configuration: URLSessionConfiguration.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        var responder = self
        
        guard let items: [NSExtensionItem] = self.extensionContext?.inputItems as? [NSExtensionItem] else { return }
        for item in items {
            guard let provides: [NSItemProvider] = item.attachments as? [NSItemProvider] else { return }
            for prov in provides {
                if prov.hasItemConformingToTypeIdentifier(kUTTypeFileURL as String) == true {
                    prov.loadItem(forTypeIdentifier: kUTTypeFileURL as String, options: nil, completionHandler: { (what, error) in
                        if let url:NSURL = what as? NSURL,
                            let data = NSData.init(contentsOf: url as URL) {
                            let shareDir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.audioExtension")
                            if let filepath = shareDir?.appendingPathComponent(url.lastPathComponent!) {
                                data.write(to: filepath, atomically: true)
                            }
                            if let filepath = shareDir?.appendingPathComponent("temp.m4a") {
                                data.write(to: filepath, atomically: true)
                            }
                            
                            self.didSelectPost()
                        }
                    })
                }
                if prov.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) == true {
                    prov.loadItem(forTypeIdentifier: kUTTypePropertyList as String, options: nil, completionHandler: { (what, error) in
                        print("\(what)")
                    })
                }
            }
        }
        
    }
    func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        if let context = self.extensionContext {
            print("\(context)")
        }
        return true
    }
    
    func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        self.extensionContext!.completeRequest(returningItems: []) { [unowned self] (succ) in
            self.sharedTool.open(URL.init(string: "treee://"), from: self)
        }
    }
    func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
}

