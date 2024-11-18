import ComposableArchitecture
import Foundation

@MainActor
struct AudioPlayerStore {

	let store: StoreOf<AudioPlayerReducer> = Store(initialState: AudioPlayerReducer.State()) {
		AudioPlayerReducer()
	}
}
