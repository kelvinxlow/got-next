//
//  LoginView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-18.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack() {
            LinearGradient(gradient:
                            Gradient(colors: [Color("FeaturePurple").opacity(0.5), Color.black.opacity(0.7)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack() {
                Text("GOT NEXT")
                    .font(.system(size: Fonts.login.rawValue, weight: .bold, design: .serif))
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Text("Sign In")
                    .font(.system(size: Fonts.title.rawValue, weight: .medium, design: .serif))
                    .foregroundColor(Color.white)
                
                VStack(alignment: .leading, spacing: Spacings.large.rawValue) {
                    HStack() {
                        Text("Username:")
                            .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 25)
                            .foregroundColor(Color.gray)
                    }
                    
                    HStack() {
                        Text("Password:")
                            .font(.system(size: Fonts.subTitle.rawValue, weight: .medium, design: .serif))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(height: 25)
                            .foregroundColor(Color.gray)
                    }
                }.padding(Spacings.large.rawValue)
                
                Button(action: { print("Log in") }) {
                    Text("Let's Roll")
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                }.padding(EdgeInsets(top: Spacings.medium.rawValue, leading: Spacings.huge.rawValue, bottom: Spacings.medium.rawValue, trailing: Spacings.huge.rawValue))
                .background(Color.blue)
                .cornerRadius(Values.smallCornerRadius.rawValue)
                .padding(.bottom, Spacings.medium.rawValue)
                
                Divider()
                
                Button(action: { print("New account") }) {
                    Text("Create new account")
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                }.padding(Spacings.medium.rawValue)
                .background(Color("FeaturePurple").opacity(0.1), alignment: .center)
                .cornerRadius(Values.cornerRadius.rawValue)
                .padding(.top, Spacings.medium.rawValue)
                
                Button(action: { print("Forgot Password") }) {
                    Text("Forgot password?")
                        .font(.system(size: Fonts.header.rawValue, weight: .medium, design: .serif))
                        .foregroundColor(Color.white)
                }.padding(Spacings.medium.rawValue)
                .background(Color("FeaturePurple").opacity(0.1), alignment: .center)
                .cornerRadius(Values.cornerRadius.rawValue)
                
                
                Spacer()
                
                Text("Do you have what it takes to be on next?")
                    .font(.system(size: Fonts.title.rawValue, weight: .light, design: .serif))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, Spacings.large.rawValue)
            }.padding(Spacings.large.rawValue)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
