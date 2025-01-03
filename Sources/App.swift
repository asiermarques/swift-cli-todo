import Foundation

class App {
    private let cliController: CliController

    init(cache: Cache = InMemoryCache()) {
        self.cliController = CliController(cache: cache)
    }

    func run() {
        print("Welcome to Todo App! Type 'help' for available commands.")

        while true {
            print("\nEnter command:")
            guard let input = readLine()?.trimmingCharacters(in: .whitespaces) else { continue }
            let components = input.split(separator: " ", maxSplits: 1)
            guard let commandString = components.first else { continue }

            guard let command = Command(rawValue: String(commandString)) else {
                print("Unknown command. Type 'help' for available commands.")
                continue
            }

            let argument = components.count > 1 ? String(components[1]) : ""

            if !cliController.run(
                command: command, argument: argument, print: { (param: String) in print(param) })
            {
                break
            }
        }
    }
}
