//
//  ProfileView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-08-25.
//

import Firebase
import SwiftUI

struct ProfileView: View {
    enum Sizes: CGFloat {
        case closeSideLength = 32
        case profileImageSideLength = 256
    }
    
    private let user = Auth.auth().currentUser
    
    @Binding public var presentedAsModule: Bool
    
    @State private var errorMessage = false
    @State private var successMessage = false
    @State private var isUpdatingUsername = false
    @State private var isChangingPassword = false
    @State private var validOldPassword = false
    
    @State private var usernameDisplay: String?
    
    @State private var username: String = ""
    @State private var statusMessage: String = ""
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { presentedAsModule = false }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: Sizes.closeSideLength.rawValue, height: Sizes.closeSideLength.rawValue)
                    .foregroundColor(Color(Colors.featurePurple))
            }.padding(EdgeInsets(top: Spacings.large.rawValue, leading: 0, bottom: 0, trailing: Spacings.medium.rawValue))
        }.padding(.trailing, Spacings.large.rawValue)
        
        Spacer()
        
        VStack(spacing: Spacings.large.rawValue) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: Sizes.profileImageSideLength.rawValue, height: Sizes.profileImageSideLength.rawValue)
                .foregroundColor(Color(Colors.featurePurple))
            
            VStack() {
                Text(usernameDisplay ?? user?.displayName ?? Strings.noUsernameFound)
                    .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: Spacings.medium.rawValue, trailing: 0))
                
                Button( action: {
                    isUpdatingUsername = true
                    resetStatus()
                } ) {
                    Text(Strings.updateUsername)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                }
            }
            
            if isUpdatingUsername {
                VStack {
                    TextField(Strings.newUsername,
                              text: $username)
                        .padding(Spacings.extraSmall.rawValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color(Colors.backgroundPurple))
                
                    Button(action: { updateUserName() }) {
                        Text(Strings.updateName)
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                    }
                    .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                    .background(Color(Colors.featurePurple).opacity(0.5))
                    .cornerRadius(Values.smallCornerRadius.rawValue)
                }
            }
            
            VStack(spacing: Spacings.medium.rawValue) {
                Text("\(Strings.email): \(user?.email ?? Strings.emailError)")
                    .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                
                Button( action: {
                            isChangingPassword = true
                            errorMessage = false
                            successMessage = false
                } ) {
                    Text(Strings.changePassword)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                }
            }.padding(EdgeInsets(top: Spacings.medium.rawValue, leading: 0, bottom: Spacings.medium.rawValue, trailing: 0))
            
            if isChangingPassword {
                VStack {
                    SecureField(Strings.oldPassword,
                              text: $oldPassword)
                        .padding(Spacings.extraSmall.rawValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color(Colors.backgroundPurple))
                }
                
                Button(action: { confirmOldPassword() }) {
                    Text(Strings.continueText)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                }
                .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                .background(Color(Colors.featurePurple).opacity(0.5))
                .cornerRadius(Values.smallCornerRadius.rawValue)
            }
            
            if validOldPassword {
                VStack {
                    SecureField(Strings.newPassword,
                              text: $newPassword)
                        .padding(Spacings.extraSmall.rawValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color(Colors.backgroundPurple))
                }
                
                Button(action: { setNewPassword() }) {
                    Text(Strings.setPassword)
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                }
                .padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                .background(Color(Colors.featurePurple).opacity(0.5))
                .cornerRadius(Values.smallCornerRadius.rawValue)
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
        }.padding(Spacings.huge.rawValue)
        .preferredColorScheme(.light)
        
        Spacer()
    }
    
    private func resetStatus() {
        errorMessage = false
        successMessage = false
    }
    
    private func updateUserName() {
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            
            resetStatus()
            
            if username != "" {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error != nil {
                        statusMessage = Strings.usernameUpdateErrorMessage
                        errorMessage = true
                    }
                    else {
                        statusMessage = Strings.usernameUpdated
                        successMessage = true
                        isUpdatingUsername = false
                        usernameDisplay = username
                        username = ""
                    }
                }
            } else {
                statusMessage = Strings.noUsername
                errorMessage = true
            }
        }
    }
    
    private func confirmOldPassword() {
        if let email = user?.email {
            
            resetStatus()
            
            Auth.auth().signIn(withEmail: email, password: oldPassword) { authResult, error in
                
                if error != nil {
                    statusMessage = Strings.oldPasswordIncorrect
                    errorMessage = true
                } else {
                    validOldPassword = true
                    isChangingPassword = false
                    validOldPassword = true
                    oldPassword = ""
                }
            }
        } else {
            statusMessage = Strings.unexpectedError
            errorMessage = true
        }
    }

    private func setNewPassword() {
        if newPassword != "" {
            
            resetStatus()
            
            Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                if error != nil {
                    statusMessage = Strings.passwordUpdateErrorMessage
                    errorMessage = true
                } else {
                    statusMessage = Strings.passwordUpdated
                    successMessage = true
                    newPassword = ""
                    validOldPassword = false
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static private var presentAsModule = true
    
    static var previews: some View {
        ProfileView(presentedAsModule: $presentAsModule)
    }
}
