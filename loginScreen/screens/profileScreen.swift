//
//  profileScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 22/09/26.
//
import SwiftUI
import PhotosUI

struct profileScreen: View{
    
    let accessToken: String
    
    @State var viewModel: profileScreenViewModel
    
    init(token: String) {
            self.accessToken = token
            _viewModel = State(
                initialValue: profileScreenViewModel(token: token)
            )
        }
    
    var body: some View{
        
        VStack(){
            
            ScrollView{
                
                VStack(spacing: 15){
                    
                    PhotosPicker(selection: self.$viewModel.selectedUserProfilePhoto,
                                 matching: .images){
                        
                        if let selectedImage = self.viewModel.userImage{
                            
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFit()
                                .clipShape(
                                    Circle()
                                        
                                )
                            
                        }else{
                            
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
                        }
                    } .onChange(of: self.viewModel.selectedUserProfilePhoto) {
                        Task {
                            await self.viewModel.loadUserAvatar()

                            await self.viewModel.uploadUserAvatar(type: PhotoType.userProfilePhoto.rawValue)
                        }
                    }
                    
                    
                    HStack{
                        
                        simplePlaceholder(userInput: self.$viewModel.firstName,
                                          placeHolderType: "First Name",
                                          promptText: self.viewModel.firstName ,
                                          isRequired: false)
                        
                        
                        simplePlaceholder(userInput: self.$viewModel.lastName,
                                          placeHolderType: "Last Name",
                                          promptText: "",
                                          isRequired:  false)
                        
                    }
                    
                    phonenumberPlaceholder(countryCode: self.$viewModel.countryCode,
                                           phoneNumber: self.$viewModel.phoneNumber,
                                           isRequired: false)
                       
                    
                    emailPlaceholder(userMail: self.$viewModel.email,
                                     isRequired: false)
                    .disabled(true)
                    .opacity(0.6)
                    
                    simplePlaceholder(userInput: self.$viewModel.companyName,
                                      placeHolderType: "Company Name",
                                      promptText: "",
                                      isRequired:  false)
                    
                    
                    simplePlaceholder(userInput: self.$viewModel.companyAddress,
                                      placeHolderType: "Company Address",
                                      promptText: "",
                                      isRequired:  false)
                    
                    
                    
                    
                    
                    VStack{
                        
                        PhotosPicker(selection: self.$viewModel.selectedCompanyLogo,
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
                                            
                                            if let selectedImage = self.viewModel.companyLogoImage {
                                                Image(uiImage: selectedImage)
                                                    .resizable()
                                                    .frame(width: 35, height: 35)
                                                    .scaledToFit()
                                                    .cornerRadius(10)
                                            }else{
                                                
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
                                            }
                                            
                                            Text("Company Logo")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                                                .fontWeight(.medium)
                                        }.padding(.leading, 10)
                                        
                                    } }
                                    
                                
                                
                            }
                            
                        
                        .onChange(of: self.viewModel.selectedCompanyLogo) {
                            Task {
                                await self.viewModel.loadSelectedPhoto()

                                await self.viewModel.uploadCompanyLogo(type: PhotoType.companyLogo.rawValue)
                            }
                        }
                        
                    }
                    
                    copysimplePlaceholder(userInput: self.$viewModel.inviteCode,
                                          placeHolderType: "Invite Code",
                                          promptText: "WM-UQGJ-TEAN",
                                          isRequired: false)
                    .disabled(true)
                    .opacity(0.6)
                    
                    
                }.padding(.horizontal, 20)
                 .padding(.vertical, 20)
                
            }
            
            Spacer()
            
            footerButton(title: "Submit",
                         image: nil,
                         action: {
                Task{
                    
                    await self.viewModel.updateProfile()
                    
                }
                
                
                
            })
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
            .task {
                await viewModel.getProfile()
            }
    }
}
