//
//  HomeView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-13.
//

import Firebase
import SwiftUI

struct HomeView: View {
    enum Sizes: CGFloat {
        case imageSideLength = 48
    }
    
    let db = Firestore.firestore()
    
    @State private var errorRetrievingEvents = false
    @State private var presentingModule = false
    @State private var events: [Event] = []
    @State private var reversedEvents: [Event] = []
     
    var body: some View {
        VStack(spacing: Spacings.small.rawValue) {
            HStack() {
                Text(Strings.appName.capitalized)
                    .font(.system(size: Fonts.title.rawValue, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color(Colors.featurePurple))
            }.padding(.bottom, Spacings.small.rawValue)
            
            Divider()
            
            // add condition to hide if no active events
            if (true) {
                HStack() {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: Spacings.large.rawValue, height: Spacings.large.rawValue)
                        .foregroundColor(.green)
                    Text(Strings.upcomingEvents.capitalized)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                }.padding(.top, Spacings.medium.rawValue)
                
                if errorRetrievingEvents {
                    EmptyView()
                }
                else {
                    ScrollView {
                        LazyVStack {
                            ForEach(events) {
                                if $0.timeSince1970 > Date().timeIntervalSince1970 {
                                    EventView(date: $0.date, location: $0.location, description: $0.description)
                                }
                            }
                        }
                    }.padding(Spacings.medium.rawValue)
                }
            }
            
            HStack() {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: Spacings.large.rawValue, height: Spacings.large.rawValue)
                    .foregroundColor(.gray)
                Text(Strings.pastEvents.capitalized)
                    .font(.system(size: Fonts.subTitle.rawValue, weight: .bold, design: .serif))
                    .foregroundColor(.black)
            }.padding(.top, Spacings.medium.rawValue)
            
            // add something that shows events when they are available
            if (true) {
                ScrollView {
                    LazyVStack {
                        ForEach(reversedEvents) {
                            if $0.timeSince1970 <= Date().timeIntervalSince1970 {
                                EventView(date: $0.date, location: $0.location, description: $0.description)
                            }
                        }
                    }
                }.padding(Spacings.medium.rawValue)
            } else {
                EmptyView()
                Spacer()
            }
            
            Divider()
            HStack() {
                Button(action: { self.presentingModule = true } ) {
                    Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                            .foregroundColor(Color(Colors.featurePurple))
                }.sheet(isPresented: $presentingModule, content: {
                    CreateEventView(presentedAsModule: self.$presentingModule)
                })
                
                Spacer()
                Image(systemName: "house.circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color(Colors.featurePurple))
                Spacer()
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                    .foregroundColor(Color(Colors.featurePurple))
            }.padding(.top, Spacings.small.rawValue)
        }.padding(Spacings.extraLarge.rawValue)
        .preferredColorScheme(.light)
        .onAppear(perform: {
            retrieveEvents()
        })
    }
    
    private func retrieveEvents() {
        db.collection(FBStrings.events)
            .order(by: FBStrings.timeSince1970)
            .addSnapshotListener { (querySnapshot, error) in
                self.events = []
              
                if let _ = error {
                    self.errorRetrievingEvents = true
                } else {
                    if let eventDocuments = querySnapshot?.documents {
                        for event in eventDocuments {
                            let data = event.data()
                            if let date = data[FBStrings.date] as? String,
                               let timeSince1970 = data[FBStrings.timeSince1970] as? Double,
                               let location = data[FBStrings.location] as? String,
                               let description = data[FBStrings.description] as? String,
                               let numberOfPeople = data[FBStrings.numberOfPeople] as? Int,
                               let sender = data[FBStrings.sender] as? String {
                                
                                let newEvent = Event(date: date, timeSince1970: timeSince1970, location: location, description: description, numberOfPeople: numberOfPeople, sender: sender)
                                
                                self.events.append(newEvent)
                            }
                        }
                        
                        reversedEvents = events.reversed()
                    }
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
