//
// ViewController.swift
// CurrencyExchangeOffice
//
// Created by Leszek Baca on 06/09/2024.
//
import UIKit

final class ViewController: UIViewController {
    // @IBOutlet var picker: UIPickerView!
    var tableView: UITableView!
    let urlString = "https://api.coinbase.com/v2/currencies"
    var dataModels: [DataModel] = []
    var myLabel: UILabel!

    // MARK: - View lifecycle

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

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        tableView.dataSource = self
        tableView.delegate = self

        fetchData(from: urlString) {
            [weak self]
            result in
            DispatchQueue.main.async {
                switch result {
                case let .success(dataModel):
                    self?.dataModels = dataModel.data
                    // self.pickerView.reloadAllComponents()
                    self?.tableView.reloadData()
                    self?.myLabel.text = "Liczba walut: \(dataModel.data.count)"
                case let .failure(error):
                    self?.myLabel.text = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "testVC")
        vc.navigationItem.title = dataModels[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedCurrency = dataModels[indexPath.row]
        // myLabel.text = "ID: \(selectedCurrency.id), Min Size: \(selectedCurrency.min_size)"
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = selectedCurrency.name
        // cell.selectionStyle = .none
        return cell
    }
}

final class CustomTableViewCell: UITableViewCell {
    let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        // Add customLabel to the contentView
        contentView.addSubview(customLabel)

        // Set up constraints for the label
        NSLayoutConstraint.activate([
            customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    // Configure the cell with data
    func configure(with text: String) {
        customLabel.text = text
    }
}
