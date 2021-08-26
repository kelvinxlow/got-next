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
    @State private var presentingCreateEvent = false
    @State private var presentingEventDetails = false
    @State private var presentingProfile = false
    @State private var events: [Event] = []
    @State private var reversedEvents: [Event] = []
     
    var body: some View {
        VStack(spacing: Spacings.small.rawValue) {
            HStack() {
                Text(Strings.appName.capitalized)
                    .font(.system(size: Fonts.title.rawValue, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: { self.presentingProfile = true } ) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                        .foregroundColor(Color(Colors.featurePurple))
                }.fullScreenCover(isPresented: $presentingProfile, content: {
                    ProfileView(presentedAsModule: self.$presentingProfile)
                })
            }.padding(.bottom, Spacings.small.rawValue)
            
            Divider()
            
            // add condition to hide if no upcoming events
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
                                    EventView(event: $0)
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
            if errorRetrievingEvents {
                EmptyView()
                Spacer()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(reversedEvents) {
                            if $0.timeSince1970 <= Date().timeIntervalSince1970 {
                                EventView(event: $0)
                            }
                        }
                    }
                }.padding(Spacings.medium.rawValue)
            }
            
            Divider()
            HStack() {
                Button(action: { self.presentingCreateEvent = true } ) {
                    Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: Sizes.imageSideLength.rawValue, height: Sizes.imageSideLength.rawValue)
                            .foregroundColor(Color(Colors.featurePurple))
                }.fullScreenCover(isPresented: $presentingCreateEvent, content: {
                    CreateEventView(presentedAsModule: self.$presentingCreateEvent)
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
                            if let name = data[FBStrings.name] as? String,
                               let date = data[FBStrings.date] as? String,
                               let timeSince1970 = data[FBStrings.timeSince1970] as? Double,
                               let location = data[FBStrings.location] as? String,
                               let description = data[FBStrings.description] as? String,
                               let numberOfPeople = data[FBStrings.numberOfPeople] as? Int,
                               let sender = data[FBStrings.sender] as? String {
                                
                                let newEvent = Event(name: name, date: date, timeSince1970: timeSince1970, location: location, description: description, numberOfPeople: numberOfPeople, sender: sender)
                                
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
