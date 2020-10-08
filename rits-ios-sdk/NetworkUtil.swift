
import Foundation

class NetworkUtil {
    
    func post <E: Encodable, D: Decodable> (urlPath: String, requestObject: E, requestHeaders: [String: String]? = nil, responseType: D.Type, completion: @escaping(D?) -> Void){
        
        if let url = URL(string: urlPath)
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let requestHeaders = requestHeaders {
                for header in requestHeaders {
                    request.addValue(header.value, forHTTPHeaderField: header.key)
                }
            }
            
            let uploadData = try? JSONEncoder().encode(requestObject)
            
            print("URL: \(url)")
            print("Request Data: \(String(data: uploadData!, encoding: String.Encoding.utf8) ?? "")")
            print("HEADERS: \(String(describing: request.allHTTPHeaderFields))")
            
            request.httpBody = uploadData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                DispatchQueue.main.async
                    {
                    
                    guard let data = data else {
                        print("data error")
                        return
                    }

                   // print("Data: \(String(describing: data))")
                        
                    let decoder = JSONDecoder()
                    let responseData = try! decoder.decode(responseType, from: data)
                    completion(responseData)
                    
                }
            }
            
            task.resume()
        }
    }
    
}
