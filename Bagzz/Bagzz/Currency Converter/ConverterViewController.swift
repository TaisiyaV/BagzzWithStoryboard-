//
//  ConverterViewController.swift
//  Bagzz
//
//  Created by tasya on 15.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var currency = [Currency]()
    var selectedCurrency: String?
    
//    @IBOutlet weak var firstCurrency: UILabel!
//    @IBOutlet weak var secondCurrency: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
//    @IBOutlet weak var viewWithPicker: UIView!
    
//    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    @IBOutlet weak var firstCur: UITextField!
    @IBOutlet weak var secondCur: UITextField!
    
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
        firstCur.inputView = firstCurrencyPicker
        firstCurrencyPicker.backgroundColor = .lightGray
        firstCurrencyPicker.tag = 1
        
        let secondCurrencyPicker = UIPickerView()
        secondCurrencyPicker.delegate = self
        secondCur.inputView = secondCurrencyPicker
        secondCurrencyPicker.backgroundColor = .lightGray
             
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
        
        firstCur.inputAccessoryView = toolbar
        secondCur.inputAccessoryView = toolbar
        amountTextField.inputAccessoryView = toolbar
        
        //Castomization
        toolbar.tintColor = .white
        toolbar.barTintColor = .lightGray
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
//    @IBAction func button(_ sender: Any) {
//        viewWithPicker.isHidden = false
//    }
//
//    @IBAction func buttonCur(_ sender: Any) {
//        viewWithPicker.isHidden = false
//    }
    
    @IBAction func resultButton(_ sender: Any) {
    }
    

    
//    private func setupGestures() {
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
//        tapGesture.numberOfTapsRequired = 1
//        button.addGestureRecognizer(tapGesture)
//    }
//
//    @objc
//    private func tapped() {
//        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") else { return }
//        popVC.modalPresentationStyle = .popover
//        let popOverVC = popVC.popoverPresentationController
//        popOverVC?.delegate = self
//        popOverVC?.sourceView = self.button
//        popOverVC?.sourceRect = CGRect(x: self.view.bounds.minX, y: self.view.bounds.minY, width: 0, height: 0)
//        popVC.preferredContentSize = CGSize(width: 300, height: 300)
//
//        self.present(popVC, animated: true, completion: nil)
//
//    }
    



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
            firstCur.text = currency[row].name
        } else {
            secondCur.text = currency[row].name
        }
        
//        selectedCurrency = currency[row].name
////        if let textF
//        firstCur.text = selectedCurrency
//        secondCur.text = selectedCurrency
        
    }
    
    
}




//extension ConverterViewController: UIPopoverPresentationControllerDelegate {
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
//}
