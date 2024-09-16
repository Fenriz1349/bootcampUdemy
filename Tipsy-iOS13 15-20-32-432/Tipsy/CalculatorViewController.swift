//
//  ViewController.swift
//  Tipsy
//
//  Created by Julien Cotte on 09/09/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1
    var numberOfPeople = 2
    var billTotal = 0.0
    var resultBill = ""
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        if let buttonTitle = sender.currentTitle?.dropLast(),
           let tipValue = Double(buttonTitle) {
            tip = tipValue / 100
        }
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        splitNumberLabel.text = String(numberOfPeople)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" {
            billTotal = Double(bill) ?? 0.0
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            resultBill = String(format: "%.2f", result)
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.splittedBill = resultBill
            destinationVC.tipPercentage = Int(tip * 100)
            destinationVC.numberOfPeople = numberOfPeople
        }
    }
}

