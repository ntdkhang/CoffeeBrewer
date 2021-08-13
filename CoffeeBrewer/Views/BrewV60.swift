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
//    @State var coffeeInfo = CoffeeInfo()
    @State var brewSetting = BrewSetting()
    @State var showCoffeeChooser: Bool = false
    @State var startBrewing: Bool = false
    @State var previousSetting: BrewSetting? = nil
    @State var usePreviousSetting = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Button(action: {
                        showCoffeeChooser = true
                    },     label: {
                        ZStack {
                            Text("Choose Coffee  ").font(.system(size: 25))
                        }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                        
                    Button(action: {
                        if previousSetting != nil {
                            brewSetting = previousSetting!
                            usePreviousSetting = true
                        }
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
                        .padding(.top)
                }
                .padding()
                .popover(isPresented: $showCoffeeChooser) {
                    CoffeeChooser(coffeeInfo: $brewSetting.coffeeInfo)
                        .environment(\.managedObjectContext, viewContext)
                }
                Spacer()
            }
            Group {
                Text("Brand: \(brewSetting.coffeeInfo.brand)")
                Text("Name: \(brewSetting.coffeeInfo.name)")
            }
            .padding(.init(top: 4, leading: 16, bottom: 0, trailing: 0))
            .font(.system(size: 24))
            .foregroundColor(.yellow)
            
            Spacer()
            
            
            
            // MARK: - Coffee & water measurement
            CoffeeMeasurements(brewSetting: $brewSetting,
                               previousSetting: previousSetting ?? brewSetting,
                               usePreviousSetting: usePreviousSetting)
            
            
            Spacer()
            Spacer()
                 
            
            HStack {
                Spacer()
                if startBrewing == true {
                    BrewProcess(brewSetting: brewSetting)
                } else {
                    Button(action: {startBrewing = true },
                           label: { Text("Start Brewing")
                            .font(.system(size: 20))
                    })
                }
                Spacer()
            }
            
        }
        .navigationTitle("V60")
        .onAppear(perform: { loadPreviousSetting() })
    }
    
    func loadPreviousSetting() {
        if let data = UserDefaults.standard.data(forKey: "BrewSetting") {
            if let decodedSetting = try? JSONDecoder()
                .decode(BrewSetting.self, from: data) {
                previousSetting = decodedSetting
                
            }
        }
    }
}



struct CoffeeMeasurements: View {
    @State var coffeeWeight: Double = 1
    @State var coffeeWaterRate: Double = 15
    @Binding var brewSetting: BrewSetting
    var previousSetting: BrewSetting
    var usePreviousSetting: Bool
    
    var body: some View {
        VStack {
            Text("Coffee Weight")
            Text("\(Int(coffeeWeight)) g")
            Slider(value: $coffeeWeight, in: 5...70, step: 1,
                   onEditingChanged: { _ in
                brewSetting.coffeeWeight = Int(coffeeWeight)
            })
            
            // MARK: - Coffee : Water rate
            HStack(alignment: .top){
                VStack {
                    Text("Coffee : Water")
                    Text("    1 : \(Int(coffeeWaterRate))")
                    Slider(value: $coffeeWaterRate, in: 10...25, step: 1
                           , onEditingChanged: { _ in
                        brewSetting.coffeeWaterRate = Int(coffeeWaterRate)
                    })
                    
                }.padding()
                
                Spacer()
                
            // MARK: - Water
                VStack {
                    Text("Total water weight")
                    Text("\(waterWeight) g")
                }
                .padding()
            }
        }
            .onChange(of: usePreviousSetting,
                      perform: { _ in
                coffeeWeight = Double(previousSetting.coffeeWeight)
                coffeeWaterRate = Double(previousSetting.coffeeWaterRate)
            } )
            .font(.system(size: fontSize).monospacedDigit())
    }
    
    var waterWeight: Int {
        Int(coffeeWeight * coffeeWaterRate)
    }
    
    var fontSize: CGFloat = 20
    
    
//    init(brewSetting brewBinding: Binding<BrewSetting>, previousSetting: BrewSetting) {
//        self._brewSetting = brewBinding
//        if brewBinding.wrappedValue.coffeeWeight > 0 {
//            self.coffeeWeight = Double(brewBinding.wrappedValue.coffeeWeight)
//            self.coffeeWaterRate = Double(brewBinding.wrappedValue.coffeeWaterRate)
//        } else {
//            self.coffeeWeight = 1
//            self.coffeeWaterRate = 15
//        }
//        return
//    }
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
