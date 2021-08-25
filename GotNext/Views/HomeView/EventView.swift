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
    
    @State private var presentingEventDetails = false

    let event: Event
    
    var body: some View {
        HStack () {
            Image(systemName: "map")
                .resizable()
                .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                .padding(Spacings.medium.rawValue)
            
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.system(size: Fonts.header.rawValue, weight: .bold, design: .serif))
                    .lineLimit(1)
                Text(event.date)
                    .font(.system(size: Fonts.header.rawValue, weight: .regular, design: .serif))
                    .lineLimit(1)
                Text(event.location)
                    .font(.system(size: Fonts.header.rawValue, weight: .regular, design: .serif))
                    .lineLimit(1)
            }
            
            Spacer()
        }.padding(Spacings.medium.rawValue)
        .frame(alignment: .center)
        .background(Color(Colors.backgroundPurple))
        .cornerRadius(Values.cornerRadius.rawValue)
        .padding(.bottom, Spacings.small.rawValue)
        .gesture(TapGesture().onEnded({ self.presentingEventDetails = true }))
        .sheet(isPresented: $presentingEventDetails, content: {
            GroupEventDetailsView(presentedAsModule: self.$presentingEventDetails, event: event)
        })
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(name: "Fake Event", date: "Wednesday, September 30, 2030 at 12:00 PM", timeSince1970: 12345667.0, location: "Mock Location", description: "Fake event so please don't actually show up", numberOfPeople: 20, sender: "mockemail@gmail.com"))
    }
}
