//
//  CountryDetailViewModel.swift
//  Know Your Country
//
//  Created by Abilash Francis on 29/8/21.
//

import UIKit

class CountryDetailViewModel {
    
    var selectedCountry: Country?
    
    var country: String? {
        return selectedCountry?.name
    }
    
    var flag: UIImage? {
        return UIImage(named: selectedCountry?.alpha2Code.lowercased() ?? "")
    }
    
    var capital: String? {
        return selectedCountry?.capital
    }
    
    var currency: String? {
        guard let currencies = selectedCountry?.currencies else {
            return "-"
        }
        return currencies.compactMap { $0.name }.joined(separator: ", ")
    }
    
    var language: String? {
        guard let languages = selectedCountry?.languages else {
            return "-"
        }
        return languages.compactMap { $0.name }.joined(separator: ", ")
    }
    
    var continent: String? {
        return selectedCountry?.region
    }
    
    var area: Double? {
        return selectedCountry?.area
    }
    
    var areaString: String? {
        guard let area = selectedCountry?.area else {
            return "-"
        }
        return "\(area) km²"
    }
    
    var population: String? {
        guard let population = selectedCountry?.population else {
            return "-"
        }
        return String(population)
    }
    
    var callingCode: String? {
        guard let callingCode = selectedCountry?.numericCode else {
            return "-"
        }
        return "+\(callingCode)"
    }
    
    var latLong: [Double]? {
        return selectedCountry?.latlng
    }

}
