import UIKit

extension UIImageView {
    func load(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {
            return

        }

        load(from: url, contentMode: mode)
    }

    func load(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        ImageDownloader.getData(from: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return

            }
            
            DispatchQueue.main.async() {
                self.image = image
            }
        }
    }
}
