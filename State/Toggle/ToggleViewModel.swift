import Alert
import Player

@MainActor
final class ToggleViewModel {

	let player = AudioPlayer()

	func playWhen(from oldState: ViewState, to newState: ViewState) {
		guard oldState == .off, newState == .initiating else {
			return
		}
		Task {
			await player.play()
		}
	}
}
