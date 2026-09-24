//
//  homeDashboard.swift
//  loginScreen
//
//  Created by Garima Gupta on 24/08/26.
//

import SwiftUI

struct homeDashboard: View {
    
    @State private var searchText = ""
    
    let messages = [
        "Your smart photo-review assistant",
        "Suggests fixes before you submit",
        "Reviews your photos instantly",
        "Helps you catch issues early"
    ]
    
    @State private var currentMessage = 0
    @State private var isAnimating = false
    @State private var showSideMenuBar = false
    @State private var showCalender = false
    @State private var selectedDate = Date()
    @State private var showFilterPopup = false
    
    @State private var navigateToProfileScreen = false
    
    
    var body: some View {
        
        ZStack{
            
            NavigationStack{
                
                //main vertical stack
                VStack(spacing: 20){
                    
                    //header horizontal stack
                    HStack{
                        
                        Button{
                            
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.showSideMenuBar = true
                            }
                            
                        } label: {
                            Image("optionLogo")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        searchBar(searchText: $searchText)
                        
                        HStack{
                            
                            Image("phoneImage")
                                .resizable()
                                .frame(width: 16, height: 16)
                            
                            Text("Help")
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                        }
                        
                    }
                    
                    
                    //work orders horizontal stack
                    
                    HStack{
                        
                        Text("Work Orders")
                            .fontWeight(.bold)
                            .font(.system(size: 27))
                        
                        Spacer()
                        
                        
                        Button{
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.showFilterPopup = true
                            }
                            
                        }label: {
                            Image("filterImage")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        
                        
                        
                        
                        Button{
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.showCalender = true
                            }
                        }label:{
                            Image("calenderImage")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        
                        
                        
                    }
                    //orange box stack
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(appColors.buttonOrangeColor)
                            .stroke(appColors.buttonOrangeColor)
                            .opacity(0.2)
                        
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(appColors.buttonOrangeColor.opacity(0.15))
                                        .frame(width: 70, height: 70)
                                        .scaleEffect(isAnimating ? 0.8 : 1)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(appColors.buttonOrangeColor.opacity(0.25))
                                        .frame(width: 55, height: 55)
                                        .scaleEffect(isAnimating ? 0.8 : 1)
                                    
                                    Image("aiLogo")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                        .background(appColors.buttonOrangeColor)
                                        .frame(width: 40, height: 40)
                                        .scaledToFit()
                                        .cornerRadius(10)
                                }.onAppear{
                                    withAnimation(
                                        .easeInOut(duration: 0.8)
                                        .repeatForever(autoreverses: true)){
                                            self.isAnimating = true}
                                    
                                }
                                
                                
                                
                                VStack{
                                    
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
                            
                            
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .stroke(appColors.buttonOrangeColor)
                                    .padding(.horizontal, 20)
                                
                                HStack{
                                    
                                    ZStack{
                                        
                                        Circle()
                                            .fill(appColors.buttonOrangeColor.opacity(0.15))
                                            .frame(width: 30, height: 30)
                                            .scaleEffect(isAnimating ? 1.4 : 0.8)
                                        
                                        Circle()
                                            .fill(appColors.buttonOrangeColor.opacity(0.4))
                                            .frame(width: 18, height: 18)
                                            .scaleEffect(isAnimating ? 1.4 : 0.8)
                                        
                                        Circle()
                                            .fill(appColors.buttonOrangeColor.opacity(0.8))
                                            .frame(width: 8, height: 8)
                                        
                                        
                                    }.onAppear{
                                        withAnimation(
                                            .easeInOut(duration: 0.8)
                                            .repeatForever(autoreverses: true)){
                                                self.isAnimating = true}
                                        
                                        
                                    }
                                    
                                    Text(self.messages[currentMessage])
                                        .foregroundColor(appColors.placeHolderbarDarkGrayColor)
                                        .fontWeight(.bold)
                                        .font(.system(size: 16))
                                        .padding(.vertical)
                                        .id(self.currentMessage)
                                        .transition(
                                            .asymmetric(
                                                insertion: .move(edge: .bottom)
                                                    .combined(with: .opacity),
                                                removal: .move(edge: .top)
                                                    .combined(with: .opacity)
                                            )
                                        )
                                        .onAppear {
                                            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    currentMessage = (currentMessage + 1) % messages.count
                                                }
                                            }
                                        }
                                    
                                }
                                
                            }.padding(.bottom)
                            
                        }
                        
                    }.frame(height: 150)
                    
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
                                 action: { print("start survey  clicked") } )
                    
                }.navigationBarBackButtonHidden(true)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                
                    .overlayPresentation(
                        isPresented: self.$showCalender
                    ) {
                        VStack {
                            
                            Spacer()
                            
                            calender(
                                selectedDate: self.$selectedDate
                            )
                            
                        }.ignoresSafeArea()
                            .transition(.move(edge: .bottom))
                    }
                
                    .navigationDestination(
                        isPresented: self.$navigateToProfileScreen
                    ){profileScreen(token: appStorageData.shared.accessToken)}
                
                    .overlayPresentation(
                        isPresented: self.$showSideMenuBar
                    ) {
                        sideMenuBar
                            .transition(.move(edge: .leading))
                    }
                
                    .overlayPresentation(
                        isPresented: self.$showFilterPopup
                    ) {
                        filterPopup()
                            .offset(x: 50, y: -210)
                    }
                
            }
            
        }
        
    }
    
    
    //side menu bar
    
    var sideMenuBar: some View{
        
        ZStack(alignment: .leading){
            
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30){
                
                //orange block
                ZStack(alignment: .leading){
                    
                    appColors.buttonOrangeColor
                    
                    HStack(spacing: 20){
                        
                        Image("profileImage")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width:40, height:40)
                            .foregroundColor(appColors.buttonOrangeColor)
                            .background(.clear)
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 60,height: 60)
                                
                            )
                        
                        VStack(alignment: .leading){
                            
                            Text("Surveryor")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Surveyor")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                            
                            
                        }
                        
                    }.padding(.leading, 20)
                        .padding(.bottom, -200)
                }.frame(height: 180)
                
                HStack{
                    
                    Button{
                        self.navigateToProfileScreen = true
                    }label:{
                        Image("profileImage")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                        
                        Text("Profile")
                            .font(.system(size: 18))
                            .foregroundColor(appColors.placeHolderbarDarkGrayColor)
                            .fontWeight(.bold)
                    }
                }.padding(.leading, 20)
                
                
                Spacer()
                
                Divider()
                
                HStack{
                    
                    
                    Image("logoutImage")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                    
                    Text("Log Out")
                        .foregroundColor(.red)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    
                }.padding(.leading, 20)
                    .padding(.bottom, 50)
                
                
            }.ignoresSafeArea()
            
        }.padding(.trailing, UIScreen.main.bounds.width * 0.2)
        
    }
}

