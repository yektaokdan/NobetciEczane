//
//  TurkeyDataService.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import Foundation

class TurkeyDataService {
    func fetchTurkeyData(completion: @escaping (TurkeyData?) -> Void) {
        guard let url = URL(string: Constants.url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(TurkeyData.self, from: data)
                completion(decodedData)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

