import Foundation

struct Todo: CustomStringConvertible, Codable {
    var id: UUID
    var title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }

    var description: String {
        "\(isCompleted ? "✅" : "❌") \(title)"
    }
}
