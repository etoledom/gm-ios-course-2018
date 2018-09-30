//
//  ImageViewController.swift
//  images
//
//  Created by Eduardo Toledo on 9/29/18.
//  Copyright © 2018 GM2018iOS. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!

    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }

    @objc func didDoubleTap(sender: UITapGestureRecognizer) {

        if scrollView.zoomScale == 1 {
            let point = sender.location(in: imageView)
            let deltaX = imageView.bounds.width / 5
            let deltaY = imageView.bounds.height / 5
            let center = CGPoint(x: point.x - deltaX / 2, y: point.y - deltaY / 2)
            let rect = CGRect(origin: center, size: CGSize(width: deltaX, height: deltaY))
            scrollView.zoom(to: rect, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let url = url else {
            return
        }

        let resource = ImageResource(downloadURL: url)
        imageView.kf.setImage(with: resource)
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

