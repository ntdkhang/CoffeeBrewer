//
//  BrewV60.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI
import CoreData

struct BrewV60: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Coffee.name_, ascending: true)],
        animation: .default)
    private var coffees: FetchedResults<Coffee>
    @State var coffeeInfo = CoffeeInfo()
    @State var presentCoffeeChooser: Bool = false
    @State var startBrewing: Bool = false
    var body: some View {
        VStack {
            List {
                Label("Choose Coffee", systemImage: "globe.europe.africa.fill")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        presentCoffeeChooser = true
                    }
                    .popover(isPresented: $presentCoffeeChooser) {
                        CoffeeChooser(coffeeInfo: $coffeeInfo)
                            .environment(\.managedObjectContext, viewContext)
    //                        .preferredColorScheme(.dark)
                    }
                
                Text("Name: \(coffeeInfo.name)")
                Text("Brand: \(coffeeInfo.brand)")
            }
            .listStyle(.insetGrouped)
            .navigationTitle("V60")
            
        // TODO: Add coffee & water measurement
            if startBrewing == true {
                BrewProcess(coffeeInfo: coffeeInfo)
            } else {
                Button(action: {startBrewing = true },
                       label: { Text("Start Brewing") })
            }
        }
    }
}


struct BrewProcess: View {
    @ObservedObject var stopWatch: StopWatch = StopWatch()
    @State private var laps: [Int] = []
    @State private var lastLap: Int = 0
    @State private var showBrewReview: Bool = false
                    
    var coffeeInfo: CoffeeInfo
                    
    var body: some View {
        VStack {
            ForEach(laps, id: \.self) { lap in
                Text("\(lap)")
            }
            
            Text("\(stopWatch.seconds - lastLap)")
            HStack {
                Button(action: {
                    laps.append(stopWatch.seconds)
                    lastLap = laps.last ?? 0
                },      label: {
                    ZStack {
                        Circle()
                        Text("Lap").foregroundColor(.black)
                    }
                    .frame(width: watchButtonSize, height: watchButtonSize)
                }).buttonStyle(PlainButtonStyle())
                
                if stopWatch.state == .stopped {
                    Button(action: {
                        stopWatch.start()
                    },      label: {
                        ZStack {
                            Circle()
                            Text("Start Timer").foregroundColor(.black)
                        }
                        .frame(width: watchButtonSize, height: watchButtonSize)
                    }).buttonStyle(PlainButtonStyle())
                } else {
                    ZStack {}
                    .frame(width: watchButtonSize, height: watchButtonSize)
                }
                // MARK: - Show BrewReview
                Button(action: {
                    laps.append(stopWatch.seconds)
                    stopWatch.stop()
                    showBrewReview = true
                },      label: {
                    ZStack {
                        Circle()
                        Text("Stop").foregroundColor(.black)
                    }
                    .frame(width: watchButtonSize, height: watchButtonSize)
                }).buttonStyle(PlainButtonStyle())
            }
        }
        .popover(isPresented: $showBrewReview,
                 content: { BrewReview(coffeeInfo: coffeeInfo,
                                       methodName: "V60") })
    }
    private var watchButtonSize: CGFloat = 100
    
    
    init(coffeeInfo: CoffeeInfo) {
        self.coffeeInfo = coffeeInfo
    }
    
}


struct CoffeeChooser: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Coffee.name_, ascending: true)],
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
                    }
                }
            }
            
        }
    }
}

struct BrewV60_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrewV60()
//                .environment(\.colorScheme, .dark)
        }
        .preferredColorScheme(.dark)
    }
}
