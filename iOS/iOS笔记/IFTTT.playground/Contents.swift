import UIKit
import Foundation

protocol UniqueType {
    var identifier: UUID { get set }
}

typealias Value = Any

protocol ActionType: UniqueType { // 触发的动作 -> that
    func act(args: Value)
}

protocol TriggerType: UniqueType { // 触发器 -> this
    func judge(input: Value) -> Bool
}

// 负责绑定 Action 和 触发器
protocol ChannelType: UniqueType { // 关系 if ... then
    var trigger: TriggerType { get set }
    var action: ActionType { get set }
    
    func judge(input: Value) -> Bool
    func act(args: Value)
}

extension ChannelType {
    func judge(input: Value) -> Bool {
        return trigger.judge(input: input)
    }
    
    func act(args: Value) {
        action.act(args: args)
    }
}

protocol RecipeType {
    var channels: [ChannelType] { get set }
}

class Recipe: RecipeType {
    var channels: [ChannelType] = []
}

struct Trigger: TriggerType {
    var identifier: UUID = UUID()
    
    func judge(input: Value) -> Bool {
        guard let current = input as? Int else { return false }
        return current > 10
    }
}

struct Action: ActionType {
    var identifier: UUID = UUID()
    
    func act(args: Value) {
        print(args)
    }
}

struct Channel: ChannelType {
    
    var trigger: TriggerType
    var action: ActionType
    
    var identifier: UUID = UUID()
}

let trigger = Trigger()
let action = Action()

let channel = Channel(trigger: trigger, action: action, identifier: UUID())
let recipt = Recipe.init()
for i in stride(from: 0, to: 20, by: 2) {
    if channel.judge(input: i) {
        channel.act(args: i)
    }
}
