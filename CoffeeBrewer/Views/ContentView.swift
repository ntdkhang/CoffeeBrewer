//
//  ContentView.swift
//  CoffeeBrewer
//
//  Created by Nguyen Tran Duy Khang on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {} ) {
            Text("New brew")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
