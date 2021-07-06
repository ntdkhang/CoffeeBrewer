//
//  BrewReview.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/5/21.
//

import SwiftUI

struct BrewReview: View {
    var methodName: String
    var coffee: Coffee
    @State var aromaQuantity: Double = 0
    @State var aromaQuality: Double = 0
    @State var acidityQuantity: Double = 0
    @State var acidityQuality: Double = 0
    @State var sweetnessQuantity: Double = 0
    @State var sweetnessQuality: Double = 0
    @State var bodyQuantity: Double = 0
    @State var bodyQuality: Double = 0
    @State var finishQuantity: Double = 0
    @State var finishQuality: Double = 0
    
    @State var flavour: String = ""
    @State var note: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {

        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }.padding([.trailing])
                
            }
            List {
                // MARK: - Aroma
                Section(header: Text("Aroma")) {
                    HStack {
                        Text("Quantity:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(aromaQuantity)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $aromaQuantity, in: 0...10, step: 1)
                    }
                    
                    HStack {
                        Text("Quality:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(aromaQuality)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $aromaQuality, in: 0...10, step: 1)
                    }
                }
                
                
                // MARK: - Acidity
                Section(header: Text("Acidity")) {
                    HStack {
                        Text("Quantity:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(acidityQuantity)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $acidityQuantity, in: 0...10, step: 1)
                    }
                    
                    HStack {
                        Text("Quality:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(acidityQuality)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $acidityQuality, in: 0...10, step: 1)
                    }
                }
                
                
                // MARK: - Sweet
                Section(header: Text("Sweetness")) {
                    HStack {
                        Text("Quantity:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(sweetnessQuantity)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $sweetnessQuantity, in: 0...10, step: 1)
                    }
                    
                    HStack {
                        Text("Quality:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(sweetnessQuality)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $sweetnessQuality, in: 0...10, step: 1)
                    }
                }
                
                
                // MARK: - Body
                Section(header: Text("Body")) {
                    HStack {
                        Text("Quantity:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(bodyQuantity)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $bodyQuantity, in: 0...10, step: 1)
                    }
                    
                    HStack {
                        Text("Quality:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(bodyQuality)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $bodyQuality, in: 0...10, step: 1)
                    }
                }
                
                
                // MARK: - Finish
                Section(header: Text("Finish")) {
                    HStack {
                        Text("Quantity:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(finishQuantity)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $finishQuantity, in: 0...10, step: 1)
                    }
                    
                    HStack {
                        Text("Quality:")
                            .frame(width: textWidth, alignment: .leading)
                        Text("\(String(format: "%02d", Int(finishQuality)))")
                            .font(Font.headline.monospacedDigit())
                        
                        Slider(value: $finishQuality, in: 0...10, step: 1)
                    }
                }
                
                
                // MARK: - Flavour
                Section(header: Text("Flavour")) {
                    TextField("Enter flavour", text: $flavour)
                }
                
                
                // MARK: - Note
                Section(header: Text("Additional note")) {
                    TextEditor(text: $note)
                }
                
            }
            .listStyle(.insetGrouped)
        }
    }
    private var textWidth: CGFloat {
        CGFloat(100)
    }
    
    private func writeReview() {
        let brew = Brew(
            methodName: methodName, coffee: coffee,
            characteristics:
                Characteristics(
                    aroma: Grading(quantity: Int(aromaQuantity), quality: Int(aromaQuality)),
                    acidity: Grading(quantity: Int(acidityQuantity), quality: Int(acidityQuality)),
                    sweetness: Grading(quantity: Int(sweetnessQuantity), quality: Int(sweetnessQuality)),
                    body: Grading(quantity: Int(bodyQuantity), quality: Int(bodyQuality)),
                    finish: Grading(quantity: Int(finishQuantity), quality: Int(finishQuality)),
                    flavour: flavour),
            note: note)
        // TODO: Write the brew to data model
    }
}

struct BrewReview_Previews: PreviewProvider {
    static var previews: some View {
        BrewReview(methodName: "V60", coffee: DataTemplate().coffees[0])
            .preferredColorScheme(.dark)
    }
}
