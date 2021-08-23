//
//  LoginView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-18.
//

import Firebase
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var homeView: Bool = false
    @State private var errorCreatingAccount: Bool = false
    @State private var errorLoggingIn: Bool = false
    @State private var errorResettingPassword: Bool = false
    @State private var passwordResetSent: Bool = false
    
    var body: some View {
        if homeView {
            HomeView()
        }
        else {
            ZStack() {
                LinearGradient(gradient:
                                Gradient(colors: [Color(Colors.backgroundPurple), Color.black]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
                
                // MARK: Main Stack
                VStack() {
                    Text(Strings.appName.capitalized)
                        .font(.system(size: Fonts.login.rawValue, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Text(Strings.signIn)
                        .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                    
                    // MARK: Sign-in Stack
                    VStack(alignment: .leading, spacing: Spacings.large.rawValue) {
                        HStack() {
                            Text("\(Strings.username): ")
                                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            TextField(
                                " \(Strings.email)",
                                text: $username
                            )
                            .autocapitalization(.none)
                            .padding(Spacings.small.rawValue)
                            .background(Color.gray)
                            .cornerRadius(Values.cornerRadius.rawValue)
                        }
                        
                        HStack() {
                            Text("\(Strings.password): ")
                                .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            SecureField(
                                " \(Strings.password)",
                                text: $password
                            )
                            .autocapitalization(.none)
                            .padding(Spacings.small.rawValue)
                            .background(Color.gray)
                            .cornerRadius(Values.cornerRadius.rawValue)
                        }
                    }.padding(Spacings.large.rawValue)
                    
                    // Login Button
                    Button(action: { authenticateUser() }) {
                        Text(Strings.signInButton)
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                    }.padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                    .background(Color.blue)
                    .cornerRadius(Values.smallCornerRadius.rawValue)
                    .padding(.bottom, Spacings.medium.rawValue)
                    
                    if let statusText = statusView() {
                        statusText
                    }
                    else {
                        Divider()
                    }
                    
                    // Create New Account Button
                    Button(action: { createNewAccount() }) {
                        Text(Strings.newAccount)
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                    }.padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                    .background(Color(Colors.backgroundPurple).opacity(0.1), alignment: .center)
                    .cornerRadius(Values.cornerRadius.rawValue)
                    .padding(.top, Spacings.medium.rawValue)
                    
                    // Forgot Password Button
                    Button(action: { forgotPassword() }) {
                        Text(Strings.forgotPassword)
                            .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                    }.padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.enormous.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.enormous.rawValue))
                    .background(Color(Colors.backgroundPurple).opacity(0.1), alignment: .center)
                    .cornerRadius(Values.cornerRadius.rawValue)
                    
                    Spacer()
                    
                    Text(Strings.slogan)
                        .font(.system(size: Fonts.title.rawValue, weight: .light, design: .serif))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, Spacings.large.rawValue)
                }.padding(Spacings.large.rawValue)
            }
        }
    }
    
    private func statusView() -> Text? {
        var statusText: Text?
        var textColor: Color = .red
        
        if errorCreatingAccount {
            statusText = Text(Strings.createAccountError)
        } else if errorLoggingIn {
            statusText = Text(Strings.loginError)
        } else if errorResettingPassword {
            statusText = Text(Strings.passwordResetError)
        } else if passwordResetSent {
            statusText = Text(Strings.passwordResetSent)
            textColor = .green
        }
        
        if let text = statusText {
            return text.font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                .foregroundColor(textColor)
        }
        
        return statusText
    }
    
    private func createNewAccount() {
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            resetStatus()
            
            if error != nil {
                errorCreatingAccount = true
            } else {
                homeView = true
            }
        }
    }
    
    private func authenticateUser() {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            resetStatus()
            
            if error != nil {
                errorLoggingIn = true
            } else {
                homeView = true
            }
        }
    }
    
    private func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: username) { error in
            resetStatus()
            
            if error != nil {
                errorResettingPassword = true
            } else {
                passwordResetSent = true
            }
        }
    }
    
    private func resetStatus() {
        errorCreatingAccount = false
        errorLoggingIn = false
        errorResettingPassword = false
        passwordResetSent = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
