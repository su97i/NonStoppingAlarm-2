//
//  Answer.swift
//  NonStoppingAlarm
//
//  Created by Sarah Sheikh on 9/01/2023.
//

import SwiftUI

struct Answer: View {
    var number : Int
    
    var body: some View {
        Text("\(number)")
                .frame(width: 110, height: 110)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.white)
                .background(Color("color"))
                .clipShape(Circle())
                .padding()
    }
}

struct Answer_Previews: PreviewProvider {
    static var previews: some View {
        Answer(number: 200)
    }
}
