import Observation
import GameplayKit

@Observable
@MainActor
final class Entity: GKEntity {
    var alert: AlertModel?

    func update(alert: AlertModel?) {
        self.alert = alert
    }
}
