import GameplayKit

@MainActor
final class InitialState: GKState, Sendable {

	private let entity: Entity

    init(entity: Entity) {
        self.entity = entity
    }

    /// What to do when entering this state
    override func didEnter(from: GKState?) {
		Task { @MainActor [weak self] in
			self?.update()
		}
    }

    /// What is the next allowed state
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass == OngoingState.self
    }

	func update() {
		let alertModel = AlertModel(message: "It is on", yesTitle: "Turn off", yesAction: {
			self.stateMachine?.enter(OngoingState.self)
		})
		entity.update(alert: alertModel)
	}
}
