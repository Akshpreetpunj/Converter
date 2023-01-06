//  I, Akshpreet Singh Punj, student number 000820040, certify that this material is my original work.
//  No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.
//
//  CurrencyViewController.swift
//  Converter
//
//  Created by Akshpreet Singh Punj on 2022-10-06.
//

import UIKit

class CurrencyViewController: UIViewController, UITextFieldDelegate {

    // amountTextField outlet for the text field to store the input from the user
    @IBOutlet var amountTextField: UITextField!
    
    // outputLabel outlet for the label to display the result to the user
    @IBOutlet var outputLabel: UILabel!
    
    // numberFormatter is a variable for the Number formatter class
    // to format the output correctly with minimum and maximum fraction digits
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    // viewDidLoad method runs when the application starts
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = ""
    }
    
    /// This action method convert the input canadian dollar currency value to united states dollar currency value
    /// when the user touch the Convert CAD to USD button
    /// - Parameter sender: Convert CAD to USD button
    @IBAction func conversionCadToUsd(_ sender: UIButton) {
        // Checking if the text field has a value and if it does convert the value into double
        if let text = amountTextField.text, let value = Double(text) {
            // printing the output result with the number formatter
            outputLabel.text = "$" + numberFormatter.string(from: NSNumber(value: Double(text)!))! +
            " CAD is $" + numberFormatter.string(from: NSNumber(value: value * 0.72956796))! + " USD"
        } else {
            // printing the error message to the user if the input cannot be converted to the usable double
            outputLabel.text = "Unable to convert \(amountTextField.text!)"
        }
    }

    /// This action method convert the input united states dollar currency value to canadian dollar currency value
    /// when the user touch the Convert USD to CAD button
    /// - Parameter sender: Convert USD to CAD button
    @IBAction func conversionUsdToCad(_ sender: UIButton) {
        // Checking if the text field has a value and if it does convert the value into double
        if let text = amountTextField.text, let value = Double(text) {
            // printing the output result with the number formatter
            outputLabel.text = "$" + numberFormatter.string(from: NSNumber(value: Double(text)!))! +
            " USD is $" + numberFormatter.string(from: NSNumber(value: value / 0.72956796))! + " CAD"
        } else {
            // printing the error message to the user if the input cannot be converted to the usable double
            outputLabel.text = "Unable to convert \(amountTextField.text!)"
        }
    }
    
    /// This action method allow the user to dismiss the keyboard by tapping the background
    /// - Parameter sender: Gesture recognizer
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountTextField.resignFirstResponder()
    }
    
    // The textField is a method which allows the user to input the decimal only once in the input value
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
       
        // Checking if there is already a decimal in the input value, if there is a decimal value
        // reject the next coming decimal in the input value
        if existingTextHasDecimalSeparator != nil,
           replacementTextHasDecimalSeparator != nil {
           return false
        } else {
           return true
       }
    }
}
