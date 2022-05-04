//
//  MainWeatherTableViewCell.swift
//  Final Project
//
//  Created by Денис Сторожик on 30.04.2022.
//

import UIKit

class MainWeatherTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static let identifier = "MainWeatherTableViewCell"

        static func nib() -> UINib {
            return UINib(nibName: "MainWeatherTableViewCell",
                         bundle: nil)
        }

        func configure(with model: Daily) {
            self.highTempLabel.textAlignment = .center
            self.lowTempLabel.textAlignment = .center
            self.lowTempLabel.text = "\(Int(model.temp.min))°"
            self.highTempLabel.text = "\(Int(model.temp.max))°"
            self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.dt)))

        }

        func getDayForDate(_ date: Date?) -> String {
            guard let inputDate = date else {
                return ""
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE" // Monday
            return formatter.string(from: inputDate)
        }
        
    }
