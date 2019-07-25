import Foundation

typealias Value = Any
protocol UniqueType {
    var identifier: UUID { get set }
}

protocol TaskType: class, UniqueType {
    var delegate: TaskDelegate? { get set }
    
    func start(input: Value) throws
    func done(output: Value)
}

protocol TaskDelegate: class {
    func task(willStart task: TaskType, input: Value)
    func task(didDone task: TaskType, output: Value)
}

protocol TaskManagerDelegate: class {
    func willStart(manager: TaskChain, task: TaskType, input: Value) -> Bool
    func done(manager:TaskChain, task: TaskType, output: Value) -> Value?
    func onError(manager: TaskChain, task: TaskType, error: Error)
}

enum TaskOptionOnError {
    case cancel
    case ignore
}

class TaskChain {
    private(set) var tasks: [TaskType] = []
    
    private var optionOnError: TaskOptionOnError = .cancel
    
    weak var delegate: TaskManagerDelegate?
    
    var index: Int = 0
    
    private func fetchTask() -> TaskType? {
        guard tasks.isEmpty == false else { return nil }
        guard index < tasks.count else { return nil }
        let task = tasks[index]
        index += 1
        return task
    }
    
    func start(input: Value) {
        guard let task = self.fetchTask() else { return }
        self.task(willStart: task, input: input)
        task.delegate = self
        do {
            try task.start(input: input)
        } catch {
            switch optionOnError {
            case .cancel:
                self.delegate?.onError(manager: self, task: task, error: error)
                return
            case .ignore:
                self.start(input: input)
            }
        }
    }
    
    func insert(task: TaskType) {
        tasks.append(task)
    }
}

extension TaskChain: TaskDelegate {
    func task(willStart task: TaskType, input: Value) {
        delegate?.willStart(manager: self, task: task, input: input)
    }
    
    func task(didDone task: TaskType, output: Value) {
        var value: Value = output
        if let inputValue = delegate?.done(manager: self, task: task, output: output) {
            value = inputValue
        }
        start(input: value)
    }
    
}

class Task: TaskType {
    
    weak var delegate: TaskDelegate?
    
    var identifier: UUID = UUID()
    
    var delay: Int = 1
    
    func start(input: Value) throws {
        delegate?.task(willStart: self, input: input)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(delay)) {
            print("start \(self.identifier) input:\(input)")
            self.done(output: self.identifier)
        }
    }
    
    func done(output: Value) {
        delegate?.task(didDone: self, output: output)
    }
}

enum TaskError: Error {
    case crashed
}

class ErrorTask: TaskType {
    var identifier: UUID = UUID()
    
    var delegate: TaskDelegate?
    
    func start(input: Value) throws {
        throw TaskError.crashed
    }
    
    func done(output: Value) {
        delegate?.task(didDone: self, output: output)
    }
}

let chain = TaskChain.init()

chain.insert(task: Task())
chain.insert(task: ErrorTask())
chain.insert(task: Task())
chain.start(input: "T##Value")
