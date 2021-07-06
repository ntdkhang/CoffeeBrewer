//
//  BrewV60.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI

struct BrewV60: View {
    @State var coffee: Coffee = DataTemplate().coffees[0]
    @State var presentCoffeeChooser: Bool = false
    var body: some View {
        VStack {
            List {
                Label("Choose Coffee", systemImage: "globe.europe.africa.fill")
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        presentCoffeeChooser = true
                    }
                    .popover(isPresented: $presentCoffeeChooser) {
                        CoffeeChooser(coffee: $coffee)
    //                        .preferredColorScheme(.dark)
                    }
                
                Text("Name: \(coffee.name)")
                Text("Brand: \(coffee.brand)")
            }
            .listStyle(.insetGrouped)
            .navigationTitle("V60")
            
        // TODO: Add coffee & water measurement
            BrewProcess(coffee: coffee)
        }
    }
}


struct BrewProcess: View {
    @ObservedObject var stopWatch = StopWatch()
    @State private var laps: [Int] = []
    var coffee: Coffee
    
    var body: some View {
        VStack {
            ForEach(laps, id: \.self) { lap in
                Text("\(lap)")
            }
            
            Text("\(stopWatch.seconds)")
            HStack {
                Button(action: {
                    laps.append(stopWatch.seconds)
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
                
                Button(action: {
                    stopWatch.stop()
                },      label: {
                    ZStack {
                        Circle()
                        Text("Stop").foregroundColor(.black)
                    }
                    .frame(width: watchButtonSize, height: watchButtonSize)
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
    private var watchButtonSize: CGFloat = 100
    
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
}


struct CoffeeChooser: View {
    @State private var name: String = ""
    @State private var brand: String = ""
    @Binding var coffee: Coffee
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button("Done") {
                    coffee = Coffee(name: name, brand: brand)
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
                    ForEach(DataTemplate().coffees) { existingCoffee in
                        Text("\(existingCoffee.brand)'s \(existingCoffee.name)")
                            .onTapGesture {
                                coffee = existingCoffee
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
