import Foundation

protocol Cache {
    func save(_ todos: [Todo]) throws
    func load() throws -> [Todo]
    func clear() throws
}

enum CacheError: Error {
    case saveFailed
    case loadFailed
    case clearFailed

    var description: String {
        switch self {
        case .saveFailed: return "Failed to save todos"
        case .loadFailed: return "Failed to load todos"
        case .clearFailed: return "Failed to clear cache"
        }
    }
}
