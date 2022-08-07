import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "DailyTableViewCell"
    private var blurEffectView = BlurEffect()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var conditionView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    private func makeConstraints() {
        contentView.addSubview(blurEffectView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(conditionView)
        contentView.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
        // blurEffectView constraints
        blurEffectView.topAnchor.constraint(equalTo: topAnchor),
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
        // dateLabel constraints
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        // conditionView constraints
        conditionView.centerYAnchor.constraint(equalTo: centerYAnchor),
        conditionView.centerXAnchor.constraint(equalTo: centerXAnchor),
        conditionView.heightAnchor.constraint(equalToConstant: 30),
        conditionView.widthAnchor.constraint(equalToConstant: 30),
        
        // tempLabel constraints
        tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
        tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

    }
    
    final func configure(with model: DailyModel.Hourly) {
        dateLabel.text = "\(model.dt.getHourStringFromUTC())"
        conditionView.loadImageFromURL(urlString: "http://openweathermap.org/img/wn/\(model.weather[0].icon)@2x.png")
        tempLabel.text = "\(Int(model.temp))"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        conditionView.image = nil
        tempLabel.text = nil
    }
    
}


