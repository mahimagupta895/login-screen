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
    var selectedPhoto : PhotosPickerItem?
    var selectedImage : UIImage?
    
    func loadSelectedPhoto(){
        
        
        Task{
            
            if let data = try? await selectedPhoto?.loadTransferable(
                type: Data.self
            ) {
                
                // Convert Data into UIImage
                // UIImage is the actual image we can display/use
                selectedImage = UIImage(data: data)
            }
        }
    }
    
}
