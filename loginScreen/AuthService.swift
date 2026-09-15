//
//  AuthService.swift
//  loginScreen
//
//  Created by Garima Gupta on 02/09/26.
//

// this file actually talks to the backend

import Foundation

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
    
    func createPassword(request: createpasswordRequest, token: String) async throws {
        
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
    
}


