//
//  ContentView.swift
//  Advanced SwiftUI
//
//  Created by William Souef on 08/12/2022.
//

import SwiftUI


struct ContentView: View {

    @State private var email : String = ""
    @State private var password : String = ""
    @State private var editingEmailTextfield : Bool = false
    @State private var editingPasswordTextfield: Bool = false
 

    var body: some View {
        ZStack{
            Image("background-3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 16){
                
        Text("Sign up")
                        .font(Font.largeTitle.bold())
                        .foregroundColor(.white)
        Text ("Access to 120+ hours of courses, tutorials, and livestreams")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.7))
                    HStack(spacing: 12.0){
                       TextfieldIcon(iconName: "envelope.open.fill", currentlyEditing: $editingEmailTextfield)
                        TextField("Email", text: $email) { isEditing in
                            editingEmailTextfield = isEditing
                            editingPasswordTextfield = false
                            
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
                    }
                    
                    
                    
                    
                    GradientButton()
                    
                    Text("By clicking on Sign up, you agree to our Terms of services and Privacy policy")
                        .font(.footnote)
                        .foregroundColor(Color.white.opacity(0.7))
                    Rectangle()
                        .frame( height: 1)
                        .foregroundColor(Color.white.opacity(0.1))
                
                    VStack(alignment: .leading, spacing: 16, content: {
                        Button(action: {
                        print("switch to sign in")
                    }, label: {
                        HStack(spacing:4) {
                            Text("Already have an account ?")
                                .font(.footnote)
                                .foregroundColor(Color.white.opacity(0.7))
                            GradientText(text: "Sign in")
                                .font(Font.footnote.bold())
                                
                        }
                    })
                    })
                }
                .padding(20)
            }
            .background(RoundedRectangle(cornerRadius: 30).stroke(Color.white.opacity(0.2)))
            .background(Color("secondaryBackground").opacity(0.5))
            .background(VisualEffectBlur(blurStyle: .systemThinMaterialDark))
            .shadow(color: Color("shadowColor").opacity(0.5), radius: 60, x: 0, y: 30)
            .cornerRadius(30)
            .padding(.horizontal)
     }
        
 }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
}
}



