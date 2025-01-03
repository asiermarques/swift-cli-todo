import Foundation

@testable import CLITodo

class MockCache: Cache {
    private var todos: [Todo] = []
    var saveCallCount = 0
    var loadCallCount = 0
    var clearCallCount = 0
    var shouldThrowError = false

    func save(_ todos: [Todo]) throws {
        saveCallCount += 1
        if shouldThrowError {
            throw CacheError.saveFailed
        }
        self.todos = todos
    }

    func load() throws -> [Todo] {
        loadCallCount += 1
        if shouldThrowError {
            throw CacheError.loadFailed
        }
        return todos
    }

    func clear() throws {
        clearCallCount += 1
        if shouldThrowError {
            throw CacheError.clearFailed
        }
        todos.removeAll()
    }
}
