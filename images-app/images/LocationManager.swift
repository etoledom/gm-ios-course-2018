
import CoreLocation

class LocationManager {
    static let shared = LocationManager()
    private let manager = CLLocationManager()

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    private init() {}
}
