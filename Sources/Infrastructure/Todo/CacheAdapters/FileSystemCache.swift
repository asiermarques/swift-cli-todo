import Foundation

class FileSystemCache: Cache {
    private let fileManager = FileManager.default
    private let filePath: String

    init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true)[0]
        self.filePath = (documentsPath as NSString).appendingPathComponent("todos.json")
    }

    func save(_ todos: [Todo]) throws {
        let data = try JSONEncoder().encode(todos)
        if !fileManager.createFile(atPath: filePath, contents: data, attributes: nil) {
            throw CacheError.saveFailed
        }
    }

    func load() throws -> [Todo] {
        guard let data = fileManager.contents(atPath: filePath) else {
            return []
        }
        return try JSONDecoder().decode([Todo].self, from: data)
    }

    func clear() throws {
        if fileManager.fileExists(atPath: filePath) {
            try fileManager.removeItem(atPath: filePath)
        }
    }
}
