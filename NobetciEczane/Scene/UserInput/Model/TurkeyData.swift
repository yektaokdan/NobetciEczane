import Foundation

// MARK: - TurkeyData
struct TurkeyData: Codable {
    let status: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name: String
    let population, area, altitude: Int
    let areaCode: [Int]
    let isMetropolitan: Bool
    let nuts: Nuts
    let coordinates: Coordinates
    let maps: Maps
    let region: Region
    let districts: [District]
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - District
struct District: Codable {
    let id: Int
    let name: String
    let population, area: Int
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMap: String
}

// MARK: - Nuts
struct Nuts: Codable {
    let nuts1: Nuts1
    let nuts2: Nuts2
    let nuts3: String
}

// MARK: - Nuts1
struct Nuts1: Codable {
    let code: String
    let name: Region
}

// MARK: - Region
struct Region: Codable {
    let en, tr: String
}

// MARK: - Nuts2
struct Nuts2: Codable {
    let code, name: String
}
