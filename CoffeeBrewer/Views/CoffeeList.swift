//
//  CoffeeGroundsList.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/13/21.
//

import SwiftUI

struct CoffeeList: View {
    @Environment(\.managedObjectContext) private var context
    @State var coffees: [Coffee]
    @State var filterBrand: String = ""
    @State var predicate: NSPredicate?
    @State var brands: [String]
    
    
    var body: some View {
        VStack {
            Menu(content: {
                ForEach(brands, id: \.self) { brand in
                    Button("\(brand)", action: { filterBrand = brand })
                }
            }, label: {
                Text("Filter Brand")
            })
            
            Text("\(filterBrand)")
            
            List {
                ForEach(coffees) { coffee in
                    Text("\(coffee.name)")
                    Text("\(coffee)")
                }.onDelete(perform: { deleteItems(offsets: $0)} )
            }
        }
        .onAppear {
            fetchCoffees()
            brands = uniqueBrands()
        }
        .onChange(of: filterBrand) { _ in
            if filterBrand != "" {
                predicate = NSPredicate(format: "brand_ = %@", filterBrand)
                fetchCoffees()
            }
        }
    }
    
    init() {
        coffees = []
        filterBrand = ""
        predicate = nil
        brands = []
    }
    
    func fetchCoffees() {
        let fetchRequest = Coffee.fetchRequest()
        if predicate != nil {
            fetchRequest.predicate = predicate
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Coffee.brand_,
                                                         ascending: true)]
        coffees = try! context.fetch(fetchRequest)
        
    }
    
    private func uniqueBrands() -> [String] {
        var brands = Set<String>()
        let _ = coffees.map { brands.insert($0.brand) }
        return Array(brands)
    }
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { coffees[$0] }.forEach(context.delete)

            do {
                try context.save()
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
