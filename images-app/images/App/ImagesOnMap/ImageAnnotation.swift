import MapKit

class ImageAnnotation: NSObject, MKAnnotation {
    let photoViewModel: PhotoViewModel

    let coordinate: CLLocationCoordinate2D
    let title: String?

    var id: String {
        return photoViewModel.id
    }

    var url: URL? {
        return photoViewModel.thumbnail
    }

    init(photo: PhotoViewModel) {
        self.coordinate = CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude)
        self.title = photo.title
        self.photoViewModel = photo
    }
}
