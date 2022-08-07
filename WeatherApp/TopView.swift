import UIKit
import AVFoundation

class TopView: UIView {
    
    var dailyWeatehr: DailyModel?
    
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    var playerItem: AVPlayerItem?
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "Минск"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "-"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let maxMinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.alpha = 0
//        view.backgroundColor = .green
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(videoView)
        addSubview(cityLabel)
        addSubview(descriptionLabel)
        addSubview(maxMinLabel)
        addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            
            //city label
            cityLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 8),
            cityLabel.heightAnchor.constraint(equalToConstant: 50),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            cityLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            
            
            //description label
            descriptionLabel.bottomAnchor.constraint(equalTo: maxMinLabel.topAnchor, constant: -8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 18),
            descriptionLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            
            
            //maxMinLabel constraints
            maxMinLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            maxMinLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            maxMinLabel.heightAnchor.constraint(equalToConstant: 18),
            maxMinLabel.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 10),
            
            // tempLabel constraints
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tempLabel.heightAnchor.constraint(equalToConstant: 50),
            tempLabel.widthAnchor.constraint(equalToConstant: 150),
            
            // videoView constraints
            videoView.topAnchor.constraint(equalTo: topAnchor),
            videoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            videoView.heightAnchor.constraint(equalToConstant: 230),
            
            
        ])
    }

}
