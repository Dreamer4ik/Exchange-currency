//
//  CurrencyViewController.swift
//  Currency change
//
//  Created by Ivan Potapenko on 16.07.2021.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var activityIndicator: UIActivityIndicatorView!
    var currencies:[Currency] = []
    
    
    @IBOutlet weak var tableView1: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Currency"
        

        configureActivityIndicator()
        configureTableView()
        
        fetchExchangeRates(.cash)

    }
    
    //MARK: DataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView1.dequeueReusableCell(withIdentifier: "id1", for: indexPath) as? CurrencyTableViewCell else {return UITableViewCell()}
        
        cell.configureCellWidth(currency: self.currencies[indexPath.row])

        
        return cell
    }
    
   //MARK: - Helper Functions ???
    func fetchExchangeRates(_ rate:Rate ) {
        self.activityIndicator.startAnimating()
        PrivatBankAPI.shared.fetchExchangeRatesJSONWith(rate) { (result) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
                switch result {
                case .success(let currencies):
                    self.currencies = currencies
                    DispatchQueue.main.async {
                        self.tableView1.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            
            
        }
    }
    
    //MARK: - Private Functions
    private func configureTableView() {
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
        self.tableView1.tableFooterView = UIView()
    }
    
    private func configureActivityIndicator(){
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
    }
    
    //MARK: - Actions
    
    @IBAction func segmenetControllPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.fetchExchangeRates(.cash)
        case 1:
            self.fetchExchangeRates(.cashless)
        default:
            break
        }
    }
    
    

}
