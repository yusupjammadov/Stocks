//
//  ListCell.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 30.07.2025.
//

import UIKit
import RxCocoa
import RxSwift

class ListCell: UITableViewCell {
    
    static let identifier = "ListCell"
    
    private let disposeBag = DisposeBag()
    
    private var ticker: String?
    private var isFav: Bool = false
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let stockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = .Montserrat_700_Bold(size: 18)
        label.textColor = .LTPrimaryColor
        return label
    }()
    
    private let favButton = UIButton()
    private let favImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star16X16.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .LTSecondaryColor
        imageView.contentMode = .top
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Montserrat_600_SemiBold(size: 11)
        label.textColor = .black
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Montserrat_700_Bold(size: 18)
        label.textColor = .LTPrimaryColor
        return label
    }()
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .Montserrat_600_SemiBold(size: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        favButton.rx.tap.bind { [weak self] in
            guard let ticker = self?.ticker else { return }
            if let isFav = self?.isFav, isFav {
                FavManager.set(ticker, isFav: false)
            } else {
                FavManager.set(ticker, isFav: true)
            }
        }.disposed(by: disposeBag)
        
        FavManager.favRelay.subscribe { [weak self] nextTicker, isFav in
            guard let ticker = self?.ticker, ticker == nextTicker else { return }
            if isFav {
                self?.favImageView.tintColor = .LTYellow
            } else {
                self?.favImageView.tintColor = .LTSecondaryColor
            }
        }.disposed(by: disposeBag)
        
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
            make.height.equalTo(68)
        }
        
        containerView.addSubview(stockImageView)
        stockImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(52)
            make.centerY.equalToSuperview()
            make.height.equalTo(52)
        }
        containerView.addSubview(tickerLabel)
        tickerLabel.snp.makeConstraints { make in
            make.leading.equalTo(stockImageView.snp.trailing).offset(12)
            make.top.equalTo(stockImageView.snp.top).offset(6)
        }
        containerView.addSubview(favButton)
        favButton.snp.makeConstraints { make in
            make.leading.equalTo(tickerLabel.snp.trailing)
            make.centerY.equalTo(tickerLabel.snp.centerY)
        }
        favButton.addSubview(favImageView)
        favImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
            make.height.equalTo(18)
        }
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(stockImageView.snp.trailing).offset(12)
            make.bottom.equalTo(stockImageView.snp.bottom).offset(-6)
        }
        
        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-17)
            make.top.equalTo(stockImageView.snp.top).offset(6)
        }
        containerView.addSubview(changeLabel)
        changeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(stockImageView.snp.bottom).offset(-6)
        }
    }
    
    func set(stockItem: StockItemModel, hasBackgroundColor: Bool) {
        stockImageView.setImage(urlString: stockItem.logo)
        tickerLabel.text = stockItem.symbol
        titleLabel.text = stockItem.name
        priceLabel.text = "$"+formatNumber(stockItem.price)
        
        ticker = stockItem.symbol
        isFav = FavManager.get(isFav: stockItem.symbol)
        favImageView.tintColor = isFav ? .LTYellow : .LTSecondaryColor
        
        let change = "$"+String(abs(stockItem.change))
        let changePercentage = String(abs(stockItem.changePercent))+"%"
        if stockItem.change < 0 {
            changeLabel.textColor = .LTRed
            changeLabel.text = "-"+change+" (\(changePercentage))"
        } else {
            changeLabel.textColor = .LTGreen
            changeLabel.text = "+"+change+" (\(changePercentage))"
        }
        
        if hasBackgroundColor {
            containerView.backgroundColor = .LTSecondaryBackgroundColor
        } else {
            containerView.backgroundColor = .white
        }
    }
    
    private func formatNumber(_ number: Float) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
        } else {
            return String(format: "%.2f", number)
        }
    }
}
