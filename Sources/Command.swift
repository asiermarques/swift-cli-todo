import Foundation

enum Command: String {
    case add = "add"
    case list = "list"
    case toggle = "toggle"
    case delete = "delete"
    case exit = "exit"
    case help = "help"

    static func showHelp() {
        print(
            """
            Available commands:
            - add <title>: Add a new todo
            - list: Show all todos
            - toggle <number>: Toggle completion status of a todo
            - delete <number>: Delete a todo
            - help: Show this help message
            - exit: Close the application
            """)
    }
}
