
import UIKit
import MapKit
import Kingfisher

class ImagesMapViewController: UIViewController {

    let provider: PhotosProvider = PhotosProvider()

    var mapView: MKMapView {
        return self.view as! MKMapView
    }

    override func loadView() {
        self.view = MKMapView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        provider.delegate = self
        mapView.showsUserLocation = true
    }

    func configureMap() {
        mapView.delegate = self
    }

    func loadData() {
        let distance = distanceToMapEdge()
        provider.getImages(at: mapView.centerCoordinate, radius: distance)
    }

    func distanceToMapEdge() -> CLLocationDistance {
        let span = mapView.region.span
        let center = mapView.centerCoordinate
        let minimumSpan = min(span.latitudeDelta, span.longitudeDelta)

        let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let edgeLocation = CLLocation(
            latitude: center.latitude + minimumSpan / 2,
            longitude: center.longitude + minimumSpan / 2
        )

        return edgeLocation.distance(from: centerLocation) / 1000
    }

    func presentPhotos(from cluster: MKClusterAnnotation) {
        let storyboard = UIStoryboard(name: "ImagesCollectionViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ImagesCollectionViewController")

        guard let imagesCollectionController = controller as? ImagesCollectionViewController else {
            return
        }

        imagesCollectionController.photos = cluster.memberAnnotations
            .compactMap { $0 as? ImageAnnotation }
            .compactMap { $0.photoViewModel }

        show(imagesCollectionController, sender: nil)
    }

    func presentPhoto(from annotations: ImageAnnotation) {

    }
}

extension ImagesMapViewController: PhotosProviderDelegate {
    func photosProvider(_ provider: PhotosProvider, didAppendPhotos photos: [PhotoViewModel]) {
        let imageAnnotations = photos.map(ImageAnnotation.init(photo:))
        mapView.addAnnotations(imageAnnotations)
    }
}

extension ImagesMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let cluster = view.annotation as? MKClusterAnnotation {
            presentPhotos(from: cluster)
        } else if let photoAnnotation = view.annotation as? ImageAnnotation {
            presentPhoto(from: photoAnnotation)
        }
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        loadData()
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
        pinView.image = #imageLiteral(resourceName: "pin-background")
        let resource = ImageResource(downloadURL: url)
        let placeholder = UIImage(named: "photo")
        pinView.photoView.kf.setImage(with: resource, placeholder: placeholder)

//        DispatchQueue.global().async {
//            let data = try! Data(contentsOf: url)
//            DispatchQueue.main.async {
//                pinView.photoView.image = UIImage(data: data)
//            }
//        }

        return pinView
    }
}
