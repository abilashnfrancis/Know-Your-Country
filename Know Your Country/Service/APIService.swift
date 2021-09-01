//
//  APIService.swift
//  Know Your Country
//
//  Created by Abilash Francis on 29/8/21.
//

import Foundation

protocol APIServiceProtocol {
    func fetchAllCountries( complete: @escaping ( _ success: Bool, _ photos: [Country]?, _ error: Error? )->() )
}

class APIService: APIServiceProtocol {
    
    func fetchAllCountries( complete: @escaping ( _ success: Bool, _ photos: [Country]?, _ error: Error? )->() ) {
        DispatchQueue.global().async {
            
            let countriesEndpoint = "https://restcountries.eu/rest/v2/all?fields=name;capital;alpha2Code;flag;region;latlng;languages;numericCode;currencies;area;population"
            let request = URLRequest(url: URL(string: countriesEndpoint)!)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
                
                if let error = error {
                    complete(false, nil, error)
                }
                
                if let data = data {
                    let countries = try? JSONDecoder().decode([Country].self, from: data)
                    complete(true, (countries), nil )
                }
            })

            task.resume()
        }
    }
    
}
