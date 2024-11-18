import Foundation
import GameKit

@MainActor
final class InitiatingState: GKState, Sendable {

	private let entity: Entity

    init(entity: Entity) {
        self.entity = entity
    }

    override func didEnter(from: GKState?) {
		Task { @MainActor [weak self] in
			self?.update()
			try await self?.initiating()
		}
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass == InitialState.self
    }

	func update() {
		entity.update(alert: AlertModel(message: "Initiating..."))
	}

    func initiating() async throws {
		try await Task.sleep(for: .seconds(3.5))
		stateMachine?.enter(InitialState.self)
    }
}
