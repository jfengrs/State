import GameplayKit

@MainActor
final class OffState: GKState, Sendable {

	private let entity: Entity

    init(entity: Entity) {
        self.entity = entity
    }
    
    override func didEnter(from: GKState?) {
		Task { @MainActor [weak self] in
			self?.update()
		}
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass == InitiatingState.self
    }

	func update() {
		let alert = AlertModel(message: "It is off", yesTitle: "Turn on", yesAction: {
			self.stateMachine?.enter(InitiatingState.self)
		})
		entity.update(alert: alert)
		action()
	}
}


private extension OffState {

    func action() {
        guard let component = entity.component(ofType: Component.self) else {
            return
        }
        component.reset()
    }
}
