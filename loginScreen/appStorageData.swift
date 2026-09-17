//
//  appStorage.swift
//  loginScreen
//
//  Created by Garima Gupta on 17/09/26.
//

import SwiftUI

final class appStorageData{
    
    static let shared = appStorageData()
    
    private init() {}
    
    @AppStorage("accessToken")
    var accessToken: String = ""
    
    @AppStorage("refeshToken")
    var refreshToken: String = ""
    
    
    
}
