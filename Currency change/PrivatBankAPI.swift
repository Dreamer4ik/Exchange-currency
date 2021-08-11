//
//  PrivatBankAPI.swift
//  Currency change
//
//  Created by Ivan Potapenko on 30.07.2021.
//

import Foundation

enum Rate {
    case cash
    case cashless
}

 class PrivatBankAPI {
   static let shared = PrivatBankAPI()
    
    
    
    func fetchExchangeRatesJSONWith(_ rate: Rate, completion: @escaping (Result<[Currency],Error>) -> ()) {
        let urlString: String!
        
        switch rate {
        case .cash:
            urlString = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
        case .cashless:
            urlString = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=11"
        }
            
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let currencies = try JSONDecoder().decode([Currency].self, from: data!)
                completion(.success(currencies))
            }
            
            catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
