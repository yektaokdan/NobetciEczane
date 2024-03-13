//
//  EczaneDataService.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import Foundation

class EczaneDataService {
    func fetchPharmacies(forCity city: String, district: String, completion: @escaping (Eczane?) -> Void) {
        let baseURL = "https://api.collectapi.com/health/dutyPharmacy"
        var components = URLComponents(string: baseURL)!
        
        // İl ve ilçe bilgilerini URL'ye ekle
        components.queryItems = [
            URLQueryItem(name: "il", value: city),
            URLQueryItem(name: "ilce", value: district)
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        // Header bilgilerini ekleyin
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("apikey 6dYXPWdvMYYCS0Sn0Cy1so:1JI2YNaodPYO0tHUzWVfuU", forHTTPHeaderField: "authorization") // CollectAPI API anahtarınızı buraya ekleyin
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let eczaneData = try JSONDecoder().decode(Eczane.self, from: data)
                completion(eczaneData)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
