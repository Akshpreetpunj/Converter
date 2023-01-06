//  I, Akshpreet Singh Punj, student number 000820040, certify that this material is my original work.
//  No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.
//
//  TemperatureViewController.swift
//  Converter
//
//  Created by Akshpreet Singh Punj on 2022-10-02.
//

import UIKit

class TemperatureViewController: UIViewController, UITextFieldDelegate {

    // temperatureTextField outlet for the text field to store the input from the user
    @IBOutlet var temperatureTextField: UITextField!
    
    // outputLabel outlet for the label to display the result to the user
    @IBOutlet var outputLabel: UILabel!
    
    // celsiusInput variable is a variable with unit type temperature
    // measurement to store the input from the user as a celsius value
    var celsiusInput: Measurement<UnitTemperature>?
    
    // fahrenheitValue is a variable with unit type temperature
    // measurement to return the fahrenheit value from the celsiusInput value
    var fahrenheitValue: Measurement<UnitTemperature>? {
        if let celsiusInput = celsiusInput {
            return celsiusInput.converted(to: .fahrenheit)
        } else {
            return nil
        }
    }
    
    // fahrenheitInput variable is a variable with unit type temperature
    // measurement to store the input from the user as a fahrenheit value
    var fahrenheitInput: Measurement<UnitTemperature>?
    
    // celsiusValue is a variable with unit type temperature
    // measurement to return the celsius value from the fahrenheitInput value
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitInput = fahrenheitInput {
            return fahrenheitInput.converted(to: .celsius)
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
    
    /// This action method convert the input celsius value to fahrenheit value when the user touch the Convert °C to °F button
    /// - Parameter sender: Convert °C to °F button
    @IBAction func conversionCelsiusToFahrenheit(_ sender: UIButton) {
        // Checking if the text field has a value and if it does convert the value into double
        if let text = temperatureTextField.text, let value = Double(text) {
            // Storing the the converted double value in the celsiusInput variable as celsius unit
            celsiusInput = Measurement(value: value, unit: .celsius)
        } else {
            // Storing nil as the value in the celsiusInput variable if the input
            // text field does not hold valid input
            celsiusInput = nil
        }
        
        // Checking if the fahrenheitValue hold the converted value from the celsiusInput and celsiusInput
        // hold the input value
        if let fahrenheitValue = fahrenheitValue, let celsiusInput = celsiusInput {
            // printing the output result with the number formatter
            outputLabel.text = numberFormatter.string(from: NSNumber(value: celsiusInput.value))! + "°C is " +
                               numberFormatter.string(from: NSNumber(value: fahrenheitValue.value))! + "°F"
        } else {
            // printing the error message to the user if the input cannot be converted to the usable double
            outputLabel.text = "Unable to convert \(temperatureTextField.text!)"
        }
    }
    
    /// This action method convert the input fahrenheit value to celsius value when the user touch the Convert °F to °C button
    /// - Parameter sender: Convert °F to °C button
    @IBAction func converionFahrenheitToCelsius(_ sender: UIButton) {
        // Checking if the text field has a value and if it does convert the value into double
        if let text = temperatureTextField.text, let value = Double(text) {
            // Storing the the converted double value in the fahrenheitInput variable as fahrenheit unit
            fahrenheitInput = Measurement(value: value, unit: .fahrenheit)
        } else {
            // Storing nil as the value in the fahrenheitInput variable if the input
            // text field does not hold valid input
            fahrenheitInput = nil
        }
        
        // Checking if the celsiusValue hold the converted value from the fahrenheitInput and fahrenheitInput
        // hold the input value
        if let celsiusValue = celsiusValue, let fahrenheitInput = fahrenheitInput {
            // printing the output result with the number formatter
            outputLabel.text = numberFormatter.string(from: NSNumber(value: fahrenheitInput.value))! + "°F is " +
                               numberFormatter.string(from: NSNumber(value: celsiusValue.value))! + "°C"
        } else {
            // printing the error message to the user if the input cannot be converted to the usable double
            outputLabel.text = "Unable to convert \(temperatureTextField.text!)"
        }
    }
    
    /// This action method allow the user to dismiss the keyboard by tapping the background
    /// - Parameter sender: Gesture recognizer
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        temperatureTextField.resignFirstResponder()
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
