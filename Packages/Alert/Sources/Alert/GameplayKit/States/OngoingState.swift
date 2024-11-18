import GameplayKit

@MainActor
final class OngoingState: GKState, Sendable {

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
        stateClass == OngoingState.self ||
        stateClass == OffState.self ||
        stateClass == InitiatingState.self ||
        stateClass == InitialState.self
    }

	func update() {
		let alertModel = AlertModel(message: message, yesTitle: "Yes", yesAction: {
			self.yesAction()
		}, noTitle: "No", noAction: {
			self.noAction()
		})
		entity.update(alert: alertModel)
	}
}


private extension OngoingState {

    var message: String? {
        guard let component = entity.component(ofType: Component.self)  else {
            return nil
        }
        if component.current == 0 {
            return "Are you sure?"
        } else if component.current == 1 {
            return "Are you really sure?"
        } else {
            return nil
        }
    }

    func yesAction() {
        guard let component = entity.component(ofType: Component.self),
            let stateMachine = stateMachine else {
            return
        }
        let reachLimit = component.check()
        if reachLimit {
            stateMachine.enter(OffState.self)
        } else {
            stateMachine.enter(OngoingState.self)
        }
    }

    func noAction() {
        stateMachine?.enter(InitialState.self)
        if let component = entity.component(ofType: Component.self) {
            component.reset()
        }
    }
}
