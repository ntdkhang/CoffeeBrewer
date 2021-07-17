//
//  Characteristics.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/9/21.
//

import Foundation

extension Characteristics {
    var acidityQuality: Int {
        get { return Int(acidityQuality_) }
        
        set {
            if newValue > 10 { acidityQuality_ = 10 } else
            if newValue < 0 { acidityQuality_ = 0 }
            else { acidityQuality_ = Int16(newValue) }
        }
    }
    
    var acidityQuantity: Int {
        get { return Int(acidityQuantity_) }
        
        set {
            if newValue > 10 { acidityQuantity_ = 10 } else
            if newValue < 0 { acidityQuantity_ = 0 }
            else { acidityQuantity_ = Int16(newValue) }
        }
    }
    
    var aromaQuality: Int {
        get { return Int(aromaQuality_) }
        
        set {
            if newValue > 10 { aromaQuality_ = 10 } else
            if newValue < 0 { aromaQuality_ = 0 }
            else { aromaQuality_ = Int16(newValue) }
        }
    }
    
    var aromaQuantity: Int {
        get { return Int(aromaQuantity_) }
        
        set {
            if newValue > 10 { aromaQuantity_ = 10 } else
            if newValue < 0 { aromaQuantity_ = 0 }
            else { aromaQuantity_ = Int16(newValue) }
        }
    }
    
    var bodyQuality: Int {
        get { return Int(bodyQuality_) }
        
        set {
            if newValue > 10 { bodyQuality_ = 10 } else
            if newValue < 0 { bodyQuality_ = 0 }
            else { bodyQuality_ = Int16(newValue) }
        }
    }
    
    var bodyQuantity: Int {
        get { return Int(bodyQuantity_) }
        
        set {
            if newValue > 10 { bodyQuantity_ = 10 } else
            if newValue < 0 { bodyQuantity_ = 0 }
            else { bodyQuantity_ = Int16(newValue) }
        }
    }
    
    var finishQuality: Int {
        get { return Int(finishQuality_) }
        
        set {
            if newValue > 10 { finishQuality_ = 10 } else
            if newValue < 0 { finishQuality_ = 0 }
            else { finishQuality_ = Int16(newValue) }
        }
    }
    
    var finishQuantity: Int {
        get { return Int(finishQuantity_) }
        
        set {
            if newValue > 10 { finishQuantity_ = 10 } else
            if newValue < 0 { finishQuantity_ = 0 }
            else { finishQuantity_ = Int16(newValue) }
        }
    }
    
    var sweetnessQuality: Int {
        get { return Int(sweetnessQuality_) }
        
        set {
            if newValue > 10 { sweetnessQuality_ = 10 } else
            if newValue < 0 { sweetnessQuality_ = 0 }
            else { sweetnessQuality_ = Int16(newValue) }
        }
    }
    
    var sweetnessQuantity: Int {
        get { return Int(sweetnessQuantity_) }
        
        set {
            if newValue > 10 { sweetnessQuantity_ = 10 } else
            if newValue < 0 { sweetnessQuantity_ = 0 }
            else { sweetnessQuantity_ = Int16(newValue) }
            
        }
    }
    
    var flavour: String {
        get { return flavour_ ?? "ERROR FLAVOUR" }
        set { flavour_ = newValue }
    }
    
}
