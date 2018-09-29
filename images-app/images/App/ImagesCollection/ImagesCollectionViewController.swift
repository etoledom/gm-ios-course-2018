
import UIKit
import Kingfisher

private let reuseIdentifier = "ImageCell"

class ImagesCollectionViewController: UICollectionViewController {

    var photos: [PhotoViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }

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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
