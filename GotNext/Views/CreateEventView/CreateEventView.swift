//
//  CreateEventView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-22.
//

import Firebase
import SwiftUI

struct CreateEventView: View {
    enum Sizes: CGFloat {
        case buttonHeight = 48
        case buttonwidth = 128
        case borderWidth = 4
    }
    
    let db = Firestore.firestore()
    
    @Binding public var presentedAsModule: Bool
    @State private var date: Date = Date()
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var description: String = ""
    @State private var numPeople: Float = 1
    @State private var showErrorMessage: Bool = false
    @State private var showSuccessMessage: Bool = false
    
    var body: some View {
        VStack(spacing: Spacings.large.rawValue) {
            ScrollView {
                Group {
                    Text(Strings.createEvent)
                        .font(.system(size: Fonts.event.rawValue, weight: .medium, design: .serif))
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: Spacings.medium.rawValue, trailing: 0))
                    
                    Text(Strings.name)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                    
                    TextField(Strings.name,
                              text: $name)
                        .padding(Spacings.extraSmall.rawValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color(Colors.backgroundPurple))
                    
                    Text(Strings.date)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                    
                    DatePicker(selection: $date, in: Date()..., displayedComponents: [.hourAndMinute, .date]) {
                    }.foregroundColor(Color(Colors.featurePurple))
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding(-Spacings.large.rawValue)
                }
                
                Group {
                    Text(Strings.location)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                    
                    TextField(Strings.address,
                              text: $location)
                        .padding(Spacings.extraSmall.rawValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color(Colors.backgroundPurple))
                    
                    
                    Text(Strings.description)
                        .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color(Colors.featurePurple))
                    
                    TextField(Strings.eventDetails,
                              text: $description)
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
                }
                
                if showErrorMessage {
                    Text(Strings.errorMessage)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                } else if showSuccessMessage {
                    Text(Strings.successMessage)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.green)
                }
                
                HStack(spacing: Spacings.extraLarge.rawValue) {
                    Button(action: { uploadEventToFirebase() }) {
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
    
    private func uploadEventToFirebase() {
        if name != "", location != "", description != "", let sender = Auth.auth().currentUser?.email, let host = Auth.auth().currentUser?.displayName {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .short
            
            let stringDate = dateFormatter.string(from: date)
            let timeSince1970 = date.timeIntervalSince1970
            let identifier = UUID().uuidString
            
            db.collection(FBStrings.events).document(identifier).setData(
                [FBStrings.name: name,
                 FBStrings.date: stringDate,
                 FBStrings.timeSince1970: timeSince1970,
                 FBStrings.location: location,
                 FBStrings.description: description,
                 FBStrings.numberOfPeople: Int(numPeople),
                 FBStrings.sender: sender,
                 FBStrings.participants: [sender],
                 FBStrings.identifier: identifier,
                 FBStrings.host: host
                ]) { (error) in
                
                if error != nil {
                    showError()
                }
                else {
                    showErrorMessage = false
                    showSuccessMessage = true
                    
                    resetValues()
                }
            }
        }
        else {
            showError()
        }
    }
    
    private func showError() {
        showErrorMessage = true
        showSuccessMessage = false
    }
    
    private func resetValues() {
        date = Date()
        location = ""
        description = ""
        name = ""
        numPeople = 1
    }
}

struct CreateEvent_Previews: PreviewProvider {
    @State static private var present: Bool = true
    
    static var previews: some View {
        CreateEventView(presentedAsModule: $present)
    }
}
