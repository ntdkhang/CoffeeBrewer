//
//  CoffeeChooser.swift
//  CoffeeChooser
//
//  Created by Nguyen Tran Duy Khang on 8/9/21.
//

import SwiftUI



struct CoffeeChooser: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Coffee.brand_, ascending: true)],
        animation: .default)
    private var coffees: FetchedResults<Coffee>
    
    @State private var name: String = ""
    @State private var brand: String = ""
    @Binding var coffeeInfo: CoffeeInfo
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button("Done") {
                    if !(name.isEmpty && brand.isEmpty) {
                        coffeeInfo.name = name
                        coffeeInfo.brand = brand
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }.padding()
//            Spacer()
            Form {
                Section(header: Text("New Coffee")) {
                    TextField("Name", text: $name)
                    
                    TextField("Brand", text: $brand)
                }
                
                Section(header: Text("Choosee Existing Coffee")) {
                    ForEach(coffees, id: \.id_) { existingCoffee in
                        
                        Text("\(existingCoffee.brand )'s \(existingCoffee.name)")
                            .onTapGesture {
                                coffeeInfo = existingCoffee.coffeeInfo
                                presentationMode.wrappedValue.dismiss()
                            }
                        // TODO: long press gives a preview of the
                        // most recent (or average) characteristics.
                            .onLongPressGesture(perform: {})
                    }
                }
            }
            
        }
    }
}


//struct CoffeeChooser_Previews: PreviewProvider {
//    static var previews: some View {
//        CoffeeChooser()
//    }
//}
