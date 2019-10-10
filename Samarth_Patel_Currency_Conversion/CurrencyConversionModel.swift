//
//  CurrencyConversionModel.swift
//  Samarth_Patel_Currency_Conversion
//
//  Created by Samarth Patel on 2019-07-17.
//  Copyright © 2019 Samarth Patel. All rights reserved.
//

import Foundation

class CurrencyConversionModel{
    
    var listOfCurrencies = ["INR", "CAD", "USD", "GBP", "EUR", "OMR", "KRW", "TRY"]
    
    var currencyNames: [String: String] = [
    "INR" :"Indian Rupee",
    "CAD" :"Canadian Dollar",
    "USD" :"US Dollar",
    "GBP" :"British Pound",
    "EUR" :"Euro",
    "OMR" :"Omani Riyal",
    "KRW" :"Korean Won",
    "TRY" :"Turkish Lira"]
    
    let API_BASE_URL = "https://api.exchangeratesapi.io/latest?"
    
    func updateExchangeRate(_ viewController : ViewController, _ fromCurrency: String,_ toCurrency: String){
        print("make api call here")
        
        let api_url = API_BASE_URL + "base=" + fromCurrency + "&symbols=" + toCurrency
        
        print(api_url)
        
        if let url = URL(string: api_url){
            let dataTask = URLSession.shared.dataTask(with: url) {
                data, response, error in
                if let dataReceived = data{
                let jsonString = String(data: dataReceived, encoding: .utf8)
                
                print("received \(jsonString)")
                    
                    do{
                    let json = try JSON(data: dataReceived)
                        
                        if let exchangeRate =
                            json["rates"][toCurrency].double {
                            //do something with the exchange rate
                            print("rate is \(exchangeRate)")
                            
                            viewController.updateConvertedAmount(exchangeRate: exchangeRate)
                        }
                        
                    }catch let err {
                        print("failed to create JSON object, \(err)")
                    }
                }
            }
            
            dataTask.resume()
        }
    }
}
