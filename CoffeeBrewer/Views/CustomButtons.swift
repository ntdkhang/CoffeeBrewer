//
//  CustomButtons.swift
//  CustomButtons
//
//  Created by Nguyen Tran Duy Khang on 8/8/21.
//

import SwiftUI

struct CustomButtons: View {
    var action: () -> Void = {}
    var text: String = "hihaho"
    
    var body: some View {
        VStack {
            Button(action: action,
                   label: {
                HStack {
                    Text("\(text)")
                }
            })
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
            
        }
    }
}

struct CustomButtons_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtons()
    }
}
