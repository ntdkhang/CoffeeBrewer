//
//  CoffeeBrewerApp.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI

@main
struct CoffeeBrewerApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                BrewV60()
            }
            .preferredColorScheme(.dark)
        }
    }
}
