import Foundation

public class EventTracker {

    static let instance = EventTracker()
    private init() {}
    

    func sayHello(){
        print("------ This is a test pod ------")
        return
    }
    
    func track(event: String) {
        guard let url = URL(string: "https://your.server.com/track") else {
            print("Invalid URL")
            return
        }

        let eventData: [String: String] = ["event": event]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: eventData, options: []) else {
            print("Failed to serialize event data")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Event tracking failed: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Event tracked with status code: \(httpResponse.statusCode)")
            }
        }

        task.resume()
    }
    
    
    
}
