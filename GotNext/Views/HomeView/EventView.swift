//
//  EventView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-15.
//

import SwiftUI

struct EventView: View {
    enum Sizes: CGFloat {
        case imageSideLength = 48
    }
    
    let date: String
    let location: String
    let description: String
    
    var body: some View {
        HStack () {
            Image(systemName: "map")
                .resizable()
                .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                .padding(Spacings.medium.rawValue)
            
            VStack(alignment: .leading) {
                Text(date)
                    .font(.system(size: Fonts.header.rawValue, weight: .regular, design: .serif))
                    .lineLimit(2)
                Text(location)
                    .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                    .lineLimit(2)
                Text(description)
                    .font(.system(size: Fonts.header.rawValue, weight: .regular, design: .serif))
                    .lineLimit(3)
            }
            
            Spacer()
        }.padding(Spacings.medium.rawValue)
        .frame(alignment: .center)
        .background(Color(Colors.backgroundPurple))
        .cornerRadius(Values.cornerRadius.rawValue)
        .padding(.bottom, Spacings.small.rawValue)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(date: "Today", location: "My House", description: "Fun")
    }
}
