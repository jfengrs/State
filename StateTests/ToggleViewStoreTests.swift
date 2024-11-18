import ComposableArchitecture
import Testing
@testable import Alert
@testable import Player
@testable import State

@MainActor
struct ToggleViewStoreTests {

    @Test func testInitiating() async throws {
		let state = ToggleViewReducer.State(alert: AlertReducer.State(), player: AudioPlayerReducer.State())
		let clock = TestClock()
		let store = TestStore(initialState: state) {
			ToggleViewReducer()
		} withDependencies: {
			$0.continuousClock = clock
		}
		await store.send(.alert(.turnOff)) {
			$0.alert.currentState = .areYouSure
		}
		await store.send(.alert(.sure)) {
			$0.alert.currentState = .areYouRealSure
		}
		await store.send(.alert(.reallySure)) {
			$0.alert.currentState = .off
		}
		await store.send(.alert(.turnOn)) {
			$0.alert.currentState = .initiating
		}
		await store.receive(\.player.play) {
			$0.player.currentState = .playing
		}
		await clock.advance(by: .seconds(3.5))
		await store.receive(\.alert.isOn) {
			$0.alert.currentState = .initial
		}
    }
}
