// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

let manager = TodoManager()

let todo1 = manager.addTodo(title: "Learn Swift")
let todo2 = manager.addTodo(title: "Build an app")

print("All todos:")
manager.listTodos().forEach { todo in
    print("- \(todo.title) (\(todo.isCompleted ? "completed" : "pending"))")
}

manager.toggleTodo(id: todo1.id)

print("\nAfter toggling first todo:")
manager.listTodos().forEach { todo in
    print("- \(todo.title) (\(todo.isCompleted ? "completed" : "pending"))")
}
