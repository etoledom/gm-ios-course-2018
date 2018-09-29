
import Foundation
import CoreLocation

protocol PhotosProviderDelegate: class {
    func photosProvider(_ provider: PhotosProvider, didAppendPhotos: [PhotoViewModel])
}

class PhotosProvider {

    var delegate: PhotosProviderDelegate?
    var photos: [PhotoViewModel] = []

    func getImages(at center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let service = FlickrService(network: NetworkRequestImpl())
        let region = CLCircularRegion(center: center, radius: radius, identifier: "search")
        service.search(in: region) { [weak self] (response) in
            do {
                let remotePhotos = try response()
                let photos = remotePhotos.map(PhotoViewModel.init)
                self?.append(new: photos)
            } catch {
                print(error)
            }
        }
    }

    func append(new newPhotos: [PhotoViewModel]) {
        let oldPhotosSet = Set(photos)
        let newPhotosSet = Set(newPhotos)

        let newUniquePhotosSet = newPhotosSet.subtracting(oldPhotosSet)
        let newUniquePhotos = Array(newUniquePhotosSet)

        let photosSet = Set(photos + newPhotos)
        photos = Array(photosSet)

        delegate?.photosProvider(self, didAppendPhotos: newUniquePhotos)
    }
}

extension PhotoViewModel {
    init(with imageRemote: FlickrPhoto) {
        id = imageRemote.id
        latitude = Double(imageRemote.latitude) ?? 0.0
        longitude = Double(imageRemote.longitude) ?? 0.0
        title = imageRemote.title
        thumbnail = URL(string: imageRemote.photoUrl(size: .thumb))
        fullsize = URL(string: imageRemote.photoUrl(size: .big))
    }
}
