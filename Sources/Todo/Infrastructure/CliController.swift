import Foundation

class CliController {

    private let manager: TodoManager

    init(cache: Cache = InMemoryCache()) {
        self.manager = TodoManager(cache: cache)
    }

    func run(command: Command, argument: String, print: (String) -> Void) -> Bool {
        switch command {
        case .add:
            guard !argument.isEmpty else {
                print("Please provide a todo title")
                return true
            }
            let todo = manager.addTodo(title: argument)
            print("Added todo: \(todo.title)")
        case .list:
            let todos = manager.listTodos()
            if todos.isEmpty {
                print("No todos yet")
            } else {
                print("Todos:")
                todos.enumerated().forEach { (index, todo) in
                    print("\(index+1). \(todo.description)")
                }
            }
        case .toggle:
            guard let index = Int(argument),
                index > 0,
                index <= manager.todos.count
            else {
                print("Please provide a valid todo number")
                return true
            }
            let todo = manager.todos[index - 1]
            manager.toggleTodo(id: todo.id)
            print("Toggled: \(todo.title)")
        case .delete:
            guard let index = Int(argument),
                index > 0,
                index <= manager.todos.count
            else {
                print("Please provide a valid todo number")
                return true
            }
            let todo = manager.todos[index - 1]
            manager.deleteTodo(id: todo.id)
            print("Deleted: \(todo.title)")
        case .help:
            Command.showHelp()
        case .exit:
            print("Goodbye!")
            return false
        }
        return true
    }
}
