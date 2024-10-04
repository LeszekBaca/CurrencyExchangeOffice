//
//  ViewController.swift
//  CurrencyExchangeOffice
//
//  Created by Leszek Baca on 06/09/2024.
//

import UIKit

class ViewController: UIViewController {

let urlString = "https://api.coinbase.com/v2/currencies"
    
   // @IBOutlet weak var myLabel: UILabel!
    var myLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel = UILabel()
        myLabel.text = "Hello"
        
        view.addSubview(myLabel)
        
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel
            .centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myLabel
            .centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myLabel.font = UIFont.systemFont(ofSize: 36)
        
        
        fetchData(from: urlString) { result in
            switch result {
            case .success(let data):
                print(data.data.count)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

