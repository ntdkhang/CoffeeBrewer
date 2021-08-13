////
////  Brew.swift
////  CoffeeBrewer
////
////  Created by Nguyen Tran Duy Khang on 7/5/21.
////
//
//import Foundation
//
//struct Brew: Identifiable, Codable {
//    var methodName: String
//    var coffee: Coffee
//    var characteristics: Characteristics?
//    var note: String?
//    var id: UUID
//
//}
//
//extension Brew {
//    init(methodName: String, coffee: Coffee, characteristics: Characteristics? = nil,
//         note: String? = nil, id: UUID? = nil) {
//        self.methodName = methodName
//        self.coffee = coffee
//        self.characteristics = characteristics
//        self.note = note
//        self.id = id ?? UUID()
//    }
//}


import Foundation

struct BrewSetting: Identifiable, Codable {
    var coffeeInfo: CoffeeInfo
    var coffeeWeight: Int
    var coffeeWaterRate: Int
    var id: UUID
}

extension BrewSetting {
    init(coffeeInfo: CoffeeInfo? = nil, coffeeWeight: Int? = nil, coffeeWaterRate: Int? = nil, id: UUID? = nil) {
        self.coffeeInfo = coffeeInfo ?? CoffeeInfo()
        self.coffeeWeight = coffeeWeight ?? 0
        self.coffeeWaterRate = coffeeWaterRate ?? 0
        self.id = id ?? UUID()
    }
}
