//
//  Merge_Two_Sorted_lists.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/13.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil && l2 ==  nil { return nil }
        guard let list1 = l1 else { return l2 }
        guard let list2 = l2 else { return l1 }
        var mergeNode: ListNode!
        if list1.val < list2.val {
            mergeNode = list1
            mergeNode.next = mergeTwoLists(list1.next, list2)
        }else {
            mergeNode = list2
            mergeNode.next = mergeTwoLists(list1, list2.next)
        }
        return mergeNode
    }
}
