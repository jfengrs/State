import ComposableArchitecture
@testable import Alert
import Testing

@MainActor
struct AlertStoreTests {

    @Test func testInitialToAreYouSure() async {
		let store = StoreOf<AlertReducer>(initialState: AlertReducer.State()) {
			AlertReducer()
		}
		let alertStore = AlertStore(store: store)
		alertStore.alert.yesAction?()
        #expect(alertStore.alert.message == "Are you sure?")
    }
}
