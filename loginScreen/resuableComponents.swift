//
//  resuableComponents.swift
//  loginScreen
//
//  Created by Garima Gupta on 21/08/26.
//
import SwiftUI
  
//login block

struct loginBlock: View {

    let loginType: String
    let loginLogoImage: String

    var body: some View {

        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.gray, lineWidth: 1)
            .frame(width: 300, height: 45)
            .foregroundStyle(Color.white)
            .overlay {
                HStack {

                    Image(loginLogoImage)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()

                    Text("Continue with \(loginType)")
                        .font(.system(size: 16))
                        .fontWeight(.medium)

                }.padding(20)
            }
    }
}

//email placeholder

struct emailPlaceholder: View {

    @Binding var userMail: String
    let isRequired: Bool

    var body: some View {
        VStack(spacing: 6) {
            
            HStack(spacing: 0){
                
                Text("Email")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                    .fontWeight(.medium)
                
                if isRequired{
                    Text("*")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)

            

            TextField(
                "",
                text: $userMail,
                prompt: Text("enter a valid mail")
                    .foregroundStyle(.gray)
            ).padding(.leading, 10)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.93))
                )
            
            if AuthManager.shared.isValidEmail(userMail){
                
                
            }else if !userMail.isEmpty{
                Text("*enter a valid mail")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
        }
    }
}


//password placeholder

struct passwordPlaceholder: View {

    let password: Binding<String>
    let passwordState: String
    let promptText: String
    let showPassword: Binding<Bool>
    let isRequired: Bool

    var body: some View {
        

        VStack(spacing: 6) {
            
            HStack(spacing: 0){
                
                Text(passwordState)
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                    .fontWeight(.medium)
                
                if isRequired{
                    Text("*")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }

                
            }.frame(maxWidth: .infinity, alignment: .leading)

          
            
            HStack{
                
              
                if showPassword.wrappedValue{
                    TextField(
                        "",
                        text: password,
                        prompt: Text(promptText)
                            .foregroundStyle(.gray))
                }else{
                    SecureField(
                        "",
                        text: password,
                        prompt: Text(promptText)
                            .foregroundStyle(.gray))
                }
                Button{
                    showPassword.wrappedValue.toggle()
                }label: {
                    Image( showPassword.wrappedValue ? "eyeClose" : "eyeOpen")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding()
                }
                
                
            }.padding(.leading, 10)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.93)))
            
        }
    }
}

//search bar

struct searchBar: View {
    
    let searchText: Binding<String>

    var body: some View {

        HStack {
            
            Image("searchImage")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
                .padding(10)
                
            
            TextField("",
                      text: searchText,
                      prompt: Text("search")
            )
            

            }.background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray, lineWidth: 2)
                    .fill(Color(red: 0.95, green: 0.95, blue: 0.93))
                ).padding(.horizontal)
        

    }

}

//footer button

struct footerButton: View{
    
    let title: String
    let image: String?
    let action: () -> Void
    
    var body: some View{
        
        
        Button {
            action()
        } label: {
            HStack{
                
                if let image = image{
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.white)
                }
                
                Text(title)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(.white)
            }.frame(maxWidth: .infinity, minHeight: 60)}
             .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(
                            colors: [appColors.footerGradientLeft, appColors.footerGradientRight],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                    )
       
                 
    }
}

//simple placeholder

struct simplePlaceholder: View{
    
    let userInput: Binding<String>
    let placeHolderType: String
    let promptText: String
    let isRequired: Bool
    
    var body: some View {
        
        VStack(spacing: 6){
            
            HStack(spacing: 0){
                
                
                Text(placeHolderType)
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                    .fontWeight(.medium)
                
                if isRequired{
                    Text("*")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
           
            
            TextField(
                "",
                text: userInput,
                prompt:
                    Text(promptText)
                    .foregroundColor(.gray)
            ).padding(.leading, 10)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                        .fill(Color(red: 0.95, green: 0.95, blue: 0.93))
                )
            
        }
        
    }
}

//phone number placeholder

struct phonenumberPlaceholder: View{
    
