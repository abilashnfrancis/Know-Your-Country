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
    
    override func viewDidLoad() {
        showCountryOnMap(title)
    }
    
    func showCountryOnMap(_ country: String?) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = country
            
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            self.mapView.setRegion(response.boundingRegion, animated: true)
        }
    }
    
}

