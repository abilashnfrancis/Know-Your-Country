//
//  MapViewModel.swift
//  Know Your Country
//
//  Created by Abilash Francis on 1/9/21.
//

import MapKit

class MapViewModel {
    
    var showCountryOnMap: ((MKLocalSearch.Response)->())?
    
    func findOnMap(_ country: String?) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = country
            
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { [weak self] (response, error) in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            self?.showCountryOnMap?(response)
        }
    }
}
