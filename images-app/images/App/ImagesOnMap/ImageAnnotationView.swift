
import Foundation
import MapKit

class BadgeView: UIView {
    let badgeLabel = UILabel()
    var count: Int = 0 {
        didSet {
            badgeLabel.text = "\(count)"
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        configureLabel()
        widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 1).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    func configureLabel() {
        badgeLabel.textColor = .white
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            badgeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            badgeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
            ])
    }
}

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

class ImageAnnotationView: MKAnnotationView {

    let photoView = UIImageView()
    private let badgeView = BadgeView()

    var badgeCount: Int = 0 {
        didSet {
            badgeView.isHidden = badgeCount <= 0
            badgeView.count = badgeCount
        }
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.image = #imageLiteral(resourceName: "pin-background")
        configurePhotoView()
        configureBadgeView()
    }

    func configurePhotoView() {
        photoView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoView)
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor)
            ])
    }

    func configureBadgeView() {
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeView.backgroundColor = .blue
        addSubview(badgeView)
        NSLayoutConstraint.activate([
            badgeView.centerXAnchor.constraint(equalTo: trailingAnchor),
            badgeView.centerYAnchor.constraint(equalTo: topAnchor)
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
