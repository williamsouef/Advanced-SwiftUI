//
//  SigninWithAppleButton.swift
//  Advanced SwiftUI
//
//  Created by William Souef on 16/12/2022.
//

import SwiftUI
import AuthenticationServices


struct SigninWithAppleButton : UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}
