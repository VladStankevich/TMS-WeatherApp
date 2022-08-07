//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Владислав Станкевич on 12.12.22.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    static let reuseId = "DailyTableViewCell"
    
    private var blurEffectView = BlurEffect()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.text = "сегодня"
        return label
    }()
    
    private lazy var conditionView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .right
        label.textColor = .white
        label.text = "+15º"
        return label
    }()
    
    private var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .right
        label.textColor = .white
        label.text = "+15º"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: -Private methods
   
    
    private func makeConstraints() {
        contentView.addSubview(blurEffectView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(conditionView)
        contentView.addSubview(minLabel)
        contentView.addSubview(maxLabel)
        
        NSLayoutConstraint.activate([
            
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // dateLabel constraints
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            dateLabel.widthAnchor.constraint(equalToConstant: 120),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
            
            // conditionView constraints
            conditionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            conditionView.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor, constant: -18),
            conditionView.widthAnchor.constraint(equalToConstant: 30),
            conditionView.heightAnchor.constraint(equalToConstant: 30),
            
            //minLabel constraints
            minLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            minLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            minLabel.widthAnchor.constraint(equalToConstant: 55),
            
            //maxLabel constraints
            maxLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxLabel.trailingAnchor.constraint(equalTo: minLabel.leadingAnchor, constant: -8),
            maxLabel.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    final func configure(with model: DailyModel.Daily) {
        dateLabel.text = "\(model.dt.getDateStringFromUTC())"
        conditionView.loadImageFromURL(urlString: "http://openweathermap.org/img/wn/\(model.weather[0].icon)@2x.png")
        minLabel.text = "\(Int(model.temp.min))°"
        maxLabel.text = "\(Int(model.temp.max))°"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        conditionView.image = nil
    }
    
    
}
