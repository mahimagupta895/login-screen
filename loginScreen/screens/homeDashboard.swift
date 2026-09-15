//
//  homeDashboard.swift
//  loginScreen
//
//  Created by Garima Gupta on 24/08/26.
//

import SwiftUI

struct homeDashboard: View {
    
    @State private var searchText = ""
    
    var body: some View {
        
        //main vertical stack
        VStack{
            
            //header horizontal stack
            HStack{
                
                Button{
                    
                } label: {
                    Image("optionLogo")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                searchBar(searchText: $searchText)
                    .padding(.horizontal, -15)
                
                HStack{
                    
                    Image("phoneImage")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text("Help")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                    
            }.padding()
            
            Spacer()
            
            //work orders horizontal stack
            
            HStack{
                
                Text("Work Orders")
                    .fontWeight(.bold)
                    .font(.system(size: 27))
                
                Spacer()
                
                Image("filterImage")
                    .resizable()
                    .frame(width: 16, height: 16)
                
                Image("calenderImage")
                    .resizable()
                    .frame(width: 16, height: 16)
                
            }
            
            //orange box stack
            
            VStack(alignment:.center, spacing: 15){
                
                
                HStack{
                    
                    Image("aiLogo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(appColors.buttonOrangeColor)
                        .scaledToFit()
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading){
                        
                        Text("Meet Survey Copilot")
                            .font(.system(size: 24))
                            .foregroundColor(appColors.placeHolderbarDarkGrayColor)
                            .fontWeight(.bold)
                        
                        
                        
                        Text("Your smart photo-review assistant")
                            .foregroundColor(appColors.buttonOrangeColor)
                            .fontWeight(.regular)
                            .font(.system(size: 14))
                    }
                    
                }.padding(20)
                    .padding(.top, -10)
                
                // * Ananlyzes site photos instantly text and its block
                
                Text("* Ananlyzes site photos instantly")
                    .foregroundColor(appColors.placeHolderbarDarkGrayColor)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .stroke(
                                Color(red: 0.83, green: 0.43, blue: 0.15),
                                lineWidth: 1)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            
                    )
            }
            .padding()
            //background of the * Ananlyzes site photos instantly
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 0.99, green: 0.75, blue: 0.53))
                    .stroke(
                        Color(red: 0.83, green: 0.43, blue: 0.15),
                        lineWidth: 1)
                    .opacity(0.3)
            ).frame( minHeight: 200)
            
            
            //no survey
            
            VStack(spacing: 40){
                
                Image("surveyIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(Color(red: 0.70, green: 0.70, blue: 0.70))
                            .frame(width:100, height: 100)
                            .opacity(0.4)
                        
                        )
                
                Text("No surveys yet")
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    .font(.system(size: 20))
            }.padding(.top, 120)
                .padding(.bottom, 120)
                
            
            Spacer()
            
            footerButton(title: "Start Survey",
                         image: "cameraIcon",
                         action: { print("start survey  clicked") } ).padding()
               
        }.padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        
        }
    }

