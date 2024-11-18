@testable import Alert
import Testing

@MainActor
struct AlertPerceptionTests {

    @Test func testInitialToAreYouSure() async {
        let alertPerception = AlertPerception()
		alertPerception.alert.yesAction?()
        #expect(alertPerception.alert.message == "Are you sure?")
    }

	@Test func testOffToOn() async throws {
        let alertPerception = AlertPerception()
		alertPerception.alert.yesAction?()
		alertPerception.alert.yesAction?()
		alertPerception.alert.yesAction?()
		try await alertPerception.initiating()
		#expect(alertPerception.alert.message == "It is on")
    }
}
