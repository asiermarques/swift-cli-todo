import XCTest

@testable import CLITodo

final class CliControllerTests: XCTestCase {
    var controller: CliController!
    var mockCache: MockCache!
    var printedMessages: [String]!

    override func setUp() {
        super.setUp()
        mockCache = MockCache()
        printedMessages = []
        controller = CliController(cache: mockCache)
    }

    func testAddAndListTodos() {
        // Add todos
        XCTAssertTrue(controller.run(command: .add, argument: "First task", print: capture))
        XCTAssertTrue(controller.run(command: .add, argument: "Second task", print: capture))
        XCTAssertTrue(controller.run(command: .list, argument: "", print: capture))

        XCTAssertTrue(printedMessages.contains("Added todo: First task"))
        XCTAssertTrue(printedMessages.contains("Added todo: Second task"))
        XCTAssertTrue(printedMessages.contains("1. ❌ First task"))
        XCTAssertTrue(printedMessages.contains("2. ❌ Second task"))
    }

    func testToggleTodo() {
        XCTAssertTrue(controller.run(command: .add, argument: "Toggle me", print: capture))
        XCTAssertTrue(controller.run(command: .toggle, argument: "1", print: capture))
        XCTAssertTrue(controller.run(command: .list, argument: "", print: capture))

        XCTAssertTrue(printedMessages.contains("1. ✅ Toggle me"))
    }

    func testDeleteTodo() {
        XCTAssertTrue(controller.run(command: .add, argument: "Delete me", print: capture))
        XCTAssertTrue(controller.run(command: .delete, argument: "1", print: capture))
        XCTAssertTrue(controller.run(command: .list, argument: "", print: capture))

        XCTAssertTrue(printedMessages.contains("Deleted: Delete me"))
        XCTAssertTrue(printedMessages.contains("No todos yet"))
    }

    func testInvalidArguments() {
        XCTAssertTrue(controller.run(command: .toggle, argument: "999", print: capture))
        XCTAssertTrue(printedMessages.contains("Please provide a valid todo number"))

        XCTAssertTrue(controller.run(command: .add, argument: "", print: capture))
        XCTAssertTrue(printedMessages.contains("Please provide a todo title"))

        XCTAssertTrue(controller.run(command: .delete, argument: "invalid", print: capture))
        XCTAssertTrue(printedMessages.contains("Please provide a valid todo number"))
    }

    func testExitCommand() {
        XCTAssertFalse(controller.run(command: .exit, argument: "", print: capture))
    }

    private func capture(_ message: String) {
        printedMessages.append(message)
    }

}
