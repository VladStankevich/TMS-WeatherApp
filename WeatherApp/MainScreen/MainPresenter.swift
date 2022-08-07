import Foundation

class MainPresenter {
    
    private let networkingManager = NetworkingManager()
    
    weak var viewDelegate: MainViewDelegate?
    
    var dailyForecast: DailyModel?
    
    
     func setUpWeather() {
        networkingManager.request(endpoint: WeatherAPI.link) { (result: Result<DailyModel, NetworkingError>) in
            switch result {
            case .success(let weather):
                self.viewDelegate?.updateUI(with: weather)
//                self.dailyForecast = weather
                
            case .failure(let error):
                self.viewDelegate?.showAlert(title: error.rawValue)
            }
            
        }
    }
    
    
}