    @Binding var countryCode: String
    @Binding var phoneNumber: String
    let isRequired: Bool
    
    var body: some View {
        
        VStack(spacing: 6){
            
            HStack(spacing: 0){
                
                Text("Phone Number")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                    .fontWeight(.medium)
                
                
                if isRequired{
                    Text("*")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
           
            
            HStack(spacing: 0){
                
                Menu{
                    
                    Button("India") {countryCode = "+91"}
                    
                    Button("USA") {countryCode = "+1" }
                    
                    Button("Australia") {countryCode = "+61"}
                } label: {
                    HStack{
                        
                        Text(countryCode)
                            .foregroundColor(.gray)
                        
                        Image("downArrow")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .scaledToFit()
                    }
                }
                
                
                Divider()
                    .frame(height: 10)
                
                TextField(
                    "",
                    text: $phoneNumber,
                    prompt: Text("123-456-7890")
                    
                ).padding(.horizontal, 20)
                
                
            }.padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                    .fill(Color(red: 0.95, green: 0.95, blue: 0.93))
                
            )
            
            
            if AuthManager.shared.isValidPhoneNumber(phoneNumber){
                
                
            }else if !phoneNumber.isEmpty{
                Text("*enter a valid phone number")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
        }
    }
}

// four digit OTP placeholder

struct otpPlaceholder: View {
    
    @Binding var otp: String
    
    var body: some View{
        
        ZStack(alignment: .leading) {
            
            TextField("", text: $otp)
                .frame(width: 236, height: 50)
                .keyboardType(.numberPad)
                .foregroundColor(.clear)
                .accentColor(.clear)
                .onChange(of: otp) { _, newValue in
                    if newValue.count > 4 {
                        otp = String(newValue.prefix(4))
                    }
                    
                }
            
            HStack(spacing: 12) {
                ForEach(0..<4, id: \.self) { index in
                    Text(getDigit(at: index))
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.93))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                }
            }.allowsHitTesting(false)
        }
    }
    
    private func getDigit(at index: Int) -> String {
        let array = Array(otp)
        return index < array.count ? String(array[index]) : ""
    }
}

//navigation title design

func navigationTitleDesign() {
    
    let appearance = UINavigationBarAppearance()

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    
}

//unselected company toggle check

struct UnselectedCompanyToggleCheck: View {
    
    let companyStatus: String
    
    var body: some View {
        
        HStack(spacing: 10){
            
            RoundedRectangle(cornerRadius: 2)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .cornerRadius(5)
            
            Text(companyStatus)
                .font(.system(size: 16))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                .fontWeight(.bold)
            
            
        }.padding(.leading, 10)
         .frame(maxWidth: .infinity/2, minHeight: 50)
         .background(
                RoundedRectangle(cornerRadius: 10)
                   .stroke(Color.gray, lineWidth: 1)
                   .fill(Color(red: 0.95, green: 0.95, blue: 0.93)))
        
        
    }
}

//selected company type toggle

struct SelectedCompanyToggleCheck: View {
    
    let companyStatus: String
    
    var body: some View {
        
        HStack(spacing: 10){
            
            Image("checkImage")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .background(Color(red: 1.00, green: 0.57, blue: 0.00))
                .frame(width:20, height: 20)
                .opacity(0.8)
                .cornerRadius(5)
                
            
            Text(companyStatus)
                .font(.system(size: 16))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                .fontWeight(.bold)
            
            
        }.padding(.leading, 10)
         .frame(maxWidth: .infinity/2, minHeight: 50)
         .background(
                RoundedRectangle(cornerRadius: 10)
                   .stroke(Color.gray, lineWidth: 1)
                   .fill(Color(red: 1.00, green: 0.57, blue: 0.00))
                   .opacity(0.2))
        
        
    }
}

//enum for the company type

enum CompanyType: String{
    
    case newCompany = "New Company"
    case existingCompany = "Existing Company"
    
}

//just a check for the source tree connect

