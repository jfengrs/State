import ComposableArchitecture
import Foundation

@Reducer
public struct AudioPlayerReducer: Sendable {

	let player = AudioPlayer()

	public enum PlayerState {
		case playing, notPlaying
	}

	@ObservableState
	public struct State: Equatable {
		var currentState = PlayerState.notPlaying
		public init() {}
	}

	public enum Action: Sendable {
		case play
	}

	public var body: some Reducer<State, Action> {
		Reduce { state, action in
			switch action {
			case .play:
				state.currentState = .playing
				return .run { send in
					await player.play()
				}
			}
		}
	}

	public init() {}
}
