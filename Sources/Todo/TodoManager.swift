import Foundation

class TodoManager {
    private(set) var todos: [Todo] = []

    func addTodo(title: String) -> Todo {
        let todo = Todo(title: title)
        todos.append(todo)
        return todo
    }

    func toggleTodo(id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            todos[index].isCompleted.toggle()
        }
    }

    func deleteTodo(id: UUID) {
        todos.removeAll(where: { $0.id == id })
    }

    func listTodos() -> [Todo] {
        return todos
    }
}
