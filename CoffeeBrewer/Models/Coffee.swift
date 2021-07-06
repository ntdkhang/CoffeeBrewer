//
//  Coffee.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/4/21.
//

import Foundation

struct Coffee: Identifiable, Codable {
    var name: String
    var brand: String
    var characteristics: Characteristics?
    var id: UUID
    
    
}

extension Coffee {
    init(name: String? = nil, brand: String? = nil, characteristics: Characteristics? = nil, id: UUID? = nil) {
        self.name = name ?? "No name"
        self.brand = brand ?? "No brand"
        self.characteristics = characteristics
        self.id = id ?? UUID()
    }
}

struct Characteristics: Codable {
    var aroma: Grading
    var acidity: Grading
    var sweetness: Grading
    var body: Grading
    var finish: Grading
    var flavour: String
}

struct Grading: Codable {
    private(set) var quantity: Int
    private(set) var quality: Int
//    var note: String?
    
//    init?(quantity: Int, quality: Int, note: String?) {
//        guard (0...10).contains(quantity), (0...10).contains(quality) else {
//            return nil
//        }
//        self.quantity = quantity
//        self.quality = quality
//        self.note = note
//    }
    init(quantity: Int, quality: Int) {
        self.quantity = quantity
        self.quality = quality
    }
    
}
