import Alert
import ComposableArchitecture
import Foundation
import Player

@Reducer
struct ToggleViewReducer {

	struct State: Equatable {
		var alert: AlertReducer.State
		var player: AudioPlayerReducer.State
	}

	enum Action: Sendable {
		case alert(AlertReducer.Action)
		case player(AudioPlayerReducer.Action)
	}

	var body: some Reducer<State, Action> {
		Scope(state: \.alert, action: \.alert) {
			AlertReducer()
		}
		Scope(state: \.player, action: \.player) {
			AudioPlayerReducer()
		}
		Reduce { state, action in
			switch action {
			case .alert(let action):
				if action == .turnOn {
					return .run { send in
						await send(.player(.play))
					}
				}
				return .none
			default:
				return .none
			}
		}
	}
}
