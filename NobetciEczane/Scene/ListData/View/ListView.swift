//
//  ListView.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import UIKit

class ListView: UIViewController {
    
    var selectedProvince: String?
    var selectedDistrict: String?
    var viewModel = ListViewModel()
    var eczaneler: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Seçilen İl: \(selectedProvince ?? "Bilgi yok")")
        print("Seçilen İlçe: \(selectedDistrict ?? "Bilgi yok")")

        if let province = selectedProvince, let district = selectedDistrict {
            viewModel.fetchPharmacies(city: province, district: district) {
                self.eczaneler = self.viewModel.eczaneler
                
                for eczane in self.eczaneler {
                    print("Eczane Adı: \(eczane.name)")
                    print("Adres: \(eczane.address)")
                    print("Telefon: \(eczane.phone)")
                    print("------------------------------")
                }

            }
        }
    }

    
}
