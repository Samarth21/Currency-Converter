//
//  ViewController.swift
//  Samarth_Patel_Currency_Conversion
//
//  Created by Samarth Patel on 2019-07-17.
//  Copyright © 2019 Samarth Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
//MARK:Outlets
    @IBOutlet weak var fromAmount: UITextField!
    @IBOutlet weak var toAmount: UITextField!
    @IBOutlet weak var fromCurrencyName: UILabel!
    @IBOutlet weak var toCurrencyName: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var conversionModel = CurrencyConversionModel()
    var fromIndex = 0
    var toIndex = 0
    var exchangeRate = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        pickerView(currencyPicker, didSelectRow: 0, inComponent: 0)
    }
    
    
    //MARK: UIPickerViewerDataSource functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversionModel.listOfCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return conversionModel.listOfCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected \(row) in \(component)")
        if(component == 0){
            fromIndex = row
        }
        else{
            toIndex = row
        }
        
        let fromCurrency = conversionModel.listOfCurrencies[fromIndex]
        let toCurrency = conversionModel.listOfCurrencies[toIndex]
        
        fromCurrencyName.text = conversionModel.currencyNames[fromCurrency]
        toCurrencyName.text = conversionModel.currencyNames[toCurrency]
        
        print("convert from \(fromCurrency) to \(toCurrency)")
        conversionModel.updateExchangeRate(self, fromCurrency, toCurrency)
    }
    
    func updateConvertedAmount(exchangeRate : Double){
        self.exchangeRate = exchangeRate
        DispatchQueue.main.async {
            var amountToShow = exchangeRate
            if let amount = self.fromAmount.text{
                if let amountNumber = Double(amount){
                    amountToShow = amountNumber * exchangeRate
                }
            }
            
            self.toAmount.text = String(amountToShow)
        }
    }

    @IBAction func amountChanged(_ sender: Any) {
        updateConvertedAmount(exchangeRate: exchangeRate)
    }
    
}

