import Foundation

class TodoManager {
    private let cache: Cache
    private(set) var todos: [Todo] = []

    init(cache: Cache) {
        self.cache = cache
        do {
            self.todos = try cache.load()
        } catch let error as CacheError {
            print(error.description)
        } catch {
            print(CacheError.loadFailed.description)
        }
    }

    func addTodo(title: String) -> Todo {
        let todo = Todo(title: title)
        todos.append(todo)
        saveTodos()
        return todo
    }

    func toggleTodo(id: UUID) {
        if let index = todos.firstIndex(where: { $0.id == id }) {
            todos[index].isCompleted.toggle()
            saveTodos()
        }
    }

    func deleteTodo(id: UUID) {
        todos.removeAll(where: { $0.id == id })
        saveTodos()
    }

    func listTodos() -> [Todo] {
        return todos
    }

    private func saveTodos() {
        do {
            try cache.save(todos)
        } catch let error as CacheError {
            print(error.description)
        } catch {
            print(CacheError.saveFailed.description)
        }
    }
}
