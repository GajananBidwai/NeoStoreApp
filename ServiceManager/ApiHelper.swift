//
//  ApiHelper.swift
//  NeoStoreApp
//
//  Created by Neosoft on 01/07/24.
//

import Foundation

class ApiHelpers{
    enum Header{
        case applicationJson
        case formData
        case URLEncoded
    }

    static func postURL<T:Codable>(url: String,param:[String:String],headers:Header  ,module:T.Type ,isAccessTokenRequired : Bool = true ,Success:@escaping((T)->Void), Failuer:@escaping((Error?)->Void)){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        
        if headers == .applicationJson{
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONEncoder().encode(param)
            } catch let error{
                print(error)
            }
        }else if headers == .formData{
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONEncoder().encode(param)
            } catch let error{
                print(error)
            }
        }else if headers == .URLEncoded{
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if isAccessTokenRequired == true{
                let accessToken = UserDefaults.standard.string(forKey: "access_token")
                request.setValue(accessToken, forHTTPHeaderField: "access_token")
            }else{
                print("No Acces Token Required")
            }
            
            
            let parameterArray = param.map { (key, value) -> String in
                return "\(key)=\((value as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            }
            let parameterString = parameterArray.joined(separator: "&")
            print(parameterString)
            request.httpBody = parameterString.data(using: .utf8)
            
        }
        

        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data, let urlRes = urlResponse as? HTTPURLResponse, (200..<300).contains(urlRes.statusCode) else {
                do {
                    let response = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                    print(response ?? "No Response")
                    
                    
                } catch let error {
                    print(error)
                }
                Failuer(error)
                return
            }
            do {
                let response = try JSONDecoder().decode(module, from: data)
                Success(response)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    
// typealias Hander = (Result<ProductDetails, DataError>)-> Void
    enum DataError : Error{
        case invalidResponse
        case invalidUrl
        case invalidDecoding
        case invalidData
        case massage(_ error : Error?)
    }

    static func getApi<T: Decodable>(url: String, module: T.Type, paramter: [String : Any] ,isAccessTokenRequired: Bool = true, Success: @escaping((T) -> Void), Failure: @escaping((DataError) -> Void)) {
        
        var urlComponenet = URLComponents(string: url)
        
        urlComponenet?.queryItems = paramter.map({ key, value in
            URLQueryItem(name: key, value: value as? String)
        })
        
        guard let url = urlComponenet?.url else {
            print("Invalid URL with components")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        if isAccessTokenRequired {
            let accessToken = UserDefaults.standard.string(forKey: "access_token")
            urlRequest.setValue(accessToken, forHTTPHeaderField: "access_token")
        } else {
            print("No access token required")
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let dataRes = data else {
                Failure(.invalidData)
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                Failure(.invalidResponse)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(module.self, from: dataRes)
                Success(response)
         
            } catch let error {
                Failure(.massage(error))
                
            }
        }.resume()
    }

}
