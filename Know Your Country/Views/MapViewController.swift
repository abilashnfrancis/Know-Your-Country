//
//  MapViewController.swift
//  Know Your Country
//
//  Created by Abilash Francis on 31/8/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var viewModel: MapViewModel = {
        return MapViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showCountryOnMap = {  [weak self] (response) in
            self?.mapView.setRegion(response.boundingRegion, animated: true)
        }
        viewModel.findOnMap(title)
    }
    
}

