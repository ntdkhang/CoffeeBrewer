//
//  BrewProcess.swift
//  BrewProcess
//
//  Created by Nguyen Tran Duy Khang on 8/7/21.
//

import SwiftUI
struct BrewProcess: View {
    @ObservedObject var stopWatch: StopWatch = StopWatch()
    @State private var laps: [String] = []
    @State private var showBrewReview: Bool = false
            
//    var coffeeInfo: CoffeeInfo
    var brewSetting: BrewSetting
    @State var lapsProcess = ""
    
    var body: some View {
        VStack {
            Text("-Laps-")
            ForEach(laps, id: \.self) { lap in
                Text(lap)
            }
            
            Text("-Time-")
            if !(stopWatch.state == .stopped) {

                Text(stopWatch.writeTime())
            } else {
                Text("")
            }
            
            HStack {
                Button(action: {
                    laps.append(stopWatch.writeTime())

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
                    laps.append(stopWatch.writeTime())
                    writeProcess()
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
                 content: { BrewReview(brewSetting: brewSetting,
                                       methodName: "V60",
                                       lapsProcess: lapsProcess) })
    }
    private var watchButtonSize: CGFloat = 100
    
    
    
    private func writeProcess() {
        for lapNumber in laps.indices {
            lapsProcess.append("Step \(lapNumber + 1) at \(laps[lapNumber])\n")
        }
    }
}

extension BrewProcess {
    init(brewSetting: BrewSetting) {
        self.brewSetting = brewSetting
    }
}


struct BrewProcess_Previews: PreviewProvider {
    static var previews: some View {
        BrewProcess(brewSetting: BrewSetting())
                    
    }
}
