//
//  ViewController.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 12.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum Model {
        case keyword, topModel
    }
    
    enum Button {
        case keywordButton, top100, top250, topAwait
    }
    
    private var tableModel = Model.keyword
    private var buttonModel = Button.keywordButton
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.text = nil
        textField.placeholder = "Введите название фильма"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always //
        textField.keyboardType = .default
        textField.returnKeyType = .default //
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("Поиск", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let top100Button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("ТОП-100 фильмов", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let top250Button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("ТОП-250 фильмов", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let topWaitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("ТОП Ожидаемых фильмов", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 140
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var searchFilmArray = [FilmSerchResult]()
    private var searchIDFilm = [IdFilmSerchResult]()
    private var topFilmArray = [TopRating]()
    
    private var currentPage = 1
    private var pageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setTarget()
        setupDelegate()
        setupConstraints()
    }
    
    //MARK: - setupViews
    
    private func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(top100Button)
        view.addSubview(top250Button)
        view.addSubview(topWaitButton)
        view.addSubview(searchLabel)
        view.addSubview(resultTableView)
        
        resultTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    //MARK: - setupDelegate
    
    private func setupDelegate() {
        resultTableView.dataSource = self
        resultTableView.delegate = self
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 2),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            
            top100Button.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            top100Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            top100Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            top100Button.heightAnchor.constraint(equalToConstant: 50),
            
            top250Button.topAnchor.constraint(equalTo: top100Button.bottomAnchor, constant: 10),
            top250Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            top250Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            top250Button.heightAnchor.constraint(equalToConstant: 50),
            
            topWaitButton.topAnchor.constraint(equalTo: top250Button.bottomAnchor, constant: 10),
            topWaitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            topWaitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            topWaitButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchLabel.topAnchor.constraint(equalTo: topWaitButton.bottomAnchor, constant: 50),
            searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            searchLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            
            resultTableView.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 2),
            resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
            resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            resultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableModel {
            
        case .keyword:
            searchFilmArray.count
        case .topModel:
            topFilmArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as!
        TableViewCell
        
        switch tableModel {
        case .keyword:
            let model = searchFilmArray[indexPath.row]
            cell.cellConfigure(model: model)
        case .topModel:
            let model = topFilmArray[indexPath.row]
            cell.cellTopConfigure(model: model)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let height = scrollView.frame.size.height
        let contentOffSet = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentOffSet > contentHeight - height {
            
            currentPage += 1
            
            switch buttonModel {
                
            case .keywordButton:
                searchButtonAction()
            case .top100:
                top100ButtonAction()
            case .top250:
                top250ButtonAction()
            case .topAwait:
                topWaitButtonAction()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datailVC = DetailViewController()
        
        switch tableModel {
        case .keyword:
            let model = searchFilmArray[indexPath.row]
            datailVC.filmID = model.filmId
        case .topModel:
            let model = topFilmArray[indexPath.row]
            datailVC.filmID = model.filmId
        }
        
        datailVC.modalPresentationStyle = .popover
        present(datailVC, animated: true)
    }
}

//MARK: - ViewController

extension ViewController {
    
    private func setTarget() {
        searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        top100Button.addTarget(self, action: #selector(top100ButtonAction), for: .touchUpInside)
        top250Button.addTarget(self, action: #selector(top250ButtonAction), for: .touchUpInside)
        topWaitButton.addTarget(self, action: #selector(topWaitButtonAction), for: .touchUpInside)
    }
    
    //MARK: - searchButtonAction
    
    @objc private func searchButtonAction() {
        
        guard let text = searchTextField.text else { return }
        
        searchLabel.text = "Поиск по запросу: \(text)"
        guard let decodeText = text.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Ошибка декодирования строки")
            return
        }
        
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=" + "\(decodeText)") else {
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
                    let decodeResponce = try JSONDecoder().decode(SearchFilm.self, from: data)
                    DispatchQueue.main.async {
                        self.searchFilmArray = decodeResponce.films
                        self.pageCount = decodeResponce.pagesCount
                        self.tableModel = .keyword
                        self.buttonModel = .keywordButton
                        self.resultTableView.reloadData()
                    }
                } catch {
                    print("error:", error)
                }
                return
            }
        }.resume()
    }
    
    //MARK: - top100ButtonAction
    
    @objc private func top100ButtonAction() {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=" + "\(currentPage)") else {
            print("Invalid URL")
            return
        }
        
        searchLabel.text = "Топ 100 популярных фильмов"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("bee3bcac-4ea0-4da5-9800-8846c7f3e308", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodeResponce = try JSONDecoder().decode(TopResult.self, from: data)
                    DispatchQueue.main.async {
                        self.topFilmArray += decodeResponce.films
                        self.tableModel = .topModel
                        self.buttonModel = .top100
                        self.pageCount = decodeResponce.pagesCount
                        self.resultTableView.reloadData()
                    }
                } catch {
                    print("error:", error)
                }
                return
            }
        }.resume()
    }
    
    //MARK: - top250ButtonAction
    
    @objc private func top250ButtonAction() {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=" + "\(currentPage)") else {
            print("Invalid URL")
            return
        }
        
        searchLabel.text = "Топ 250 популярных фильмов"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("bee3bcac-4ea0-4da5-9800-8846c7f3e308", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodeResponce = try JSONDecoder().decode(TopResult.self, from: data)
                    DispatchQueue.main.async {
                        self.topFilmArray += decodeResponce.films
                        self.tableModel = .topModel
                        self.buttonModel = .top250
                        self.pageCount = decodeResponce.pagesCount
                        self.resultTableView.reloadData()
                    }
                } catch {
                    print("error:", error)
                }
                return
            }
        }.resume()
    }
    
    //MARK: - topWaitButtonAction
    
    @objc private func topWaitButtonAction() {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_AWAIT_FILMS&page=" + "\(currentPage)") else {
            print("Invalid URL")
            return
        }
        
        searchLabel.text = "Топ самых ожидаемых фильмов"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("bee3bcac-4ea0-4da5-9800-8846c7f3e308", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodeResponce = try JSONDecoder().decode(TopResult.self, from: data)
                    DispatchQueue.main.async {
                        self.topFilmArray += decodeResponce.films
                        self.tableModel = .topModel
                        self.buttonModel = .topAwait
                        self.pageCount = decodeResponce.pagesCount
                        self.resultTableView.reloadData()
                    }
                } catch {
                    print("error:", error)
                }
                return
            }
        }.resume()
    }
}
