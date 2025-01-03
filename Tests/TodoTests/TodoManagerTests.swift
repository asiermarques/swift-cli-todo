import XCTest

@testable import CLITodo

final class TodoManagerTests: XCTestCase {
    var manager: TodoManager!
    var mockCache: MockCache!

    override func setUp() {
        super.setUp()
        mockCache = MockCache()
        manager = TodoManager(cache: mockCache)
    }

    func testAddTodo() {
        let todo = manager.addTodo(title: "Test todo")

        XCTAssertEqual(manager.todos.count, 1)
        XCTAssertEqual(todo.title, "Test todo")
        XCTAssertFalse(todo.isCompleted)
    }

    func testToggleTodo() {
        let todo = manager.addTodo(title: "Test todo")

        manager.toggleTodo(id: todo.id)
        XCTAssertTrue(manager.todos[0].isCompleted)

        manager.toggleTodo(id: todo.id)
        XCTAssertFalse(manager.todos[0].isCompleted)
    }

    func testDeleteTodo() {
        let todo = manager.addTodo(title: "Test todo")
        XCTAssertEqual(manager.todos.count, 1)

        manager.deleteTodo(id: todo.id)
        XCTAssertEqual(manager.todos.count, 0)
    }

    func testListTodos() {
        XCTAssertEqual(manager.listTodos().count, 0)

        _ = manager.addTodo(title: "First todo")
        _ = manager.addTodo(title: "Second todo")

        let todos = manager.listTodos()
        XCTAssertEqual(todos.count, 2)
        XCTAssertEqual(todos[0].title, "First todo")
        XCTAssertEqual(todos[1].title, "Second todo")
    }
}
