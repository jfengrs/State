import Foundation

@MainActor
final class AlertObservableObject: ObservableObject {

    @Published private var currentState = ViewState.initial

    var alert: AlertModel {
        switch currentState {
        case .initial:
            return AlertModel(message: "It is on", yesTitle: "Turn off", yesAction: { [weak self] in
                self?.currentState = .areYouSure
            })
        case .areYouSure:
            return AlertModel(message: "Are you sure?", yesTitle: "Yes", yesAction: { [weak self] in
                self?.currentState = .areYouRealSure
            }, noTitle: "No", noAction: { [weak self] in
                self?.currentState = .initial
            })
        case .areYouRealSure:
            return AlertModel(message: "Are you really sure?", yesTitle: "Yes", yesAction: { [weak self] in
                self?.currentState = .off
            }, noTitle: "No", noAction: { [weak self] in
                self?.currentState = .initial
            })
        case .off:
			return AlertModel(message: "It is off", yesTitle: "Turn on", yesAction: { [weak self] in
                self?.currentState = .initiating
				Task {
					try await self?.initiating()
				}
            })
        case .initiating:
            return AlertModel(message: "Initiating...")
        }
    }

    private func initiating() async throws {
		try await Task.sleep(for: .seconds(3.5))
        currentState = .initial
    }
}
