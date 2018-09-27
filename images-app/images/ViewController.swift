//
//  ViewController.swift
//  images
//
//  Created by Eduardo Toledo on 9/27/18.
//  Copyright © 2018 GM2018iOS. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    let mapView = MKMapView()

    override func loadView() {
        self.view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = FlickrService(network: OfflineNetworkRequest())
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 40.747472, longitude: -73.993094), radius: 200, identifier: "search")
        service.search(in: region) { [weak self] (response) in
            do {
                let photos = try response()
                print(photos.first!.photoUrl(size: FlickrPhoto.Size.medium))
                let annotations: [MKPointAnnotation] = photos.map {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    annotation.title = $0.title
                    return annotation
                }
                self?.mapView.addAnnotations(annotations)
            } catch {
                print(error)
            }
        }
    }
}

extension ViewController: MKMapViewDelegate {

}

