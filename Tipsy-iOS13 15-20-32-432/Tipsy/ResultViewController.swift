//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Julien Cotte on 09/09/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var splittedBill : String?
    var tipPercentage: Int?
    var numberOfPeople: Int?
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    
    @IBAction func recalculatePressed(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = splittedBill
        settingsLabel.text = "Split between \(numberOfPeople!) people,\n with \(tipPercentage!)% tip."
    }
}
