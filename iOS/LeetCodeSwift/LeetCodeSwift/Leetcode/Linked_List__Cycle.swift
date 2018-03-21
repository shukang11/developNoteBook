//
//  Linked_List__Cycle.swift
//  LeetCodeSwift
//
//  Created by tree on 2018/3/20.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

extension Solution {
    
    /**
     我们设置快慢两个游标，两个游标速度不同
     如果是链表中含有环的话，那么两个指针肯定会最终相等
     */
    func has_cycle(_ head: ListNode) -> Bool {
        var slow: ListNode? = head
        var fast: ListNode? = head
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            if slow! == fast! { return true }
        }
        return false
    }
}
