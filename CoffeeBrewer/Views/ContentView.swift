//
//  ContentView.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var navigationController: NavigationController
    var body: some View {
        NavigationView {
            NavigationLink(destination: BrewV60(),
                            isActive: $navigationController.showMenu,
                            label: { Text("Brew V60") })
        }
    }

    
}

class NavigationController: ObservableObject {
    @Published var showMenu: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
