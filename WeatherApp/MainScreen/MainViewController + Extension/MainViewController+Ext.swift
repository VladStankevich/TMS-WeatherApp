import Foundation
import UIKit

//DailyTableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dailyForecast?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseId, for: indexPath) as? DailyTableViewCell,
              let cellModel = presenter.dailyForecast?.daily[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(with: cellModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//HourlyCollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.dailyForecast?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.reuseId, for: indexPath) as? HourlyCollectionViewCell,
              let cellModel = presenter.dailyForecast?.hourly[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: cellModel)
        return cell
        
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.size.width - 50) / 4
        let height: CGFloat = 145
        return CGSize(width: width, height: height)
     }
}

extension MainViewController: MainViewDelegate {
    func updateUI(with dailyForecast: DailyModel) {
        self.presenter.dailyForecast = dailyForecast
        DispatchQueue.main.async {
            self.dailyTableView.reloadData()
            self.hourlyCollectionView.reloadData()
            self.configureBackgroundColor(icon: dailyForecast.daily[0].weather[0].icon)
            self.weatherView.cityLabel.text = dailyForecast.timezone
            self.weatherView.tempLabel.text = "\(Int(dailyForecast.daily[0].temp.day))°"
            self.weatherView.descriptionLabel.text = dailyForecast.current.weather[0].description
            self.weatherView.maxMinLabel.text = "макс.:\(Int(dailyForecast.daily[0].temp.max))°, мин.:\(Int(dailyForecast.daily[0].temp.min))°"
            self.configureWeatherConditionVideo(icon: dailyForecast.daily[0].weather[0].icon)
        }
    }
    
    func showAlert(title: String) {
        print("ALERT!")
    }
    
    
}


