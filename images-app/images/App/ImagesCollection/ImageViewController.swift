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

