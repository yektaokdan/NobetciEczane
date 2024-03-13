//
//  ListViewModel.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import Foundation

class ListViewModel {
    private var eczaneDataService = EczaneDataService()
    var eczaneler: [Result] = [] // API'den çekilen eczaneleri saklamak için kullanılacak
    
    // API'den eczane bilgilerini çeken fonksiyon
    func fetchPharmacies(city: String, district: String, completion: @escaping () -> Void) {
        eczaneDataService.fetchPharmacies(forCity: city, district: district) { [weak self] response in
            DispatchQueue.main.async {
                if let eczaneler = response?.result {
                    self?.eczaneler = eczaneler
                    completion()
                } else {
                    self?.eczaneler = []
                    completion()
                }
            }
        }
    }
    
    // Eczaneler listesinin boyutunu döndüren fonksiyon
    func numberOfItemsInSection() -> Int {
        return eczaneler.count
    }
    
    // Belirli bir index'teki eczane bilgisini döndüren fonksiyon
    func eczaneAtIndex(_ index: Int) -> Result? {
        if index >= 0 && index < eczaneler.count {
            return eczaneler[index]
        }
        return nil
    }
}

