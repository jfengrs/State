import ComposableArchitecture
import SwiftUI

public struct AlertView: View {

    /// Combine
	@StateObject var alertObservableObject = AlertObservableObject()

    /// Observation
	let alertObservation: AlertObservation

    /// Perception
    let alertPerception = AlertPerception()

    /// GameplayKit
    let alertStateMachine = AlertStateMachineObservation()

    /// ComposableArchitecture
	let alertStore: AlertStore

    var alert: AlertModel? {
//        alertObservableObject.alert
        alertObservation.alert
//        alertPerception.alert
//        alertStateMachine.alert
//        alertStore.alert
    }
    
    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 32) {
                if let message = alert?.message {
                    Text(message).font(.system(size: 20, weight: .semibold))
                }
                HStack(spacing: 128) {
                    if let yesTitle = alert?.yesTitle {
                        Button {
							alert?.yesAction?()
                        } label: {
                            Text(yesTitle)
                                .font(.system(size: 17))
                                .foregroundColor(.blue)
                        }
                    }
                    if let noTitle = alert?.noTitle {
                        Button {
							alert?.noAction?()
                        } label: {
                            Text(noTitle)
                                .font(.system(size: 17))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }.onAppear {
                alertStateMachine.start()
            }
        }
    }

	public init(viewState: Binding<ViewState>, store: StoreOf<AlertReducer>) {
		alertObservation = AlertObservation(currentState: viewState)
		alertStore = AlertStore(store: store)
	}
}
