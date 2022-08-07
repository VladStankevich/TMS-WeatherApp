import Foundation

//https://api.openweathermap.org/data/2.5/onecall?lat=53.9024716&lon=27.5618225&exclude=minutely&appid=9c34bcaf6ad642b9767f26e8402391e5

enum WeatherAPI: API {
    case link


    var scheme: HTTPScheme {
        switch self {
        case .link:
            return .https
        }
    }

    var method: HTTPMethod {
        switch self {
        case .link:
            return .get
        }
    }

    var baseURL: String {
        switch self {
        case .link:
            return "api.openweathermap.org"
        }
    }

    var path: String {
        switch self {
        case .link:
            return "/data/2.5/onecall"
      
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .link:
            return [
                URLQueryItem(name: "lat", value: "53.9024716"),
                URLQueryItem(name: "lon", value: "27.5618225"),
                URLQueryItem(name: "lang", value: "ru"),
                URLQueryItem(name: "exclude", value: "minutely"),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: "9c34bcaf6ad642b9767f26e8402391e5"),

            ]
        
        }
    }

}
