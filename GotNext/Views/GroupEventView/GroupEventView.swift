//
//  GroupEventView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-15.
//

import SwiftUI

struct GroupEventView: View {
    enum Sizes: CGFloat {
        case imageSideLength = 48
        case imageSideWidth = 72
        case buttonHeight = 64
        case buttonwidth = 144
        case borderWidth = 4 
    }
    
    var body: some View {
        VStack() {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Chat Name")
                        .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                    Text("Saturday, Sep 25th @ 12:37 PM")
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .lineLimit(1)
                }
                Spacer()
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
            }
            
            Divider()
            
            HStack() {
                GroupMembersView()
                GroupMembersView()
                GroupMembersView()
                GroupMembersView()
                GroupMembersView()
                GroupMembersView()
                GroupMembersView()
            }.padding(.top, Spacings.small.rawValue)
            
            Spacer()
            
            MapView()
                .padding(Spacings.medium.rawValue)
            
            HStack(spacing: Spacings.huge.rawValue) {
                Button(action: { print("Confirmed") }) {
                    Text(Strings.accept)
                        .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                        .lineLimit(1)
                        .foregroundColor(Color(Colors.outlineGreen))
                        .padding(Spacings.large.rawValue)
                        .frame(width: Sizes.buttonwidth.rawValue, height: Sizes.buttonHeight.rawValue)
                        .border(Color(Colors.outlineGreen), width: Sizes.borderWidth.rawValue)
                }
                
                Button(action: { print("Denied") }) {
                    Text(Strings.decline)
                        .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                        .lineLimit(1)
                        .foregroundColor(Color.red)
                        .padding(Spacings.large.rawValue)
                        .frame(width: Sizes.buttonwidth.rawValue, height: Sizes.buttonHeight.rawValue)
                        .border(Color.red, width: Sizes.borderWidth.rawValue)
                }
            }.padding(.top, Spacings.small.rawValue)
        }.padding(Spacings.extraLarge.rawValue)
    }
}

struct GroupEventView_Previews: PreviewProvider {
    static var previews: some View {
        GroupEventView()
    }
}
