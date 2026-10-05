//
//  completeProfilePopUp.swift
//  loginScreen
//
//  Created by Garima Gupta on 25/09/26.
//

import SwiftUI
import Observation
import _PhotosUI_SwiftUI
import PhotosUI


struct completeProfilePopUp: View {
    
    @State var companyAddress = ""
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var uploadedPhoto: UIImage?
    
    var body: some View {
        
        VStack(spacing: 20){
            
            HStack{
                
                Text("Complete Your Profile")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                
                
            }
            
            Divider()
            
            simplePlaceholder(userInput: self.$companyAddress,
                              placeHolderType: "Company Address",
                              promptText: "Enter company address",
                              isRequired: true)
            
            VStack(alignment: .leading, spacing: 20){
                
                Text("Company Logo")
                    .font(.system(size: 16))
                    .foregroundColor(
                        Color(
                            red: 0.27,
                            green: 0.27,
                            blue: 0.31
                        )
                    )
                    .fontWeight(.medium)
                
                PhotosPicker(
                    selection: self.$selectedPhoto,
                    matching: .images
                ){
                    
                    ZStack(alignment: .leading){
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                    appColors.buttonOrangeColor,
                                    style: StrokeStyle(
                                        lineWidth: 2,
                                        dash: [4, 4]
                                    )
                                )
                            .fill(appColors.buttonOrangeColor)
                            .opacity(0.2)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 70
                            )
                        
                        HStack{
                            
                            if let uploadedPhoto {
                                Image(uiImage: uploadedPhoto)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 35, height: 35)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
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
                            
                            VStack(alignment: .leading){
                                
                                Text("Upload company Logo")
                                    .font(.system(size: 16))
                                    .foregroundColor(
                                        Color(
                                            red: 0.27,
                                            green: 0.27,
                                            blue: 0.31
                                        )
                                    )
                                    .fontWeight(.bold)
                                
                                Text("PNG or JPG")
                                    .font(.system(size: 12))
                                    .foregroundColor(
                                        Color(
                                            red: 0.27,
                                            green: 0.27,
                                            blue: 0.31
                                        )
                                    )
                                    .fontWeight(.bold)
                                
                            }
                            
                        }.padding(20)
                    }
                    
                    
                    
                }.frame(
                    height: 70
                )
                
            
                Divider()
                
                Spacer()
                
                footerButton(title: "Save & Continue",
                             image: nil,
                             action: {print("save and continue")})
                
            }
        }.padding(.horizontal, 20)
        
    }
    
}

#Preview{
    completeProfilePopUp()
}
