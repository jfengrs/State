import ComposableArchitecture
import Foundation

@MainActor
struct AlertStore {

    let store: StoreOf<AlertReducer>

    var alert: AlertModel {
        switch store.currentState {
        case .initial:
            return AlertModel(message: "It is on", yesTitle: "Turn off", yesAction: {
                self.store.send(.turnOff)
            })
        case .areYouSure:
            return AlertModel(message: "Are you sure?", yesTitle: "Yes", yesAction: {
                self.store.send(.sure)
            }, noTitle: "No", noAction: {
                self.store.send(.notSure)
            })
        case .areYouRealSure:
            return AlertModel(message: "Are you really sure?", yesTitle: "Yes", yesAction: {
                self.store.send(.reallySure)
            }, noTitle: "No", noAction: {
                self.store.send(.reallyNotSure)
            })
        case .off:
            return AlertModel(message: "It is off", yesTitle: "Turn on", yesAction: {
                self.store.send(.turnOn)
            })
        case .initiating:
            return AlertModel(message: "initiating...")
        }
    }
}
