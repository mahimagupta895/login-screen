//
//  profileScreenViewModel.swift
//  loginScreen
//
//  Created by Garima Gupta on 23/09/26.
//
import Foundation
import Observation
import _PhotosUI_SwiftUI

@Observable
@MainActor
class profileScreenViewModel{
    
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    var email = ""
    var companyName = ""
    var companyAddress = ""
    var inviteCode = ""
    var countryCode = "91"
    
    var photoType: String?
    
    var selectedCompanyLogo : PhotosPickerItem?
    var companyLogoImage : UIImage?
    var companyLogoUrl: String?
    
    //user profile photo
    var selectedUserProfilePhoto: PhotosPickerItem?
    var userImage: UIImage?
    var userPhotoUrl: String?
    
    
    var isEmailEditable = true
    var isCompanyNameEditable = true
    var isCompanyAddressEditable = true
    var isCompanyLogoEditable = true
    
    let accessToken : String
    var profile: ProfileResponse?
    
    init(token: String){
        self.accessToken = token
    }
    
   
    func getProfile() async {

            do {

                let response = try await AuthService().fetchProfile(
                    token: accessToken
                )
                
                print(response.companyLogo)

                profile = response

                // Fill fields from API
                self.firstName = response.firstName
                self.lastName = response.lastName
                self.phoneNumber = response.phone
                self.email = response.email
                self.companyName = response.companyName
                self.companyAddress = response.companyAddress
                self.inviteCode = response.joinCode
                self.companyLogoUrl = response.companyLogo
                self.userPhotoUrl = response.avatar

                // Get editable information from API
                self.isEmailEditable = response.editable.email
                self.isCompanyNameEditable = response.editable.companyName
                self.isCompanyAddressEditable = response.editable.companyAddress
                self.isCompanyLogoEditable = response.editable.companyLogo

            } catch {

                print("Profile API Error:", error)
            }
    }
    
    
    //function for uploading company logo
    func loadSelectedPhoto() async {
 
        guard let selectedCompanyLogo else {
            return
        }

        do {
            if let data = try await selectedCompanyLogo.loadTransferable(
                type: Data.self
            ) {
                self.companyLogoImage = UIImage(data: data)
            }
            
            print("company logo loaded successfully")
        } catch {
            print("Unable to load company logo:", error)
        }
    }
    
    //function to load user avatar
    
    func loadUserAvatar() async {
 
        guard let selectedUserProfilePhoto else {
            return
        }

        do {
            if let data = try await selectedUserProfilePhoto.loadTransferable(
                type: Data.self
            ) {
                self.userImage = UIImage(data: data)
            }
            
            print("user avatar uploaded sucessfully")
            
        } catch {
            print("Unable to load user avatar:", error)
        }
    }
    
    
    //upload  company logo and user avatar hitting api and saving it
    
    func uploadCompanyLogo(type: String) async {
 
        guard let companyLogoImage else {
            print("No company logo selected")
            return
        }

        do {
            try await AuthService().uploadProfileImage(
                image: companyLogoImage,
                token: accessToken,
                type: type
            )

            print("Profile image uploaded successfully")

        } catch {
            print("Unable to upload photo:", error)
        }
    }
    
    
    func uploadUserAvatar(type: String) async {
 
        guard let userImage else {
            print("No user avatar selected")
            return
        }

        do {
            try await AuthService().uploadProfileImage(
                image: userImage,
                token: accessToken,
                type: type
            )

            print("Profile image uploaded successfully")

        } catch {
            print("Unable to upload photo:", error)
        }
    }
    
    
    //submit button tap
    func updateProfile() async {
        
        let request = UpdateProfileRequest(firstName: self.firstName,
                                           lastName: self.lastName,
                                           phone: self.phoneNumber,
                                           companyName: self.companyName,
                                           companyAddress: self.companyAddress)
        
        do{
            
            try await AuthService().updateProfile(request: request,
                                                  token: self.accessToken)
            
            
            
            print("profile updated sucessfully")
            
        }catch{
            
            print("Update Profile Error:", error)
        }
         
    }
    
    
    //bottom submit tapped
    
    func submitButtonTapped() async {
        
          await self.updateProfile()
      
    }
}
