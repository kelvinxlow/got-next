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
    
    var body: some View {
        HStack () {
            Image(systemName: "map")
                .resizable()
                .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                .padding(Spacings.medium.rawValue)
            VStack(alignment: .leading) {
                Text("Saturday, Sep 25th @ 12:37 PM")
                    .lineLimit(1)
                Text("Fictional Central Park")
                    .lineLimit(1)
                Text("Descriptions for the event which may run multiple lines ")
                    .lineLimit(1)
            }
            Spacer()
        }
        .padding(Spacings.medium.rawValue)
        .frame(alignment: .center)
        .background(Color("BackgroundPurple"))
        .cornerRadius(Values.cornerRadius.rawValue)
        .padding(.bottom, Spacings.small.rawValue)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
