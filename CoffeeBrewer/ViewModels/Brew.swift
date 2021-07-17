//
//  Brew.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/13/21.
//

import Foundation

public extension Brew {
    var date: Date {
        get { return date_ ?? Date() }
        set { date_ = newValue }
    }
    
    var id: UUID {
        get { return id_ ?? UUID() }
        set { id_ = newValue }
    }
    
    var methodName: String {
        get { return methodName_ ?? "ERROR NAME" }
        set { methodName_ = newValue }
    }
    
    var note: String {
        get { return note_ ?? "ERROR NOTE" }
        set { note_ = newValue }
    }
    
    var characteristics: Characteristics {
        get { return characteristics_ ?? Characteristics() }
        set { characteristics_ = newValue }
    }
    
    var coffee: Coffee {
        get { return coffee_ ?? Coffee() }
        set { coffee_ = newValue }
    }
    
    var process: String {
        get { return process_ ?? "ERROR PROCESS" }
        set { process_ = newValue }
    }
}
