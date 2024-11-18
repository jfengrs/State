import Observation
import SwiftUI

@Observable
@MainActor
final class AlertObservation {

	private var currentState: Binding<ViewState>

    var alert: AlertModel {
		switch currentState.wrappedValue {
        case .initial:
            return AlertModel(message: "It is on", yesTitle: "Turn off", yesAction: { [weak self] in
				self?.updateCurrentState(.areYouSure)
            })
        case .areYouSure:
            return AlertModel(message: "Are you sure?", yesTitle: "Yes", yesAction: { [weak self] in
				self?.updateCurrentState(.areYouRealSure)
            }, noTitle: "No", noAction: { [weak self] in
				self?.updateCurrentState(.initial)
            })
        case .areYouRealSure:
            return AlertModel(message: "Are you really sure?", yesTitle: "Yes", yesAction: { [weak self] in
				self?.updateCurrentState(.off)
            }, noTitle: "No", noAction: { [weak self] in
				self?.updateCurrentState(.initial)
            })
        case .off:
			return AlertModel(message: "It is off", yesTitle: "Turn on", yesAction: { [weak self] in
				self?.updateCurrentState(.initiating)
				Task {
					try await self?.initiating()
				}
            })
        case .initiating:
            return AlertModel(message: "Initiating...")
        }
    }

	init(currentState: Binding<ViewState>) {
		self.currentState = currentState
	}

    func initiating() async throws {
		try await Task.sleep(for: .seconds(3.5))
		currentState.wrappedValue = .initial
    }

	func updateCurrentState(_ state: ViewState) {
		currentState.wrappedValue = state
	}
}
