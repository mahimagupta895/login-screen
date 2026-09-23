//
//  profileScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 22/09/26.
//
import SwiftUI
import PhotosUI

struct profileScreen: View{
    
    @State var viewModel =  profileScreenViewModel()
    
    var body: some View{
        
        VStack(){
            
            ScrollView{
                
                VStack(spacing: 15){
                    
                    Image("addProfileImage")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .foregroundColor(appColors.buttonOrangeColor)
                        .padding(30)
                        .background(
                            Circle()
                                .fill(appColors.placeHolderbarPromptDarkGrayColor)
                                .opacity(0.1)
                        )
                    
                    HStack{
                        
                        simplePlaceholder(userInput: self.$viewModel.firstName,
                                          placeHolderType: "First Name",
                                          promptText: "" ,
                                          isRequired: false)
                        
                        simplePlaceholder(userInput: self.$viewModel.lastName,
                                          placeHolderType: "Last Name",
                                          promptText: "",
                                          isRequired:  false)
                    }
                    
                    phonenumberPlaceholder(countryCode: self.$viewModel.countryCode, phoneNumber: self.$viewModel.phoneNumber, isRequired: false)
                    
                    emailPlaceholder(userMail: self.$viewModel.email,
                                     isRequired: false)
                    
                    simplePlaceholder(userInput: self.$viewModel.companyName,
                                      placeHolderType: "Company Name",
                                      promptText: "",
                                      isRequired:  false)
                    
                    simplePlaceholder(userInput: self.$viewModel.companyAddress,
                                      placeHolderType: "Company Address",
                                      promptText: "",
                                      isRequired:  false)
                    
                    
                    
                    
                    
                    VStack{
                        
                        PhotosPicker(selection: self.$viewModel.selectedPhoto,
                                     matching: .images
                        ){
                            
                            VStack(alignment: .leading){
                                
                                Text("Company Logo")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                                    .fontWeight(.medium)
                                
                                ZStack(alignment: .leading){
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 2)
                                        .fill(Color(red: 0.95, green: 0.95, blue: 0.93))
                                        .frame(maxWidth: .infinity, minHeight: 70)
                                    
                                    HStack(){
                                        
                                        Image("uploadImage")
                                            .resizable()
                                            .renderingMode(.template)
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(appColors.buttonOrangeColor)
                                            .padding(10)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.black, lineWidth: 1)
                                                    .fill(.white)
                                                
                                            )
                                        
                                        Text("Upload Company Logo")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                                            .fontWeight(.medium)
                                    }.padding(.leading, 10)
                                    
                                }
                            }
                            
                        }
                        .onChange(of: self.viewModel.selectedPhoto){
                            
                            Task{
                                
                                if let data = try? await self.viewModel.selectedPhoto?.loadTransferable(
                                    type: Data.self
                                ) {
                                    
                                    // Convert Data into UIImage
                                    // UIImage is the actual image we can display/use
                                    self.viewModel.selectedImage = UIImage(data: data)
                                }
                            }
                            
                        }
                        
                        
                    }
                }.padding(.horizontal, 20)
                    .padding(.vertical, 20)
                
            }
            
            Spacer()
            
            footerButton(title: "Sign In",
                         image: nil,
                         action: {print("submit button clicked")})
            .padding(.horizontal, 20)
            
            Button{
                
            }label: {
                Text("Delete Profile")
                    .font(.system(size: 16))
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .underline()
                
            }
        }.navigationBarBackButtonHidden(false)
            .navigationTitle("Edit Profile")
            .onAppear{ navigationTitleDesign() }
    }
}
