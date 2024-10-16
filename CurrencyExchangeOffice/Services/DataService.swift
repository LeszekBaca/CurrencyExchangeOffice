//
//  DataService.swift
//  CurrencyExchangeOffice
//
//  Created by Leszek Baca on 06/09/2024.
//

import Foundation

func fetchData(from urlString: String, completion: @escaping (Result<MainModel, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure("Invalid URL" as! Error))
        return
    }
    // URLSession.shared.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, (any Error)?) -> Void#>)

    let completionHandler: ((Data?, URLResponse?, (any Error)?) -> Void) = {
        data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        // Check if the answer is correct and the data is available
        guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completion(.failure("Invalid response or data" as! Error))
            return
        }
        do {
            let decoder = JSONDecoder()
            let dataModel = try decoder.decode(MainModel.self, from: data)
            completion(.success(dataModel))
        } catch {
            completion(.failure(error))
        }
    }

    // Creating URLSession
    let task = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
    task.resume()
}
