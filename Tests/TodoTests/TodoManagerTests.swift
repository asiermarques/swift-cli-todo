import XCTest

@testable import Todo

final class TodoManagerTests: XCTestCase {
    var manager: TodoManager!

    override func setUp() {
        super.setUp()
        manager = TodoManager()
    }

    func testAddTodo() {
        _ = manager.addTodo(title: "Test todo")
        XCTAssertEqual(manager.todos.count, 1)
        XCTAssertEqual(manager.todos[0].title, "Test todo")
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
        XCTAssertEqual(manager.listTodos().count, 0, "Should start with empty list")

        _ = manager.addTodo(title: "First todo")
        _ = manager.addTodo(title: "Second todo")

        let todos = manager.listTodos()
        XCTAssertEqual(todos.count, 2)
        XCTAssertEqual(todos[0].title, "First todo")
        XCTAssertEqual(todos[1].title, "Second todo")
    }
}
