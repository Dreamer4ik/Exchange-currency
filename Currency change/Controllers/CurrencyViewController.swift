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
    var timer:Timer?
    private var totalSeconds = 0
    
    lazy var buttonResetTime:UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBlue
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        view.setAttributedTitle(NSAttributedString(string: "Update", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        view.setAttributedTitle(NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]), for: .highlighted)
        view.clipsToBounds = true
        view.layer.cornerRadius = 50
        view.addTarget(self, action: #selector(buttonResetAction), for: .touchUpInside)
        
        return view
    }()
    
    
    lazy var labelTimer:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    
    @IBOutlet weak var tableView1: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Currency"
        

        configureActivityIndicator()
        configureTableView()
        addSubViews()
        activateConstrains()
        
        fetchExchangeRates(.cash)

    }
    //уточнить за reloadData() , идет обновление курса ??? 
    @objc func buttonResetAction(sender: UIButton!) {
        totalSeconds = 0 
        tableView1.reloadData()
    }
    
    func addSubViews() {
        view.addSubview(buttonResetTime)
        view.addSubview(labelTimer)


    }
    
    func activateConstrains() {
        NSLayoutConstraint.activate([
            labelTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            labelTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            buttonResetTime.topAnchor.constraint(equalTo: labelTimer.bottomAnchor, constant: 5),
            buttonResetTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            buttonResetTime.widthAnchor.constraint(equalToConstant: 100),
            buttonResetTime.heightAnchor.constraint(equalToConstant: 100)
        
        ])
        
        
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
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
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
    @objc func updateTime()  {
        totalSeconds += 1
        print(formatResult(totalSeconds))
        labelTimer.text = "Time without update: \(formatResult(totalSeconds))"
    }
    
    //MARK: - Private
        private func formatResult(_ int: Int) -> String {
            let seconds = int % 60
            let minutes = (int / 60) % 60
            //     let hours = totalSeconds / 3600
            return String.init(format: "%02d:%02d", minutes, seconds)
        }

}
