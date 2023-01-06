//  I, Akshpreet Singh Punj, student number 000820040, certify that this material is my original work.
//  No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.
//
//  DistanceViewController.swift
//  Converter
//
//  Created by Akshpreet Singh Punj on 2022-10-06.
//

import UIKit

class DistanceViewController: UIViewController, UITextFieldDelegate {

    // distanceTextField outlet for the text field to store the input from the user
    @IBOutlet var distanceTextField: UITextField!
    
    // outputLabel outlet for the label to display the result to the user
    @IBOutlet var outputLabel: UILabel!
    
    // kilometresInput variable is a variable with unit type length
    // measurement to store the input from the user as a Kilometres value
    var kilometresInput: Measurement<UnitLength>?
    
    // milesValue is a variable with unit type length
    // measurement to return the Miles value from the kilometresInput value
    var milesValue: Measurement<UnitLength>? {
        if let kilometresInput = kilometresInput {
            return kilometresInput.converted(to: .miles)
        } else {
            return nil
        }
    }
    
    // milesInput variable is a variable with unit type length
    // measurement to store the input from the user as a miles value
    var milesInput: Measurement<UnitLength>?
    
    // kilometresValue is a variable with unit type length
    // measurement to return the Kilometers value from the milesInput value
    var kilometresValue: Measurement<UnitLength>? {
        if let milesInput = milesInput {
            return milesInput.converted(to: .kilometers)
        } else {
            return nil
        }
    }
        
    // numberFormatter is a variable for the Number formatter class
    // to format the output correctly with minimum and maximum fraction digits
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 1
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // viewDidLoad method runs when the application starts
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLabel.text = ""
    }
    
    /// This action method convert the input Kilometres value to Miles value when the user touch the Convert Kilometres to Miles button
    /// - Parameter sender: Convert Kilometres to Miles button
    @IBAction func conversionKilometresToMiles(_ sender: UIButton) {
        // Checking if the text field has a value and if it does convert the value into double
        if let text = distanceTextField.text, let value = Double(text) {
            // Storing the the converted double value in the kilometresInput variable as kilometers unit
            kilometresInput = Measurement(value: value, unit: .kilometers)
        } else {
            // Storing nil as the value in the kilometresInput variable if the input
            // text field does not hold valid input
            kilometresInput = nil
        }
        
        // Checking if the milesValue hold the converted value from the kilometresInput and kilometresInput
        // hold the input value
        if let milesValue = milesValue, let kilometresInput = kilometresInput {
            // printing the output result with the number formatter
            outputLabel.text = numberFormatter.string(from: NSNumber(value: kilometresInput.value))! + " Km is " +
                               numberFormatter.string(from: NSNumber(value: milesValue.value))! + " Miles"
        } else {
            // printing the error message to the user if the input cannot be converted to the usable double
            outputLabel.text = "Unable to convert \(distanceTextField.text!)"
        }
    }
    
    /// This action method convert the input Miles value to Kilometres value when the user touch the Convert Miles to Kilometres button
    /// - Parameter sender: Convert Miles to Kilometres button
    @IBAction func conversionMilesToKilometres(_ sender: UIButton) {
        // Checking if the text field has a value and if it does convert the value into double
        if let text = distanceTextField.text, let value = Double(text) {
            // Storing the the converted double value in the milesInput variable as miles unit
            milesInput = Measurement(value: value, unit: .miles)
        } else {
            // Storing nil as the value in the milesInput variable if the input
            // text field does not hold valid input
            milesInput = nil
        }
        
        // Checking if the kilometresValue hold the converted value from the milesInput and milesInput
        // hold the input value
        if let kilometresValue = kilometresValue, let milesInput = milesInput {
            // printing the output result with the number formatter
            outputLabel.text = numberFormatter.string(from: NSNumber(value: milesInput.value))! + " Miles is " +
                               numberFormatter.string(from: NSNumber(value: kilometresValue.value))! + " Km"
        } else {
            // printing the error message to the user if the input cannot be converted to the usable double
            outputLabel.text = "Unable to convert \(distanceTextField.text!)"
        }
    }
    
    /// This action method allow the user to dismiss the keyboard by tapping the background
    /// - Parameter sender: Gesture recognizer
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        distanceTextField.resignFirstResponder()
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
