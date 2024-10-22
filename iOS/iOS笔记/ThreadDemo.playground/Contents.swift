//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/// link:: http://www.cocoachina.com/ios/20171129/21362.html
/**
 GCD执行原理
 案例1
 结果： 死锁
 解读：
    先执行任务1，然后遇到了同步线程，等待任务2执行完成后执行任务3
    但这是队列，有任务来添加到队尾，先添加任务3，在添加任务2，由于FIFO原则，
    任务3要等任务2执行完成，任务2排在了任务3后，互相等待，造成死锁
 */
/**
print("1")// 任务1
DispatchQueue.main.sync {
    print("2")// 任务2
}
print("3")// 任务3
*/

class Quesstion: NSObject {
    @objc func didPlay(_ content: String) {
        print("\(content)")
    }
    
    func question2() {
        // 不要在主线程里再调主线程了
        self.didPlay("1")
        let global = DispatchQueue.global()
        global.async {
            self.perform(#selector(self.didPlay(_:)), with: "2", afterDelay: 1)
            self.didPlay("3")
            self.perform(#selector(self.didPlay(_:)), with: "4", afterDelay: 0)
        }
        self.didPlay("5")
    }
}

let q = Quesstion()
q.question2()

