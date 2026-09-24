//
//  AuthService.swift
//  loginScreen
//
//  Created by Garima Gupta on 02/09/26.
//

// this file actually talks to the backend

import Foundation
import PhotosUI

class AuthService {
    
    //function for the sign in by the already existing ussers using passowrd and email

    func signin(request: signinRequest) async throws {

        guard let url = URL(
            string: "https://general-staging.framesense.ai/api/auth/mobile/login"
        ) else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"

        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let encoder = JSONEncoder()

        urlRequest.httpBody = try encoder.encode(request)

        let (data, response) = try await URLSession.shared.data(
            for: urlRequest
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        print("Login successful")
        print(String(data: data, encoding: .utf8) ?? "")
    }
    
    
    //sending the otp by taking the email of the user
    
    func requestOTP(request: sendOtpRequest) async throws -> otpSendingResponse{

            guard let url = URL(
                string: "https://general-staging.framesense.ai/api/auth/mobile/request-otp"
            ) else {
                throw URLError(.badURL)
            }

            var urlRequest = URLRequest(url: url)

            urlRequest.httpMethod = "POST"

            urlRequest.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )

            let encoder = JSONEncoder()

            urlRequest.httpBody = try encoder.encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        print("Response:", String(data: data, encoding: .utf8) ?? "No response body")

            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
        
        print("Status Code:", httpResponse.statusCode)

            guard (200...299).contains(httpResponse.statusCode) else {
                throw URLError(
                    .init(rawValue: httpResponse.statusCode)
                )
            }
        
        return try JSONDecoder().decode(
            otpSendingResponse.self,
            from: data)
        }
    
    
    //fuction for the otp verification sent to the email entered by the new user
    
    func otpVerification(
        request: otpVerificationRequest
    ) async throws -> otpTokenResponse {

        guard let url = URL(
            string: "https://general-staging.framesense.ai/api/auth/mobile/verify-otp"
        ) else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"

        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        urlRequest.httpBody = try JSONEncoder().encode(request)

        // Make the API request
        let (data, response) = try await URLSession.shared.data(
            for: urlRequest
        )

        // Convert response into HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("Verify OTP Status:", httpResponse.statusCode)

        // Print the response received from backend
        print(
            "Verify OTP Response:",
            String(data: data, encoding: .utf8) ?? ""
        )

        // Check whether the API request was successful
        guard 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        print("OTP verification successful")

        // Convert JSON response into OTPVerificationResponse
        return try JSONDecoder().decode(
            otpTokenResponse.self,
            from: data
        )
    }
    
    // func for creating the password for a new user
    
    func createPassword(request: createpasswordRequest, token: String) async throws -> setPasswordResponse {
        
        guard let url = URL(
                string: "https://general-staging.framesense.ai/api/auth/mobile/set-password"
            ) else {
                throw URLError(.badURL)
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"

            urlRequest.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )
        
        urlRequest.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(request)

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            print("Status Code:", httpResponse.statusCode)
            print("Response:", String(data: data, encoding: .utf8) ?? "")

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NSError(
                    domain: "",
                    code: httpResponse.statusCode,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            String(data: data, encoding: .utf8) ?? "Unknown error"
                    ]
                )
            }
        
        let decoder = JSONDecoder()
        
        let decodedResponse = try decoder.decode(setPasswordResponse.self, from: data)
        
        return decodedResponse
        
    }
    
    // function for creating the account
    
    func createAccount(request: createAccountRequest) async throws {
        
        guard let url = URL(
                string: "https://general-staging.framesense.ai/api/auth/mobile/request-otp"
            ) else {
                throw URLError(.badURL)
            }

            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"

            urlRequest.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )

            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(request)

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            print("Status Code:", httpResponse.statusCode)
            print("Response:", String(data: data, encoding: .utf8) ?? "")

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NSError(
                    domain: "",
                    code: httpResponse.statusCode,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            String(data: data, encoding: .utf8) ?? "Unknown error"
                    ]
                )
            }
    }
    
    
    //function for the api to take the access token and give the response of the use

        func fetchProfile(token: String) async throws -> ProfileResponse {

            guard let url = URL(string: "https://general-staging.framesense.ai/api/mobile/profile") else {
                throw URLError(.badURL)
            }
            
            

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            // Bearer token
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            // Response is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept")

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            guard httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }

            print(response)
            
            return try JSONDecoder().decode(ProfileResponse.self, from: data)
        
    }
    
    //function for updating the profile
    
    func updateProfile(
        request: UpdateProfileRequest,
        token: String
    ) async throws {

        guard let url = URL(
            string: "https://general-staging.framesense.ai/api/mobile/profile"
        ) else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)

        // 1. HTTP method
        urlRequest.httpMethod = "PUT"

        // 2. Token
        urlRequest.setValue(
            "Bearer \(token)",
            forHTTPHeaderField: "Authorization"
        )

        // 3. Tell server we are sending JSON
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        // 4. Convert Swift model → JSON
        urlRequest.httpBody = try JSONEncoder().encode(request)

        // 5. Send request
        let (data, response) = try await URLSession.shared.data(
            for: urlRequest
        )

        // 6. Check response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard 200...299 ~= httpResponse.statusCode else {

            print(
                "PUT failed:",
                httpResponse.statusCode,
                String(data: data, encoding: .utf8) ?? ""
            )

            throw URLError(.badServerResponse)
        }

        print("Profile updated successfully")
    }
    


//function for uploading user profile and company logo

func uploadProfileImage(
    image: UIImage,
    token: String,
    type: String
) async throws {

    guard let url = URL(
        string: "https://general-staging.framesense.ai/api/mobile/profile/image"
    ) else {
        throw URLError(.badURL)
    }

    guard let imageData = image.jpegData(
        compressionQuality: 0.8
    ) else {
        throw URLError(.cannotLoadFromNetwork)
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    request.setValue(
        "Bearer \(token)",
        forHTTPHeaderField: "Authorization"
    )

    let boundary = "Boundary-\(UUID().uuidString)"

    request.setValue(
        "multipart/form-data; boundary=\(boundary)",
        forHTTPHeaderField: "Content-Type"
    )

    var body = Data()

    // file
    body.append("--\(boundary)\r\n".data(using: .utf8)!)

    body.append(
        "Content-Disposition: form-data; name=\"file\"; filename=\"profile.jpg\"\r\n"
            .data(using: .utf8)!
    )

    body.append(
        "Content-Type: image/jpeg\r\n\r\n"
            .data(using: .utf8)!
    )

    body.append(imageData)

    body.append("\r\n".data(using: .utf8)!)

    // type
    body.append("--\(boundary)\r\n".data(using: .utf8)!)

    body.append(
        "Content-Disposition: form-data; name=\"type\"\r\n\r\n"
            .data(using: .utf8)!
    )

    body.append("\(type)\r\n".data(using: .utf8)!)

    body.append("--\(boundary)--\r\n".data(using: .utf8)!)

    request.httpBody = body

    let (data, response) = try await URLSession.shared.data(
        for: request
    )

    guard let httpResponse = response as? HTTPURLResponse else {
        throw URLError(.badServerResponse)
    }

    print("Status:", httpResponse.statusCode)
    print(String(data: data, encoding: .utf8) ?? "")

    guard (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
}

}

