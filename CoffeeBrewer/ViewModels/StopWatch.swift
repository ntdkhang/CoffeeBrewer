//
//  StopWatch.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/5/21.
//

import Foundation

class StopWatch: ObservableObject {
    @Published var seconds = 0
    
    var state: StopWatchState = .stopped
    var timer = Timer()
    
    init() {}
    
    func start() {
        guard state == .stopped else {
            return
        }
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            self.seconds += 1
        }
    }
    
    func stop() {
        state = .stopped
        timer.invalidate()
        seconds = 0
    }
    
    func writeTime(for lap: Int) -> String {
        return "\(String(lap / 60)):\(String(lap % 60))"
    }
    
    func writeTime() -> String {
        return "\(String(seconds / 60)):\(String(seconds % 60))"
    }
    
    enum StopWatchState {
        case running
        case stopped
    }
}
