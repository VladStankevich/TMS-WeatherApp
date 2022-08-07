
import Foundation

struct WeatherModel: Codable {
    
    let weather: [WeatherModel]
    let main: Main
    var name: String
    
    struct WeatherModel: Codable {
        let description: String
    }
    
    struct Main: Codable {
        let temp: Float
        let tempMin: Float
        let tempMax: Float
        
        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
}
