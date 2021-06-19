//
//  HomeView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-13.
//

import SwiftUI

struct HomeView: View {
    enum Sizes: CGFloat {
        case imageSideLength = 48
    }
    
    var body: some View {
        VStack(spacing: Spacings.small.rawValue) {
            HStack() {
                Text("GOT NEXT")
                    .font(.system(size: Fonts.title.rawValue, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color("FeaturePurple"))
            }.padding(.bottom, Spacings.small.rawValue)
            
            Divider()
            
            // add condition to hide if no active events
            if (true) {
                HStack() {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: Spacings.large.rawValue, height: Spacings.large.rawValue)
                        .foregroundColor(.green)
                    Text("ACTIVE EVENTS")
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                }.padding(.top, Spacings.medium.rawValue)
                
                ScrollView() {
                    EventView()
                    EventView()
                    EventView()
                }.padding(Spacings.large.rawValue)
            }
            
            HStack() {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: Spacings.large.rawValue, height: Spacings.large.rawValue)
                    .foregroundColor(.yellow)
                Text("UPCOMING EVENTS")
                    .font(.system(size: Fonts.subTitle.rawValue, weight: .bold, design: .serif))
                    .foregroundColor(.black)
            }.padding(.top, Spacings.medium.rawValue)
            
            // add something that shows events when they are available
            if (true) {
                ScrollView() {
                    EventView()
                    EventView()
                    EventView()
                }.padding(Spacings.large.rawValue)
            } else {
                EmptyView()
                Spacer()
            }
            
            Divider()
            HStack() {
                Image(systemName: "message.circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color("FeaturePurple"))
                Spacer()
                Image(systemName: "house.circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color("FeaturePurple"))
                Spacer()
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color("FeaturePurple"))
            }.padding(.top, Spacings.small.rawValue)
        }.padding(Spacings.extraLarge.rawValue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
