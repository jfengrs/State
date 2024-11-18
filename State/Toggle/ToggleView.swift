import Alert
import SwiftUI

struct ToggleView: View {

	// Observation
	@State
	private var viewState: ViewState = .initial
	private let viewModel = ToggleViewModel()

	// Composable Architecture
	private let viewStore = ToggleViewStore()

    var body: some View {
		AlertView(viewState: $viewState, store: viewStore.alertStore)
			.onChange(of: viewState) { oldValue, newValue in
				viewModel.playWhen(from: oldValue, to: newValue)
			}
    }
}
