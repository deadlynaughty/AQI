//
//  AQIBox.swift
//  Proximity Assignment
//
//  Created by Amey Vikkram Tiwari on 27/11/21.
//

import Foundation
import UIKit

class AQICell: UITableViewCell {
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    //MARK: Set properties
    var information: AqiInfo? {
        didSet {
            cityLbl.text = information?.city
            updateTimeLbl.text = information?.updateText
        }
    }
    
    private var cityPaddingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var cityLbl: UILabel = {
        let nameLbl = UILabel()
        nameLbl.backgroundColor = .white
        nameLbl.textColor = .darkText
        nameLbl.textAlignment = .left
        nameLbl.font = UIFont.italicSystemFont(ofSize: 15)
        return nameLbl
    }()
    
    private var aqiLbl: UILabel = {
        let aqiLbl = UILabel()
        aqiLbl.textAlignment = .center
        aqiLbl.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        return aqiLbl
    }()
    
    private var timePaddingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var updateTimeLbl: UILabel = {
        let timeLbl = UILabel()
        timeLbl.backgroundColor = .white
        timeLbl.textColor = .darkText
        timeLbl.textAlignment = .left
        timeLbl.numberOfLines = 0
        timeLbl.font = UIFont.italicSystemFont(ofSize: 15)
        return timeLbl
    }()
    
    private var horizontalSeparator: UIView = {
        let horizontalSeparator = UIView()
        horizontalSeparator.backgroundColor = .black
        return horizontalSeparator
    }()
    
    private var firstSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .black
        return separator
    }()
    
    private var lastSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .black
        return separator
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    //MARK: Set UI of cell
    private func setUI() {
        contentView.backgroundColor =  .white
        contentView.addSubview(cityPaddingView)
        contentView.addSubview(cityLbl)
        contentView.addSubview(aqiLbl)
        contentView.addSubview(timePaddingView)
        contentView.addSubview(updateTimeLbl)
        contentView.addSubview(horizontalSeparator)
        setCityColumn()
        setAQIColumn()
        setLastUpdatedTimeColumn()
        setHorizontalSeparator()
        setVerticalSeparator()
    }
    
    private func setCityColumn() {
        cityPaddingView.translatesAutoresizingMaskIntoConstraints = false
        cityPaddingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cityPaddingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cityPaddingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cityPaddingView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        cityLbl.translatesAutoresizingMaskIntoConstraints = false
        cityLbl.leadingAnchor.constraint(equalTo: cityPaddingView.trailingAnchor).isActive = true
        cityLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cityLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setAQIColumn() {
        aqiLbl.translatesAutoresizingMaskIntoConstraints = false
        aqiLbl.leadingAnchor.constraint(equalTo: cityLbl.trailingAnchor).isActive = true
        aqiLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        aqiLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        aqiLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setLastUpdatedTimeColumn() {
        timePaddingView.translatesAutoresizingMaskIntoConstraints = false
        timePaddingView.leadingAnchor.constraint(equalTo: aqiLbl.trailingAnchor).isActive = true
        timePaddingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        timePaddingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        timePaddingView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        updateTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        updateTimeLbl.leadingAnchor.constraint(equalTo: timePaddingView.trailingAnchor).isActive = true
        updateTimeLbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        updateTimeLbl.widthAnchor.constraint(equalTo: cityLbl.widthAnchor).isActive = true
        updateTimeLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        updateTimeLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setHorizontalSeparator() {
        horizontalSeparator.translatesAutoresizingMaskIntoConstraints = false
        horizontalSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizontalSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        horizontalSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setVerticalSeparator() {
        contentView.addSubview(firstSeparator)
        contentView.addSubview(lastSeparator)
        setFirstSeparator()
        setLastSeparator()
    }
    
    private func setFirstSeparator() {
        firstSeparator.translatesAutoresizingMaskIntoConstraints = false
        firstSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        firstSeparator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        firstSeparator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        firstSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setLastSeparator() {
        lastSeparator.translatesAutoresizingMaskIntoConstraints = false
        lastSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lastSeparator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lastSeparator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        lastSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftBorder = CALayer()
        leftBorder.frame = CGRect.init(x: 0, y: 0, width: 1, height: aqiLbl.frame.size.height)
        leftBorder.backgroundColor = UIColor.black.cgColor
        aqiLbl.layer.addSublayer(leftBorder)
        
        let rightBorder = CALayer()
        rightBorder.frame = CGRect.init(x: aqiLbl.frame.size.width-1, y: 0, width: 1, height: aqiLbl.frame.size.height)
        rightBorder.backgroundColor = UIColor.black.cgColor
        aqiLbl.layer.addSublayer(rightBorder)
    }
    
    //MARK: Call back once animation completes
    func updateInfo(completion: @escaping (Bool) -> Void) {
        if information?.currentRating != information?.previousRating {
            self.aqiLbl.textColor = .darkText
            self.aqiLbl.text = formatter.string(from: NSNumber.init(value: information?.previousAqi ?? 0))
            self.aqiLbl.backgroundColor = self.information?.previousRating.getColorFromAQI
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.animateChanges(completion: completion)
            }
        } else {
            self.updateState()
            completion(false)
        }
    }
    
    func animateChanges(completion: @escaping (Bool) -> Void) {
        UIView.transition(with: self.aqiLbl,
                          duration: 2,
                          options: .transitionCurlDown,
                          animations: { [weak self] in
            self?.aqiLbl.backgroundColor = self?.information?.currentRating.getColorFromAQI
            self?.aqiLbl.text = self?.formatter.string(from: NSNumber.init(value: self?.information?.currentAqi ?? 0))
        }, completion: { animated in
            if animated {
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.updateState()
                    completion(true)
                }
            }
        })
    }
    
    func updateState() {
        aqiLbl.textColor = information?.currentRating.getColorFromAQI
        aqiLbl.text = self.formatter.string(from: NSNumber.init(value: self.information?.currentAqi ?? 0))
        self.aqiLbl.backgroundColor = .white
    }
}
