//
// ViewController.swift
// CurrencyExchangeOffice
//
// Created by Leszek Baca on 06/09/2024.
//
import UIKit
//class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
class ViewController: UIViewController {
  //@IBOutlet var picker: UIPickerView!
  weak var tableView: UITableView!
  let urlString = "https://api.coinbase.com/v2/currencies"
  var dataModels: [DataModel] = []
  var myLabel: UILabel!
  var pickerView: UIPickerView!
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
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
    //uitableview lub colectonview
    //prezentacja nowego view controlera
    //obsluga bledow sieciowych i nie tylko
    //testy jednostkowy sprawdzajacy mapowanie jesona ()
    //budowanie widoku z storyboard (autolayout uistackview uiimage)
    // Initialization UIPickerView
    //    pickerView = UIPickerView()
    //    pickerView.delegate = self
    //    pickerView.dataSource = self
    //    pickerView.translatesAutoresizingMaskIntoConstraints = false
    //    view.addSubview(pickerView)
    // Setting restrictions
    //    pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //    pickerView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20).isActive = true
    //    pickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    fetchData(from: urlString) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let dataModel):
          self.dataModels = dataModel.data
          // self.pickerView.reloadAllComponents()
          self.myLabel.text = "Liczba walut: \(dataModel.data.count)"
        case .failure(let error):
          self.myLabel.text = "Error: \(error.localizedDescription)"
        }
      }
    }
  }
  var ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInComponent component: Int) -> Int {
      return dataModels.count // Number of currencies
    }
    func tableView(_ pickerView: UITableView, didSelectRow row: Int) -> UITableViewCell {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "testVC")
      vc.navigationItem.title = dataModels[row].name
      navigationController?.pushViewController(vc, animated: true)
      let selectedCurrency = dataModels[row]
      //myLabel.text = "ID: \(selectedCurrency.id), Min Size: \(selectedCurrency.min_size)"
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: row)
      cell.textLabel?.text = dataModels[row].name
      //cell.selectionStyle = .none
      return cell
    }
  }
  //  func numberOfComponents(in pickerView: UIPickerView) -> Int {
  //    return 1 // Number of columns
  //  }
  //
  //  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
  //    return dataModels.count // Number of currencies
  //  }
  //
  //  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  //    return dataModels[row].name // Display currency name
  //  }
  //  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let vc = storyboard.instantiateViewController(withIdentifier: "testVC")
  //    vc.navigationItem.title = dataModels[row].name
  //    navigationController?.pushViewController(vc, animated: true)
  //
  //    let selectedCurrency = dataModels[row]
  //    myLabel.text = "ID: \(selectedCurrency.id), Min Size: \(selectedCurrency.min_size)"
  //  }
}
