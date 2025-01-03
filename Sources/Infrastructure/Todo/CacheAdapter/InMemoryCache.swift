import Foundation

class InMemoryCache: Cache {
    private var todos: [Todo] = []

    func save(_ todos: [Todo]) throws {
        self.todos = todos
    }

    func load() throws -> [Todo] {
        return todos
    }

    func clear() throws {
        todos.removeAll()
    }
}
