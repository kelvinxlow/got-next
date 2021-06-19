//
//  EmptyView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-15.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        HStack () {
            Text("No upcoming events")
                .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black.opacity(0.7))
                .frame(width: 200)
        }.padding(Spacings.huge.rawValue)
        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(Values.cornerRadius.rawValue)
        .padding(.top, Spacings.small.rawValue)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
