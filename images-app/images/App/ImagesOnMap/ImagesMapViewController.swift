
import UIKit
import MapKit

struct ImageViewModel {
    let latitude: Double
    let longitude: Double
    let title: String
    let thumbnail: URL
    let fullsize: URL
}

class ImagesMapViewController: UIViewController {

    var mapView: MKMapView {
        return self.view as! MKMapView
    }

    override func loadView() {
        self.view = MKMapView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
    }

    func configureMap() {
        mapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: 40.171027, longitude: -74.010528)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        mapView.region = MKCoordinateRegion(center: center, span: span)
    }

    func loadData() {
        let service = FlickrService(network: NetworkRequestImpl())
        let region = CLCircularRegion(center: mapView.centerCoordinate, radius: 200, identifier: "search")
        service.search(in: region) { [weak self] (response) in
            do {
                let photos = try response()
                let annotations: [ImageAnnotation] = photos.map {
                    let coordinate = CLLocationCoordinate2D(latitude: Double($0.latitude)!, longitude: Double($0.longitude)!)
                    let annotation = ImageAnnotation(coordinate: coordinate, image: $0)
                    return annotation
                }
                self?.mapView.addAnnotations(annotations)
            } catch {
                print(error)
            }
        }
    }
}

extension ImagesMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if mapView.annotations.isEmpty {
            loadData()
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if let clusterAnnotation = annotation as? MKClusterAnnotation, let first = clusterAnnotation.memberAnnotations.first as? ImageAnnotation{
            let annotationView = pin(for: first)
            annotationView?.badgeCount = clusterAnnotation.memberAnnotations.count
            return annotationView
        }

        guard let imageAnnotation = annotation as? ImageAnnotation else {
            return nil
        }

        return pin(for: imageAnnotation)
    }

    private func pin(for annotation: ImageAnnotation) -> ImageAnnotationView? {

        guard let url = annotation.url else {
            return nil
        }

        let pinView = ImageAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pinView.clusteringIdentifier = "pin"
        pinView.canShowCallout = true
        pinView.image = #imageLiteral(resourceName: "pin-background")
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                pinView.photoView.image = UIImage(data: data)
            }
        }

        return pinView
    }
}

