//
//  ConverterViewController.swift
//  Bagzz
//
//  Created by tasya on 15.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UITextFieldDelegate {
    
    var currency = [Currency]()

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var firstCurrency: UITextField!
    @IBOutlet weak var secondCurrency: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCurrency()
        choiceCurrency()
        createToolbar()
     
    }
    
    
    func loadCurrency() {
        let provider = NetworkService()
        provider.getCurrency(onCompleted: { (currency) in
            self.currency = currency
            print(currency)
        }) { (error) in
            print("error: \(error)")
        }
    }
    
    func choiceCurrency() {
        let firstCurrencyPicker = UIPickerView()
        firstCurrencyPicker.delegate = self
        firstCurrency.inputView = firstCurrencyPicker
        firstCurrencyPicker.tag = 1
        
        let secondCurrencyPicker = UIPickerView()
        secondCurrencyPicker.delegate = self
        secondCurrency.inputView = secondCurrencyPicker
             
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountTextField.resignFirstResponder()
        return true
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem (title: "Done",
                                          style: .plain,
                                          target: self,
                                          action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        firstCurrency.inputAccessoryView = toolbar
        secondCurrency.inputAccessoryView = toolbar
        
        toolbar.tintColor = .black
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

    @IBAction func resultButton(_ sender: Any) {
        var result: Double = 0
        var firstValue = ""
        var secondValue = ""
        
        for i in 0...currency.count-1 {
            if currency[i].name == firstCurrency.text {
                firstValue = currency[i].value
            } else if currency[i].name == secondCurrency.text {
                secondValue = currency[i].value
            }
        }
        
        guard let amount = Double((amountTextField.text!).replacingOccurrences(of: ",", with: ".")),
            let firstValueDouble = Double(firstValue.replacingOccurrences(of: ",", with: ".")),
            let secondValueDouble = Double(secondValue.replacingOccurrences(of: ",", with: ".")) else { return }
        
        result = (amount * firstValueDouble) / secondValueDouble
        
        resultLabel.text = "\(String(format:"%.f", amount)) \(firstCurrency.text!) =\n\(String(format:"%.2f",result)) \(secondCurrency.text!)"
    }
    
}



extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            firstCurrency.text = currency[row].name
        } else {
            secondCurrency.text = currency[row].name
        }
    }
   
}


