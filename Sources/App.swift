import Foundation

class App {
    private let manager: TodoManager

    init() {
        self.manager = TodoManager()
    }

    func run() {
        print("Welcome to Todo App! Type 'help' for available commands.")

        while true {
            print("\nEnter command:")
            guard let input = readLine()?.trimmingCharacters(in: .whitespaces) else { continue }
            let components = input.split(separator: " ", maxSplits: 1)
            guard let commandString = components.first else { continue }

            guard let command = Command(rawValue: String(commandString)) else {
                print("Unknown command. Type 'help' for available commands.")
                continue
            }

            let argument = components.count > 1 ? String(components[1]) : ""

            switch command {
            case .add:
                guard !argument.isEmpty else {
                    print("Please provide a todo title")
                    continue
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
                    continue
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
                    continue
                }
                let todo = manager.todos[index - 1]
                manager.deleteTodo(id: todo.id)
                print("Deleted: \(todo.title)")

            case .help:
                Command.showHelp()

            case .exit:
                print("Goodbye!")
                return
            }
        }
    }
}
