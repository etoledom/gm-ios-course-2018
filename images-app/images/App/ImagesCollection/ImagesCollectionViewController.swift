
import UIKit

private let reuseIdentifier = "ImageCell"


class ImagesCollectionViewController: UICollectionViewController {

    var images: [ImageViewModel] = [
        ImageViewModel(latitude: 0.0, longitude: 0.0, title: "Image", thumbnail: URL(string: "http://google.com")!, fullsize: URL(string: "http://google.com")!),
        ImageViewModel(latitude: 0.0, longitude: 0.0, title: "Image", thumbnail: URL(string: "http://google.com")!, fullsize: URL(string: "http://google.com")!),
        ImageViewModel(latitude: 0.0, longitude: 0.0, title: "Image", thumbnail: URL(string: "http://google.com")!, fullsize: URL(string: "http://google.com")!),
        ImageViewModel(latitude: 0.0, longitude: 0.0, title: "Image", thumbnail: URL(string: "http://google.com")!, fullsize: URL(string: "http://google.com")!),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionCell
        cell.imageView.image = #imageLiteral(resourceName: "photo")
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

}
