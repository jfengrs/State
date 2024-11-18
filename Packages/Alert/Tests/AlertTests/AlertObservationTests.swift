import Testing
import SwiftUI
@testable import Alert

@MainActor
struct StateTests {

    @Test func testInitialToAreYouSure() async {
		var state = ViewState.initial
		let binding = Binding<ViewState>.init {
			state
		} set: { viewState in
			state = viewState
		}
		let alertObservation = AlertObservation(currentState: binding)
		alertObservation.alert.yesAction?()
        #expect(alertObservation.alert.message == "Are you sure?")
    }

	@Test func testOffToOn() async throws {
		var state = ViewState.initial
		let binding = Binding<ViewState>.init {
			state
		} set: { viewState in
			state = viewState
		}
		let alertObservation = AlertObservation(currentState: binding)
		alertObservation.alert.yesAction?()
		alertObservation.alert.yesAction?()
		alertObservation.alert.yesAction?()
		try await alertObservation.initiating()
        #expect(alertObservation.alert.message == "It is on")
    }
}
