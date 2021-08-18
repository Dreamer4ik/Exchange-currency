//
//  CCYViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 15.08.2021.
//

import UIKit

class CCYViewController: UIViewController {
    
    var currencyCODE = ["$", "₽", "€", "₿"]
    var currencyAR = ["USD", "RUB","EUR", "BTC"]
    
    
    lazy var tableView1:UITableView = {
        let view = UITableView()
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        tableView1.dataSource = self
        tableView1.delegate = self
        addSubView()
        activateConstrains()
        
    }
    
    func addSubView() {
        view.addSubview(tableView1)
    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([
            tableView1.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tableView1.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            tableView1.topAnchor.constraint(
                equalTo: view.topAnchor),
            tableView1.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),

        ])
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView1.frame = view.bounds
    }
    
    
    
    
}

extension CCYViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyAR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView1.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(textCode:"\(currencyCODE[indexPath.row])", textName: "- \(currencyAR[indexPath.row])")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}






