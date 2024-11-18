import ComposableArchitecture
import Alert
import Foundation
import Player

@MainActor
struct ToggleViewStore {

	let store: StoreOf<ToggleViewReducer>
	let alertStore: StoreOf<AlertReducer>

	init() {
		let initialState = ToggleViewReducer.State(
			alert: AlertReducer.State(),
			player: AudioPlayerReducer.State()
		)
		store = Store(initialState: initialState) {
			ToggleViewReducer()
		}
		alertStore = store.scope(state: \.alert, action: \.alert)
	}
}
