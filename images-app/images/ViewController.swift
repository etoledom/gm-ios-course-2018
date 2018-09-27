
import UIKit
import MapKit

struct ImageViewModel {
    let coordinate: CLLocationCoordinate2D
    let title: String
    let thumbnail: URL
    let fullsize: URL
}

class ViewController: UIViewController {

    var mapView: MKMapView {
        return self.view as! MKMapView
    }

    override func loadView() {
        self.view = MKMapView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        loadData()
    }

    func configureMap() {
        mapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: 40.171027, longitude: -74.010528)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        mapView.region = MKCoordinateRegion(center: center, span: span)
    }

    func loadData() {
        let service = FlickrService(network: OfflineNetworkRequest())
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 40.747472, longitude: -73.993094), radius: 200, identifier: "search")
        service.search(in: region) { [weak self] (response) in
            do {
                let photos = try response()
                let annotations: [MKPointAnnotation] = photos.map {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    annotation.title = $0.title
                    return annotation
                }
                self?.mapView.addAnnotations(annotations)
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = ImageAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pinView.clusteringIdentifier = "pin"
        pinView.canShowCallout = true
        pinView.photoView.image = #imageLiteral(resourceName: "photo")
        if let cluster = annotation as? MKClusterAnnotation {
            pinView.badgeCount = cluster.memberAnnotations.count
        } else {
            pinView.badgeCount = 0
        }
        return pinView
    }
}

