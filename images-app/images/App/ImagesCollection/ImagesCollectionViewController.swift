
import UIKit
import Kingfisher

private let reuseIdentifier = "ImageCell"

class ImagesCollectionViewController: UICollectionViewController {

    var photos: [PhotoViewModel] = []

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionCell

        let photo = photos[indexPath.row]
        guard let url = photo.fullsize else {
            cell.imageView.image = Image(named: "photo")
            return cell
        }

        let resource = ImageResource(downloadURL: url)
        let placeholder = UIImage(named: "photo")
        cell.imageView.kf.setImage(with: resource, placeholder: placeholder)
        cell.imageView.contentMode = .scaleAspectFill
    
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView.indexPath(for: cell),
            let imageController = segue.destination as? ImageViewController else {

            return
        }

        let photo = photos[indexPath.item]
        imageController.url = photo.fullsize
    }

}
