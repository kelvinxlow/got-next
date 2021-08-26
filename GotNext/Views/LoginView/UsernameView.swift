//
//  UsernameView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-25.
//

import Firebase
import SwiftUI

struct UsernameView: View {
    
    @State private var username: String = ""
    @State private var statusMessage: String = ""
    @State private var errorMessage = false
    @State private var successMessage = false
    @State private var finishedSettingUsername = false
    @State private var homeView = false
    
    var body: some View {
        if homeView {
            HomeView()
        } else {
            VStack (spacing: Spacings.large.rawValue) {
                Text(Strings.userViewMessage)
                    .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                    .foregroundColor(Color(Colors.featurePurple))
                    .multilineTextAlignment(.center)
                
                if !finishedSettingUsername {
                    TextField(
                        " \(Strings.username)",
                        text: $username
                    )
                    .autocapitalization(.none)
                    .padding(Spacings.medium.rawValue)
                    .background(Color(Colors.backgroundPurple))
                    .cornerRadius(Values.cornerRadius.rawValue)
                }
                
                if errorMessage {
                    Text(statusMessage)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(.red)
                } else if successMessage {
                    Text(statusMessage)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(.green)
                }
                
                if finishedSettingUsername {
                    Button(action: { homeView = true }) {
                        Text(Strings.continueText)
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                    }
                    .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                    .background(Color(Colors.featurePurple).opacity(0.5))
                    .cornerRadius(Values.smallCornerRadius.rawValue)
                }
                else {
                    Button(action: { updateUserName() }) {
                        Text(Strings.setName)
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                    }
                    .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                    .background(Color(Colors.featurePurple).opacity(0.5))
                    .cornerRadius(Values.smallCornerRadius.rawValue)
                }
            }.preferredColorScheme(.light)
            .padding(Spacings.large.rawValue)
        }
    }
    
    private func updateUserName() {
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            
            errorMessage = false
            successMessage = false
            
            if username != "" {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error != nil {
                        statusMessage = Strings.usernameErrorMessage
                        errorMessage = true
                    }
                    else {
                        statusMessage = Strings.usernameSuccessMessage
                        successMessage = true
                        finishedSettingUsername = true
                        username = ""
                    }
                }
            } else {
                statusMessage = Strings.noUsername
                errorMessage = true
            }
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
