//
//  CoffeeGroundsList.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/13/21.
//

import SwiftUI

struct CoffeeList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Coffee.name_, ascending: true)], predicate: nil, animation: .default)
    private var coffees: FetchedResults<Coffee>
    
    
    var body: some View {
        VStack {
//            Button("add new item") {
//                addItem()
//            }
            Button(action: {},
                   label: { Text("Filter") })
            List {
                ForEach(coffees) { coffee in
                    Text("\(coffee.name)")
                }.onDelete(perform: { deleteItems(offsets: $0)} )
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newCoffee = Coffee(context: viewContext)
            newCoffee.name = "BlaBlo \(Int.random(in: 0...100))"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { coffees[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CoffeeList_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
