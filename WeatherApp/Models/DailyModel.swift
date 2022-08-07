import Foundation

struct DailyModel: Codable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
    
    struct Current: Codable {
        let dt: Int
        let temp: Float
        let weather: [Weather]
        
        struct Weather: Codable {
            let description: String
        }
    }
    
    struct Hourly: Codable {
        let dt: Int
        let temp: Float
        let weather: [Weather]
        
        struct Weather: Codable {
            let icon: String
        }
    }
    
    struct Daily: Codable {
        let dt: Int
        let temp: Temp
        let weather: [Weather]
        
        struct Temp: Codable {
            let day: Float
            let min: Float
            let max: Float
        }
        
        struct Weather: Codable {
            let icon: String
        }
    }
}
