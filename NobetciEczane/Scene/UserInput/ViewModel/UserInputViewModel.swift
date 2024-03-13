//
//  UserInputViewModel.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import Foundation

class UserInputViewModel {
    // Tüm Türkiye verisini saklamak için bir değişken
    private var turkeyData: TurkeyData?
    
    // Kullanıcı tarafından seçilen ilin index'ini saklamak için bir değişken
    private var selectedProvinceIndex: Int?
    
    // ViewModel initializer'ı güncellemesi
    init(turkeyData: TurkeyData) {
        self.turkeyData = turkeyData
    }
    
    // İllerin isimlerini döndüren bir fonksiyon
    func provinces() -> [String] {
        return turkeyData?.data.map { $0.name } ?? []
    }
    
    // Seçilen ilin index'ine göre ilçeleri döndüren bir fonksiyon
    func districtsForSelectedProvince() -> [String] {
        guard let index = selectedProvinceIndex, let districts = turkeyData?.data[index].districts else {
            return []
        }
        return districts.map { $0.name }
    }
    
    // Kullanıcı tarafından bir il seçildiğinde bu ilin index'ini güncelleyen bir fonksiyon
    func selectProvince(at index: Int) {
        self.selectedProvinceIndex = index
    }
}

