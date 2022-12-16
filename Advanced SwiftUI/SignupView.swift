//
//  SignupView.swift
//  Advanced SwiftUI
//
//  Created by William Souef on 08/12/2022.
//

import SwiftUI
import AudioToolbox
import FirebaseAuth


struct SignupView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var editingEmailTextfield : Bool = false
    @State private var editingPasswordTextfield: Bool = false
    @State private var emailIconBounce: Bool = false
    @State private var passwordIconBounce: Bool = false
    @State private var showProfileView : Bool = false
    @State private var signupToggle : Bool = true
    @State private var rotationAngle = 0.0
    
    
    private let generator = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack{
            Image(signupToggle ? "background-3" : "background-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 16){
                    
                    Text(signupToggle ? "Sign up" : "Sign in")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
                    Text ("Access to 120+ hours of courses, tutorials, and livestreams")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    HStack(spacing: 12.0){
                        TextfieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextfield)
                            .scaleEffect(emailIconBounce ? 1.2 : 1.0)
                        TextField("Email", text: $email) { isEditing in
                            editingEmailTextfield = isEditing
                            editingPasswordTextfield = false
                            generator.selectionChanged()
                            if isEditing {
                                withAnimation(.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.3)){
                                    emailIconBounce.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                        emailIconBounce.toggle()
                                    }
                                }
                            }
                            
                        }
                        .colorScheme(.dark)
                        .foregroundColor(Color.white.opacity(0.7))
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    }
                    .frame(height:52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white,lineWidth: 1.0)
                            .blendMode(.overlay)
                    )
                    .background(Color("secondaryBackground")
                        .cornerRadius(16.0)
                        .opacity(0.8)
                    )
                    HStack(spacing: 12.0){
                        TextfieldIcon(iconName: "key.fill", currentlyEditing: $editingPasswordTextfield)
                            .scaleEffect(passwordIconBounce ? 1.2 : 1.0)
                        SecureField("Password", text: $password)
                            .colorScheme(.dark)
                            .foregroundColor(Color.white.opacity(0.7))
                            .autocapitalization(.none)
                            .textContentType(.password)
                    }
                    .frame(height:52)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white,lineWidth: 1.0)
                            .blendMode(.overlay)
                    )
                    .background(Color("secondaryBackground")
                        .cornerRadius(16.0)
                        .opacity(0.8))
                    
                    .onTapGesture {
                        editingPasswordTextfield = true
                        editingEmailTextfield = false
                        if editingPasswordTextfield {
                            withAnimation(.spring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.3)){
                                passwordIconBounce.toggle()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                                passwordIconBounce.toggle()
                            }
                        }
                    }
                    
                    
// MARK: Create an account / Sign in Button
                    GradientButton(buttonTitle: signupToggle ? "Create an account" : "Sign in") {
                        generator.selectionChanged()
                        signup()
                    }
                    .onAppear() {
                        Auth.auth()
                            .addStateDidChangeListener { auth, user in
                                if user != nil {
                                    showProfileView.toggle()
                                }
                            }
                    }
                    
                    
                    if signupToggle {
                        Text("By clicking on Sign up, you agree to our Terms of services and Privacy policy")
                            .font(.footnote)
                            .foregroundColor(Color.white.opacity(0.7))
                        Rectangle()
                            .frame( height: 1)
                            .foregroundColor(Color.white.opacity(0.1))
                    }
                    
                    VStack(alignment: .leading, spacing: 16, content: {
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.5)){
                                signupToggle.toggle()
                                self.rotationAngle += 180
                            }
                        }, label: {
                            HStack(spacing:4) {
                                Text(signupToggle ? "Already have an account ?" : "Don't have an account ?")
                                    .font(.footnote)
                                    .foregroundColor(Color.white.opacity(0.7))
                                GradientText(text: signupToggle ? "Sign in": "Sign up")
                                    .font(Font.footnote.bold())
                                
                            }
                        })
// MARK: RESET PASSWORD
                        if !signupToggle {
                            Button(action: {
                                print("Send reset password email")
                            }, label: {
                                HStack(spacing:4) {
                                    Text("Forgot your password ?")
                                        .font(.footnote)
                                        .foregroundColor(Color.white.opacity(0.6))
                                    GradientText(text:"Reset your password")
                                        .font(Font.footnote.bold())
                                }
                            })
                        }
                    })
                }
                .padding(20)
            }
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
            .background(RoundedRectangle(cornerRadius: 30).stroke(Color.white.opacity(0.2)))
            .background(Color("secondaryBackground").opacity(0.5))
            .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
            .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            .cornerRadius(30)
            .padding(.horizontal)
            .rotation3DEffect(Angle(degrees: self.rotationAngle), axis: (x: 0.0, y: 1.0, z: 0.0))
        }
        
    }
//MARK: FIREBASE AUTHENTIFICATION
    
    func signup() {
     if signupToggle {
         Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("user signed up")
        }
     } else {
         Auth.auth().signIn(withEmail: email, password: password) {
             result, error in
             guard error == nil else {
                 print(error!.localizedDescription)
                 return
             }
             print("the user is sign in")
         }
     }
    }
    
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}



