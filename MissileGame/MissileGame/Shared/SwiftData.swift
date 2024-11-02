//
//  Locations.swift
//  MissileGame
//
//  Created by Ryder Klein on 11/2/24.
//
import Foundation
import SwiftData
import CoreLocation

class SwiftDataService {
    public static let shared = SwiftDataService()
    private var context = try! SwiftData.ModelContext(ModelContainer(for: AttackLocationModel.self))
    
    func fetchAttackLocations() -> [AttackLocationModel] {
        let fetchDescriptor = FetchDescriptor<AttackLocationModel>()
        return (try? context.fetch(fetchDescriptor)) ?? []
    }
    
    func setAttackLocations(_ modelsToInsert: [AttackLocationModel]) {
        try! context.transaction {
            let attackLocations = fetchAttackLocations()
            for location in attackLocations {
                context.delete(location)
            }
            for modelToInsert in modelsToInsert {
                context.insert(modelToInsert)
            }
        }
    }
}

struct AttackLocationCodable: Codable {
    var id: Int
    var lat: Double
    var long: Double
}

 
@Model class AttackLocationModel {
    var id: Int
    var lat: Double
    var long: Double
    
    init(id: Int, lat: Double, long: Double) {
        self.id = id
        self.lat = lat
        self.long = long
    }
}
