//
//  BrewV60.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI
import CoreData
import Combine

struct BrewV60: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Coffee.name_, ascending: true)],
        animation: .default)
    private var coffees: FetchedResults<Coffee>
    @State var coffeeInfo = CoffeeInfo()
    @State var showCoffeeChooser: Bool = false
    @State var startBrewing: Bool = false
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        showCoffeeChooser = true
                    },     label: {
                        ZStack {
                            Text("Choose Coffee").font(.system(size: 25))
                        }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                        
                    Button(action: {
                        // TODO: Save previous setting to user defaults
                        // and load it here.
                    },     label: {
                        ZStack {
                            Text("Previous Setting").font(.system(size: 25))
                        }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                }
                .padding()
                .popover(isPresented: $showCoffeeChooser) {
                                CoffeeChooser(coffeeInfo: $coffeeInfo)
                                    .environment(\.managedObjectContext, viewContext)
                }
                Spacer()
            }
            
        
//            Spacer()
            
            
            
            // MARK: - Coffee & water measurement
            CoffeeMeasurements()
            
            
            Spacer()
            
            if startBrewing == true {
                BrewProcess(coffeeInfo: coffeeInfo)
            } else {
                Button(action: {startBrewing = true },
                       label: { Text("Start Brewing") })
            }
            
        }
        .navigationTitle("V60")
    }
}



struct CoffeeMeasurements: View {
    @State var coffeeWeight: Double = 1
//    @State var water: Double = 1
    @State var rate: Double = 15
    
    
    var body: some View {
        VStack {
            Text("Coffee Weight")
            Text("\(Int(coffeeWeight)) g")
                .font(.body.monospacedDigit())
            Slider(value: $coffeeWeight, in: 5...70, step: 1)
            HStack(alignment: .top){
                VStack {
                    Text("Coffee : Water")
                    Text("    1 : \(Int(rate))")
                        .font(Font.body.monospacedDigit())
                    Slider(value: $rate, in: 10...25, step: 1)
                    
                }.padding()

                Spacer()

                // MARK: - Water
                VStack {
                    Text("Total water weight")
                    Text("\(waterWeight) g")
                        .font(.body.monospacedDigit())
                }
                .padding()
            }
        }
    }
    
    var waterWeight: Int {
        Int(coffeeWeight * rate)
    }

    
    
//    var body: some View {
//        VStack {
//            Text("Coffee : Water")
//            Text("    1 : \(Int(rate))")
//                .font(Font.body.monospacedDigit())
//            Slider(value: $rate, in: 10...25, step: 1)
//            Button("Change coffee weight to 30") {
//                coffeeWeight = 30
//            }
//            HStack {
//                VStack {
//                    Text("Coffee Weight")
//                    Picker("HI", selection: $coffeeWeight) {
//                        ForEach(1...100, id: \.self) {
//                            Text("\($0)")
//                        }
//                    }.pickerStyle(.inline)
//                        .frame(width: wheelWidth, height: wheelHeight)
//                        .clipped()
//                }.padding()
//
//                Spacer()
//
//                // MARK: - Water
//                VStack {
//                    Text("\(water)")
//                }
//                .padding()
//            }
//        }
//    }
//

}

struct BrewV60_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrewV60()
//            CoffeeMeasurements()
                .environment(\.colorScheme, .dark)
        }
        .preferredColorScheme(.dark)
    }
}
