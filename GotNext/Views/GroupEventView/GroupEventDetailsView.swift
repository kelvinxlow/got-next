//
//  GroupEventDetailsView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-24.
//

import Firebase
import SwiftUI

struct GroupEventDetailsView: View {
    @Binding public var presentedAsModule: Bool
    @State private var confirmDelete = false
    @State private var errorDeleting = false
    @State private var errorUpdatingAttendance = false
    
    let db = Firestore.firestore()
    
    public var event: Event
    
    var body: some View {
        VStack(spacing: Spacings.large.rawValue) {
            Text(event.name)
                .font(.system(size: Fonts.title.rawValue, weight: .bold, design: .serif))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.bottom, Spacings.large.rawValue)
            
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
                
                GeometryReader { container in
                    HStack {
                        VStack(alignment: .center, spacing: Spacings.medium.rawValue) {
                            Text(Strings.peopleNeeded)
                                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(Color(Colors.featurePurple))
                                .multilineTextAlignment(.center)
                            
                            Text(String(event.numberOfPeople))
                                .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }.frame(width: container.size.width/2)
                        
                        VStack(alignment: .center, spacing: Spacings.medium.rawValue) {
                            Text(Strings.peopleAttending)
                                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(Color(Colors.featurePurple))
                                .multilineTextAlignment(.center)
                            
                            Text(String(event.participants.count
                            ))
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        }.frame(width: container.size.width/2)
                    }
                }
            }
            
            if let user = Auth.auth().currentUser?.email {
                if Date().timeIntervalSince1970 > event.timeSince1970 {
                    VStack(alignment: .center) {
                        Text(Strings.eventEnded)
                            .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                } else if event.sender == user {
                    VStack(alignment: .center, spacing: Spacings.large.rawValue) {
                        Text(Strings.takeDown)
                            .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        
                        if confirmDelete {
                            VStack {
                                Button(action: { deleteEvent() }) {
                                    Text(Strings.delete)
                                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                                .background(Color.red)
                                .cornerRadius(Values.smallCornerRadius.rawValue)
                                
                                Button(action: { confirmDelete = false }) {
                                    Text(Strings.cancel)
                                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                                .background(Color.blue)
                                .cornerRadius(Values.smallCornerRadius.rawValue)
                            }
                        }
                        else {
                            Button(action: { confirmDelete = true
                                errorDeleting = false
                            }) {
                                Text(Strings.deleteEvent)
                                    .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                            .background(Color.red.opacity(0.5))
                            .cornerRadius(Values.smallCornerRadius.rawValue)
                        }
                    }
                } else if event.participants.contains(user) {
                    VStack(alignment: .center, spacing: Spacings.large.rawValue) {
                        Text(Strings.alreadyAttending)
                            .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                        
                        Button(action: { withdrawFromEvent() }) {
                            Text(Strings.withdraw)
                                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(Color.white)
                        }
                        .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                        .background(Color(Colors.featurePurple).opacity(0.5))
                        .cornerRadius(Values.smallCornerRadius.rawValue)
                    }
                } else {
                    VStack(alignment: .center, spacing: Spacings.large.rawValue) {
                        Text(Strings.signUp)
                            .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                        
                        Button(action: { updateAttendance() }) {
                            Text(Strings.attendingEvent)
                                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                        }
                        .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                        .background(Color(Colors.featurePurple).opacity(0.5))
                        .cornerRadius(Values.smallCornerRadius.rawValue)
                    }
                }
            }
            
            if errorDeleting {
                Text(Strings.errorDeleting)
                    .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
            } else if errorUpdatingAttendance {
                Text(Strings.errorUpdating)
                    .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                    .foregroundColor(Color.red)
                    .multilineTextAlignment(.center)
            }
        }.preferredColorScheme(.light)
        .padding(Spacings.huge.rawValue)
    }
    
    private func deleteEvent() {
        db.collection(FBStrings.events).document(event.identifier).delete() { error in
            if error != nil {
                errorDeleting = true
            }
        }
    }
    
    private func updateAttendance() {
        guard let currentEmail = Auth.auth().currentUser?.email else {
            errorUpdatingAttendance = true
            return
        }
        
        var participants = event.participants
        participants.append(currentEmail)
        
        db.collection(FBStrings.events).document(event.identifier).setData([FBStrings.participants: participants], merge: true)
    }
    
    private func withdrawFromEvent() {
        guard let currentEmail = Auth.auth().currentUser?.email else {
            errorUpdatingAttendance = true
            return
        }
        
        var participants = event.participants
        participants.removeAll { participant -> Bool in
            participant == currentEmail
        }
        
        db.collection(FBStrings.events).document(event.identifier).setData([FBStrings.participants: participants], merge: true)
    }
}

struct GroupEventDetailsView_Previews: PreviewProvider {
    @State static private var present: Bool = true
    static private let mockEvent = Event(name: "Fake Event", date: "Wednesday, September 30, 2030 at 12:00 PM", timeSince1970: 12345667.0, location: "Mock Location", description: "Fake event so please don't actually show up", numberOfPeople: 20, sender: "mockemail@gmail.com", participants: ["mockemail@gmail.com", "mockemailtwo@gmail.com"], identifier: UUID().uuidString)
    
    static var previews: some View {
        GroupEventDetailsView(presentedAsModule: $present, event: mockEvent)
    }
}
