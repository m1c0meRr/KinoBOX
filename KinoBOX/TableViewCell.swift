//
//  TableViewCell.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 1)
    
    private let realNameLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 18),
        color: .gray,
        line: 1)
    
    private var nameStackView = UIStackView()
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    private func setupStackView() {
        
        nameStackView = UIStackView(
            addArrangedSubview: [nameLabel, realNameLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .leading,
            destribution: .equalCentering)
    }
    
    private func setupViews() {
        backgroundColor = .white
        setupStackView()
        
        addSubview(posterImageView)
        addSubview(nameStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            nameStackView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            nameStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func cellConfigure(model: FilmSerchResult) {
        nameLabel.text = model.nameRu
        realNameLabel.text = model.nameEn
        
        let urlString = model.posterUrl
        let url = URL(string: urlString)!
        
        NetworkManager.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let data):
                let image = UIImage(data: data)
                self.posterImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func cellTopConfigure(model: TopRating) {
        nameLabel.text = model.nameRu
        realNameLabel.text = model.nameEn
        
        let urlString = model.posterUrl
        let url = URL(string: urlString)!
        
        NetworkManager.shared.requestImage(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let data):
                let image = UIImage(data: data)
                self.posterImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
