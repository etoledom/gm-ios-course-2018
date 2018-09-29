
import UIKit

class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
