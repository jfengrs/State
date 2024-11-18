import GameplayKit

/// Abitlty, feature, logic etc
@MainActor
final class Component: GKComponent {

	private let limit = 2
    var current = 0
    
    func check() -> Bool {
        current += 1
        return current == limit
    }

    func reset() {
        current = 0
    }
}
