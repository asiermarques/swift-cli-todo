import XCTest

@testable import CLITodo

final class InMemoryCacheTests: XCTestCase {
    var cache: InMemoryCache!
    var todos: [Todo]!

    override func setUp() {
        super.setUp()
        cache = InMemoryCache()
        todos = [
            Todo(title: "First todo"),
            Todo(title: "Second todo", isCompleted: true),
        ]
    }

    func testSaveAndLoad() throws {
        try cache.save(todos)
        let loadedTodos = try cache.load()

        XCTAssertEqual(loadedTodos.count, 2)
        XCTAssertEqual(loadedTodos[0].title, "First todo")
        XCTAssertFalse(loadedTodos[0].isCompleted)
        XCTAssertEqual(loadedTodos[1].title, "Second todo")
        XCTAssertTrue(loadedTodos[1].isCompleted)
    }

    func testClear() throws {
        try cache.save(todos)
        XCTAssertEqual(try cache.load().count, 2)

        try cache.clear()
        XCTAssertEqual(try cache.load().count, 0)
    }

    func testLoadEmptyCache() throws {
        let loadedTodos = try cache.load()
        XCTAssertEqual(loadedTodos.count, 0)
    }

    func testOverwriteExistingData() throws {
        try cache.save(todos)
        XCTAssertEqual(try cache.load().count, 2)

        let newTodos = [Todo(title: "New todo")]
        try cache.save(newTodos)

        let loadedTodos = try cache.load()
        XCTAssertEqual(loadedTodos.count, 1)
        XCTAssertEqual(loadedTodos[0].title, "New todo")
    }
}
