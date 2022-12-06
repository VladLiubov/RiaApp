//
//  APIService.swift
//  RiaApp
//
//  Created by Admin on 06.12.2022.
//

import Foundation
import SwiftUI
import Combine

class APIService {
    static let shared = APIService()
    
    static let baseURL = "https://randomuser.me/api/?inc=id,name,picture,email,phone,location&nat=ua&results=100"
    
    static func getUsers(for url: URLRequest) -> AnyPublisher<Results, Error>  {
        URLSession.shared
          .dataTaskPublisher(for: url)
          .map(\.data)
          .decode(type: Results.self, decoder: JSONDecoder())
          .eraseToAnyPublisher()
      }
}


struct UserService {
    static func usersList() -> AnyPublisher<Results, Error> {
        let url = URL(string: "\(APIService.baseURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return APIService
            .getUsers(for: request)
    }
}
