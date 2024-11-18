import Foundation
import ComposableArchitecture

@Reducer
public struct AlertReducer: Sendable {

    @ObservableState
	public struct State: Equatable {
		public var currentState = ViewState.initial
		public init() {}
    }

	public enum Action: Sendable {
        case none
        case turnOff
        case sure
        case notSure
        case reallySure
        case reallyNotSure
        case turnOn
        case isOn
    }

	public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .turnOff:
                state.currentState = .areYouSure
                return .none
            case .sure:
                state.currentState = .areYouRealSure
                return .none
            case .notSure:
                state.currentState = .initial
                return .none
            case .reallySure:
                state.currentState = .off
                return .none
            case .reallyNotSure:
                state.currentState = .initial
                return .none
            case .turnOn:
                state.currentState = .initiating
                return .run { send in
					for await _ in self.clock.timer(interval: .seconds(3.5)) {
						await send(.isOn)
					}
                }.cancellable(id: CancelID.timer)
            case .isOn:
                state.currentState = .initial
                return .cancel(id: CancelID.timer)
            default:
                return .none
            }
        }
    }

	@Dependency(\.continuousClock) var clock
	enum CancelID {
		case timer
	}

	public init() {}
}
