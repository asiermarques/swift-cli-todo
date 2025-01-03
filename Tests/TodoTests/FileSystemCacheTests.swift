import XCTest

@testable import CLITodo

final class FileSystemCacheTests: XCTestCase {
    var cache: FileSystemCache!
    var todos: [Todo]!
    var tempDirectory: String!

    override func setUp() {
        super.setUp()
        tempDirectory = NSTemporaryDirectory() + UUID().uuidString
        try? FileManager.default.createDirectory(
            atPath: tempDirectory, withIntermediateDirectories: true)
        cache = FileSystemCache(directory: tempDirectory)
        todos = [
            Todo(title: "First todo"),
            Todo(title: "Second todo", isCompleted: true),
        ]
    }

    override func tearDown() {
        try? FileManager.default.removeItem(atPath: tempDirectory)
        super.tearDown()
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

    func testInvalidDirectoryThrows() {
        let invalidCache = FileSystemCache(directory: "/invalid/path")
        XCTAssertThrowsError(try invalidCache.save(todos)) { error in
            XCTAssertTrue(error is CacheError)
        }
    }

    func testFilePermissionError() {
        // Create a read-only directory
        try? FileManager.default.createDirectory(
            atPath: tempDirectory + "/readonly", withIntermediateDirectories: true)
        try? FileManager.default.setAttributes(
            [.posixPermissions: 0o444], ofItemAtPath: tempDirectory + "/readonly")

        let readOnlyCache = FileSystemCache(directory: tempDirectory + "/readonly")
        XCTAssertThrowsError(try readOnlyCache.save(todos)) { error in
            XCTAssertTrue(error is CacheError)
        }
    }
}
