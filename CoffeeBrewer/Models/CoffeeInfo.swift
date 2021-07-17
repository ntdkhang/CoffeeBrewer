//
//  Coffee.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/4/21.
//

import Foundation

public struct CoffeeInfo: Identifiable, Codable {
    var name: String
    var brand: String
    public var id: UUID


}

extension CoffeeInfo {
    init(name: String? = nil, brand: String? = nil, id: UUID? = nil) {
        self.name = name ?? ""
        self.brand = brand ?? ""
        self.id = id ?? UUID()
    }
}

struct CharacteristicsInfo: Codable {
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
