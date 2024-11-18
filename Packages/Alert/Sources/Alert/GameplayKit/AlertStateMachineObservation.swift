import Observation
import GameplayKit

@Observable
@MainActor
final class AlertStateMachineObservation {

    private let entity: Entity
    let machine: GKStateMachine
    var alert: AlertModel? {
        entity.alert
    }

    init() {
        /// Distributed state management
        let component = Component()
        let entity = Entity()
        entity.addComponent(component)

        /// Define all states and a state machine to operate with the states
        ///
        /// Ininital state    (-   Initiating State
        ///    |        |                       |
        /// Ongoing State  -)  Off State
		///
        let initialState = InitialState(entity: entity)
        let ongoingState = OngoingState(entity: entity)
        let offState = OffState(entity: entity)
        let initiatingState = InitiatingState(entity: entity)
        self.entity = entity
        machine = GKStateMachine(states: [initialState, ongoingState, offState, initiatingState])
    }

	func start() {
		machine.enter(InitialState.self)
    }
}
