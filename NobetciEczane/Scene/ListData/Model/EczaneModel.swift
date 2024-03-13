//
//  EczaneModel.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//
import Foundation

// MARK: - Eczane
struct Eczane: Codable {
    let success: Bool
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name, dist, address, phone: String
    let loc: String
}

