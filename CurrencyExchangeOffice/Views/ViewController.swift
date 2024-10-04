//
//  ViewController.swift
//  CurrencyExchangeOffice
//
//  Created by Leszek Baca on 06/09/2024.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let urlString = "https://api.coinbase.com/v2/currencies"
    var dataModels: [DataModel] = []
    var myLabel: UILabel!
    var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel = UILabel()
        view.addSubview(myLabel)
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel
            .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLabel
            .centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myLabel.font = UIFont.systemFont(ofSize: 36)
        
        
        // Initialization UIPickerView
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        // Setting restrictions
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20).isActive = true
        pickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        fetchData(from: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dataModel):
                    self.dataModels = dataModel.data
                    self.pickerView.reloadAllComponents()
                    self.myLabel.text = "Liczba walut: \(dataModel.data.count)"
                case .failure(let error):
                    self.myLabel.text = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataModels.count // Number of currencies
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataModels[row].name // Display currency name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = dataModels[row]
        myLabel.text = "ID: \(selectedCurrency.id), Min Size: \(selectedCurrency.min_size)"
    }
}

