
import Foundation
import MapKit

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
