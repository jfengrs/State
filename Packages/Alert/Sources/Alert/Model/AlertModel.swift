import Foundation

struct AlertModel {

    let message: String?
    let yesTitle: String?
    let yesAction: (() -> Void)?
    let noTitle: String?
    let noAction: (() -> Void)?

    init(message: String?,
         yesTitle: String? = nil,
         yesAction: (() ->Void)? = nil,
         noTitle: String? = nil,
         noAction: (() -> Void)? = nil) {
        self.message = message
        self.yesTitle = yesTitle
        self.yesAction = yesAction
        self.noTitle = noTitle
        self.noAction = noAction
    }
}

extension AlertModel: Equatable {

	static func == (lhs: AlertModel, rhs: AlertModel) -> Bool {
        lhs.message == rhs.message && lhs.yesTitle == rhs.yesTitle && lhs.noTitle == rhs.noTitle
    }
}
