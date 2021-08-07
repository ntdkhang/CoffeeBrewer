//
//  BrewList.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/17/21.
//

import SwiftUI

struct BrewList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Brew.date_,
                                                     ascending: true)],
                  predicate: nil,
                  animation: .default)
    private var brews: FetchedResults<Brew>
    
    var body: some View {
        List {
            ForEach(brews) { brew in
                VStack(alignment: .leading) {
                    Text("Date: \(brew.date)")
                    Text("Method: \(brew.methodName)")
                    Text("Coffee: \(brew.coffee.brand)'s \(brew.coffee.name)")

                    // TODO: Make a toggle drop down to show this information
                    Text("Process: \(brew.process)")
                    
                    Text("Acidity quality: \(brew.characteristics.acidityQuality)")
                    Text("Acidity quantity: \(brew.characteristics.acidityQuantity)")

                }
            }
            .onDelete(perform: deleteBrew)
        }
        
    }
    
    func deleteBrew(at offsets: IndexSet) {
        for index in offsets {
            let brew = brews[index]
            viewContext.delete(brew)
        }
        
        try? viewContext.save()
    }
}

struct BrewList_Previews: PreviewProvider {
    static var previews: some View {
        BrewList()
    }
}
