//
//  SSControl.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/16.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
private var block_key = 0

class _SSUIControlBlockTarget: NSObject {
    let block : (_ sender:AnyObject) ->()
    let events : UIControlEvents
    //这个关键字用来标记闭包的
    init(block:@escaping (_ sender : AnyObject)->(), events:UIControlEvents) {
        self.block = block
        self.events = events
        super.init()
    }
    
    func invokeMethod(sender:AnyObject) {
        block(sender);
    }
}

public extension UIControl {
    private var targets : NSMutableArray {
        get {
            var tempArray : NSMutableArray? = objc_getAssociatedObject(self, &block_key) as? NSMutableArray
            if (tempArray == nil || tempArray?.count == 0) {
                let ar = NSMutableArray()
                objc_setAssociatedObject(self, &block_key, ar, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                tempArray = ar
            }
            return tempArray!
        }
    }
    /// 移除所有事件
    private func removeAllTargets() {
        for object in self.allTargets {
            self.removeTarget(object, action: nil, for: UIControlEvents.allEvents)
        }
        self.targets.removeAllObjects()
    }
    /// 添加控件对事件的响应，避免代码分离
    public func addBlock(controlEvents : UIControlEvents, block:@escaping (_ sender:AnyObject)->()) {
        let target : _SSUIControlBlockTarget = _SSUIControlBlockTarget.init(block: block, events: controlEvents)
        self.addTarget(target, action: #selector(target.invokeMethod(sender:)), for: controlEvents)
        //若果没有这两句，那么会没有响应
        let targets : NSMutableArray = self.targets
        targets.add(target)
    }
    public func setBlock(controlEvents:UIControlEvents, block:@escaping (_ sender:AnyObject) ->()) {
        self.removeAllBlocksForControlEvents(events: controlEvents)
        self.addBlock(controlEvents: controlEvents, block: block)
    }
    public func removeAllBlocksForControlEvents(events:UIControlEvents) {
        let removes:NSMutableArray = NSMutableArray.init(capacity: 0)
        for target in self.targets {
            if (target as! _SSUIControlBlockTarget).events == events {
                self.removeTarget(target, action: #selector((target as! _SSUIControlBlockTarget).invokeMethod(sender:)), for: events)
            }else {
                self.removeTarget(target, action: #selector((target as! _SSUIControlBlockTarget).invokeMethod(sender:)), for: (target as! _SSUIControlBlockTarget).events)
                removes.add(target)
            }
        }
        targets.removeObjects(in: removes as [AnyObject])
    }
}
