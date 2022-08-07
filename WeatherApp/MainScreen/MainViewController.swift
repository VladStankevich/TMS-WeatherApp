import UIKit
import AVFoundation

protocol MainViewDelegate: AnyObject {
    func updateUI(with dailyForecast: DailyModel)
    func showAlert(title: String)
//    func updateDailyImageCell(with image: UIImage, for: DailyTableViewCell)
//    func updateHourlyImageCell(with image: UIImage, for: HourlyCollectionViewCell)
}

class MainViewController: UIViewController {
    
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    var playerItem: AVPlayerItem?
    
    let blurEffect = BlurEffect()
    
    let presenter: MainPresenter
    
    private let cityLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "Минск"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
     var weatherView: TopView = {
        
        let weatherView = TopView()
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.contentHuggingPriority(for: .vertical)
        weatherView.alpha = 1
        
        return weatherView
        
    }()
    
     let hourlyCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.reuseId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let dailyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseId)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 10
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
        presenter.setUpWeather()
        
    }
    
    //MARK: - Initialization
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    
    private func makeConstraints() {
        view.addSubview(weatherView)
        view.addSubview(hourlyCollectionView)
        view.addSubview(dailyTableView)
        
        NSLayoutConstraint.activate([
            
            //weatherView
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            weatherView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            //collectionView
            hourlyCollectionView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 8),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            //dailyTableView
            dailyTableView.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 10),
            dailyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dailyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            dailyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
        ])
    }
    
     func configureWeatherConditionVideo(icon: String){
        
        guard let path = Bundle.main.path(forResource: icon, ofType:"mp4") else { return }
        player = AVQueuePlayer()
        playerLayer = AVPlayerLayer(player: self.player)
        playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
        playerLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLooper = AVPlayerLooper(player: self.player as! AVQueuePlayer, templateItem: self.playerItem!)

        weatherView.videoView.layer.addSublayer(self.playerLayer!)
        playerLayer?.frame = self.weatherView.videoView.bounds
        self.player.play()
        UIView.animate(withDuration: 1, delay: 0.3, options: [.allowUserInteraction], animations:
                        { () -> Void in
                        self.weatherView.videoView.alpha = 0.75
                        })
    }
    
     func configureBackgroundColor(icon: String){
        switch icon {
        case "01d":
            view.backgroundColor = UIColor(red: 0.1113159284, green: 0.5214003325, blue: 0.9103012681, alpha: 1)
        case "02d", "03d", "04d", "unknown":
            view.backgroundColor = UIColor(red: 0.22819677, green: 0.5419401526, blue: 0.7971643806, alpha: 1)
        case "09d","09n", "10d","10n", "13d", "13n":
            view.backgroundColor = UIColor(red: 0.1830025315, green: 0.3757502437, blue: 0.5348874927, alpha: 1)
        case "50d":
            view.backgroundColor = UIColor(red: 0.2699401379, green: 0.561641037, blue: 0.7918332219, alpha: 1)
        case "01n", "02n", "03n", "04n":
            view.backgroundColor = UIColor(red: 0.03176918998, green: 0.1420978308, blue: 0.28448385, alpha: 1)
        case "11d", "11n":
            view.backgroundColor = UIColor(red: 0.149156034, green: 0.3194305599, blue: 0.5500941873, alpha: 1)
        case "50n":
            view.backgroundColor = UIColor(red: 0.3737272024, green: 0.5172019601, blue: 0.5837426186, alpha: 1)
        default:
            view.backgroundColor = .black
        }
    }

 
}





