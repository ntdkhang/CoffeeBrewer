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
    
    func lap() -> Int {
        0
    }
    
    var timeInSeconds: Int {
        seconds % 60
    }
    
    var timeInMinutes: Int {
        seconds / 60
    }
    
    enum StopWatchState {
        case running
        case stopped
    }
}
