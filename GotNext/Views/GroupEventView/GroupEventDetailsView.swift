//
//  GroupEventDetailsView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-24.
//

import SwiftUI

struct GroupEventDetailsView: View {
    @Binding public var presentedAsModule: Bool
    
    public var event: Event
    
    var body: some View {
        VStack(spacing: Spacings.large.rawValue) {
            Text(event.name)
                .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: Spacings.large.rawValue) {
                VStack(alignment: .leading, spacing: Spacings.medium.rawValue) {
                    Text(Strings.date)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                        .multilineTextAlignment(.leading)
                    Text(event.date)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                
                VStack(alignment: .leading, spacing: Spacings.medium.rawValue) {
                    Text(Strings.location)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                        .multilineTextAlignment(.leading)
                    
                    Text(event.location)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                
                VStack(alignment: .leading, spacing: Spacings.medium.rawValue) {
                    Text(Strings.details)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                        .multilineTextAlignment(.leading)
                    
                    Text(event.description)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                
                VStack(alignment: .leading, spacing: Spacings.medium.rawValue) {
                    Text(Strings.peopleNeeded)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                        .multilineTextAlignment(.leading)
                    
                    Text(String(event.numberOfPeople))
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
            }
        }.preferredColorScheme(.light)
        .padding(Spacings.huge.rawValue)
    }
}

struct GroupEventDetailsView_Previews: PreviewProvider {
    @State static private var present: Bool = true
    static private let mockEvent = Event(name: "Fake Event", date: "Wednesday, September 30, 2030 at 12:00 PM", timeSince1970: 12345667.0, location: "Mock Location", description: "Fake event so please don't actually show up", numberOfPeople: 20, sender: "mockemail@gmail.com")
    
    static var previews: some View {
        GroupEventDetailsView(presentedAsModule: $present, event: mockEvent)
    }
}
