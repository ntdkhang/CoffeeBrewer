//
//  CoffeeBrewerApp.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI

@main
struct CoffeeBrewerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            CoffeeList()
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(NavigationController())
                .preferredColorScheme(.dark)
        }
    }
}
