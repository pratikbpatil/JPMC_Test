//
//  PlanetModel.swift
//  JPMC_Pratik
//
//  Created by Pratik Patil on 20/05/23.
//

import Foundation

// Creating Planet Server Model with Codable
struct PlanetServerModel : Codable {
    let name : String
//    let rotation_period : String
    
    static let db = DatabaseHandler.shared
    // Storing the data to Core data
    func store() {
        guard let planet = PlanetServerModel.db.addToCoreData(Planet.self) else {return}
        planet.name = name
        PlanetServerModel.db.saveToCoreData()
    }
} 
