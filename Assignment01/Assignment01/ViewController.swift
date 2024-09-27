//
//  ViewController.swift
//  Assignment01
//
//  Created by Nikunj Patel on 2024-09-27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtHeightInch: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    @IBOutlet weak var measureSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlaceholders()
    }
    
    @IBAction func measureSys(_ sender: UISwitch) {
        txtHeight.text = ""
        txtHeightInch.text = ""
        txtWeight.text = ""
        
        displayLabel.text = ""
        statsLabel.text = ""
        
        updatePlaceholders()
    }
    
    private func updatePlaceholders() {
        if measureSwitch.isOn {
            txtHeight.placeholder = "cm"
            txtHeightInch.isHidden = true
            txtWeight.placeholder = "kg"
        } else {
            txtHeight.placeholder = "ft"
            txtHeightInch.isHidden = false
            txtWeight.placeholder = "lb"
        }
    }
    
    @IBAction func btnCalculate(_ sender: UIButton) {
        guard let heightText = txtHeight.text, !heightText.isEmpty,
              let weightText = txtWeight.text, !weightText.isEmpty else {
            statsLabel.text = "Please enter height and weight."
            return
        }
        
        guard let height = Double(heightText), height > 0,
              let weight = Double(weightText), weight > 0 else {
            statsLabel.text = "Invalid input. Height and weight must be positive numbers."
            return
        }
        
        var bmi: Double
        
        if measureSwitch.isOn {
            bmi = weight / ((height / 100) * (height / 100))
        } else {
            guard let heightInchText = txtHeightInch.text, !heightInchText.isEmpty,
                  let heightInch = Double(heightInchText), heightInch >= 0 else {
                statsLabel.text = "Please enter height in inches."
                return
            }
            let totalHeightInInches = (height * 12) + heightInch
            bmi = (weight / (totalHeightInInches * totalHeightInInches)) * 703
        }
        
        displayLabel.text = String(format: "%.2f", bmi)
        statsLabel.text = bmiCategory(bmi: bmi)
    }
    
    private func bmiCategory(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Category: Underweight"
        case 18.5..<24.9:
            return "Category: Normal weight"
        case 25..<29.9:
            return "Category: Overweight"
        case 30...:
            return "Category: Obesity"
        default:
            return "Category: Unknown"
        }
    }
}
