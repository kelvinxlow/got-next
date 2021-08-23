//
//  CreateEventView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-22.
//

import SwiftUI

struct CreateEventView: View {
    enum Sizes: CGFloat {
        case buttonHeight = 48
        case buttonwidth = 128
        case borderWidth = 4
    }
    
    @Binding public var presentedAsModule: Bool
    @State private var date: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var numPeople: Float = 5
    
    var body: some View {
        VStack(spacing: Spacings.large.rawValue) {
            Text(Strings.createEvent)
                .font(.system(size: Fonts.event.rawValue, weight: .medium, design: .serif))
                .multilineTextAlignment(.center)
            
            Text(Strings.date)
                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                .foregroundColor(Color(Colors.featurePurple))
            
            TextField(Strings.dateTime,
                text: $date)
                .autocapitalization(.none)
                .padding(Spacings.extraSmall.rawValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color(Colors.backgroundPurple))
            
            
            Text(Strings.location)
                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                .foregroundColor(Color(Colors.featurePurple))
            
            TextField(Strings.nameAddress,
                text: $location)
                .autocapitalization(.none)
                .padding(Spacings.extraSmall.rawValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color(Colors.backgroundPurple))
            
            
            Text(Strings.description)
                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                .foregroundColor(Color(Colors.featurePurple))
            
            TextField(Strings.eventDetails,
                text: $description)
                .autocapitalization(.none)
                .padding(Spacings.extraSmall.rawValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color(Colors.backgroundPurple))
            
            
            Text("\(Strings.people): \(Int(numPeople))")
                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                .foregroundColor(Color(Colors.featurePurple))
            
            HStack {
                Text("1")
                    .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                    .foregroundColor(Color(Colors.featurePurple))
                Slider(value: $numPeople, in: 1...20)
                    .accentColor(Color(Colors.backgroundPurple))
                Text("20")
                    .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                    .foregroundColor(Color(Colors.featurePurple))
            }
            
            HStack (spacing: Spacings.extraLarge.rawValue) {
                Button(action: { print("Confirmed") }) {
                    Text(Strings.confirm)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .lineLimit(1)
                        .foregroundColor(Color(Colors.outlineGreen))
                        .padding(Spacings.large.rawValue)
                        .frame(width: Sizes.buttonwidth.rawValue, height: Sizes.buttonHeight.rawValue)
                        .border(Color(Colors.outlineGreen), width: Sizes.borderWidth.rawValue)
                }
                
                Button(action: { presentedAsModule = false }) {
                    Text(Strings.cancel)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .lineLimit(1)
                        .foregroundColor(Color.red)
                        .padding(Spacings.large.rawValue)
                        .frame(width: Sizes.buttonwidth.rawValue, height: Sizes.buttonHeight.rawValue)
                        .border(Color.red, width: Sizes.borderWidth.rawValue)
                }
            }.padding(EdgeInsets(top: Spacings.medium.rawValue, leading: 0, bottom: 0, trailing: 0))
        }.padding(Spacings.huge.rawValue)
        .preferredColorScheme(.light)
    }
}

struct CreateEvent_Previews: PreviewProvider {
    @State static private var present: Bool = true
    
    static var previews: some View {
        CreateEventView(presentedAsModule: $present)
    }
}
