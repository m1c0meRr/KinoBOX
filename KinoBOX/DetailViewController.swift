//
//  TableViewCell.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import UIKit

class DetailViewController: UIViewController {
  
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "poster")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rateKinoLabel = UILabel(
        text: "KINOPOISK",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let rateNumberKinoLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let rateIMDBLabel = UILabel(
        text: "IMDB",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let rateNumberIMDBLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 1)
    
    private let nameLabel = UILabel(
        text: "",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 0)
    
    private let nameRealLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 18),
        color: .gray,
        line: 0)
    
    
    private let descriptionLabel = UILabel(
        text: "",
        font: .systemFont(ofSize: 12),
        color: .black,
        line: 0)
    
    private let yearLabel = UILabel(
        text: "Год производства",
        font: .systemFont(ofSize: 12),
        color: .gray,
        line: 1)
    
    private let yearNumberLabel = UILabel(
        text: "2023",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 0)
    
    private let continLabel = UILabel(
        text: "Продолжительность",
        font: .systemFont(ofSize: 12),
        color: .gray,
        line: 1)
    
    private let continNumberLabel = UILabel(
        text: "150 минут",
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        line: 0)
    
    private var rateStackView = UIStackView()
    private var rateIMDBStackView = UIStackView()
    private var nameStackView = UIStackView()
    private var yearStackView = UIStackView()
    private var contStackView = UIStackView()
    
    private var searchIDFilm: IdFilmSerchResult?
    var filmID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        search2IDFilm()
        setupConstraints()
    }
    
    private func setupStackView() {
        
        rateStackView = UIStackView(
            addArrangedSubview: [rateKinoLabel,
                                 rateNumberKinoLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        rateIMDBStackView = UIStackView(
            addArrangedSubview: [rateIMDBLabel,
                                 rateNumberIMDBLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        nameStackView = UIStackView(
            addArrangedSubview: [nameLabel,
                                 nameRealLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        yearStackView = UIStackView(
            addArrangedSubview: [yearLabel,
                                 yearNumberLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
        
        contStackView = UIStackView(
            addArrangedSubview: [continLabel,
                                 continNumberLabel],
            axis: .vertical,
            spacing: 2,
            aligment: .center,
            destribution: .equalCentering)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        setupStackView()
        
        view.addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(rateStackView)
        scrollView.addSubview(rateIMDBStackView)
        scrollView.addSubview(nameStackView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(yearStackView)
        scrollView.addSubview(contStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            posterImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            rateStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            rateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            rateStackView.heightAnchor.constraint(equalToConstant: 50),
            
            rateIMDBStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            rateIMDBStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            rateIMDBStackView.heightAnchor.constraint(equalToConstant: 50),
            
            nameStackView.topAnchor.constraint(equalTo: rateIMDBStackView.bottomAnchor, constant: 10),
            nameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameStackView.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            yearStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            yearStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            yearStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            yearStackView.heightAnchor.constraint(equalToConstant: 50),
            
            contStackView.topAnchor.constraint(equalTo: yearStackView.bottomAnchor, constant: 10),
            contStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            contStackView.heightAnchor.constraint(equalToConstant: 50),
            contStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
        func search2IDFilm() {
            guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/" + "\(filmID)") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("bee3bcac-4ea0-4da5-9800-8846c7f3e308", forHTTPHeaderField: "X-API-KEY")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            URLSession.shared.dataTask(with: request) { data, responce, error in
                if let data = data {
                    do {
                        let decodeResponce = try JSONDecoder().decode(IdFilmSerchResult.self, from: data)
                        DispatchQueue.main.async {
                            self.searchIDFilm = decodeResponce
                            self.setupDescriptions(model: self.searchIDFilm!)
                        }
                    } catch {
                        print("error:", error)
                    }
                    return
                }
            }.resume()
            
        }
    
    private func setupDescriptions(model: IdFilmSerchResult) {
        
        rateNumberKinoLabel.text = "\(String(describing: model.ratingKinopoisk))"
        rateNumberIMDBLabel.text = "\(String(describing: model.ratingImdb))"
        
        nameLabel.text = model.nameRu
        nameRealLabel.text = model.nameEn
        
        descriptionLabel.text = model.description
        yearNumberLabel.text = "\(String(describing: model.year))"
        continNumberLabel.text = "\(String(describing: model.filmLength) + " мин.")"
        
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
}
