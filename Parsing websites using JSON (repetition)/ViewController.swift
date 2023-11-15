import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var bitPrice: BitcoinPrice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeRequest()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func makeRequest() {
        var request = URLRequest(url: URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let bitcoinPrice = try decoder.decode(BitcoinPrice.self, from: data)
                
                self.bitPrice = bitcoinPrice
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        
        switch indexPath.row {
        case 0 :
            if let usdRate = bitPrice?.bpi.USD.rate {
                cell.textLabel?.text = "Bitcoin Rate in USD: \(usdRate)"
            }
        case 1:
            if let eurRate = bitPrice?.bpi.EUR.rate {
                cell.textLabel?.text = "Bitcoin Rate in EUR: \(eurRate)"
            }
        case 2:
            if let gbpRate = bitPrice?.bpi.GBP.rate {
                cell.textLabel?.text = "Bitcoin Rate in GBP: \(gbpRate)"
            }
        default:
            cell.textLabel?.text = "No data availeble"
            
        }
        
        
        
        return cell
    }
}

class TableViewCell: UITableViewCell {
    
}

