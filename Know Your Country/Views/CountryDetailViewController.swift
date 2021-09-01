//
//  CountryDetailViewController.swift
//  Know Your Country
//
//  Created by Abilash Francis on 29/8/21.
//

import UIKit
import WebKit

class CountryDetailViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var continentLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var callingCodeLabel: UILabel!
    
    lazy var viewModel: CountryDetailViewModel = {
        return CountryDetailViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCountryDetails()
        customiseUI()
    }
    
    func populateCountryDetails() {
        flagImageView.image = viewModel.flag
        
        countryTitleLabel.text = viewModel.country
        capitalLabel.text = viewModel.capital
        currencyLabel.text = viewModel.currency
        languageLabel.text = viewModel.language
        continentLabel.text = viewModel.continent
        areaLabel.text = viewModel.areaString
        populationLabel.text = viewModel.population
        callingCodeLabel.text = viewModel.callingCode
    }
    
    func customiseUI() {
        
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        
        stackView.layer.cornerRadius = 8
        stackView.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MapViewController {
            destination.title = viewModel.country
        }
    }
}

