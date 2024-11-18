@testable import Alert
import Testing

@MainActor
struct AlertStateMachineObservationTests {

	@Test func testInitialToAreYouSure() async throws {
        let alertStateMachine = AlertStateMachineObservation()
        alertStateMachine.start()
		let initialState = try #require(alertStateMachine.machine.currentState as? InitialState)
		initialState.update()
		alertStateMachine.alert?.yesAction?()
		let ongoingState = try #require(alertStateMachine.machine.currentState as? OngoingState)
		ongoingState.update()
        #expect(alertStateMachine.alert?.message == "Are you sure?")
    }

    @Test func testOffToOn() async throws {
        let alertStateMachine = AlertStateMachineObservation()
        alertStateMachine.start()
		let initialState = try #require(alertStateMachine.machine.currentState as? InitialState)
		initialState.update()
		alertStateMachine.alert?.yesAction?()
		let ongoingState = try #require(alertStateMachine.machine.currentState as? OngoingState)
		ongoingState.update()
		alertStateMachine.alert?.yesAction?()
		let ongoingState2 = try #require(alertStateMachine.machine.currentState as? OngoingState)
		ongoingState2.update()
		alertStateMachine.alert?.yesAction?()
		let offState = try #require(alertStateMachine.machine.currentState as? OffState)
		offState.update()
		alertStateMachine.alert?.yesAction?()
		let initiatingState = try #require(alertStateMachine.machine.currentState as? InitiatingState)
		initiatingState.update()
		await #expect(throws: Never.self) {
            try await initiatingState.initiating()
        }
		initialState.update()
        #expect(alertStateMachine.alert?.message == "It is on")
    }
}
