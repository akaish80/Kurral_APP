//
//  KurralListViewController.swift
//  KurralUI
//
//  Created by M_243704 on 1/26/21.
//

import UIKit

class KurralAdikaramViewController: UIViewController {
    
    var adikaramKurralList = Array<KurralList>()
    
    var adikaramList = Array<String>()
    var adikaramObj = Array<Adikaram>()
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: AdikaramManagerDelegate?
    var datasourceDele: DatasourceDelegate?
    
    var networkManger = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        networkManger.delegate = self
        networkManger.dataSource = self

        networkManger.fetchAdikaram()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "KurralTableList" {
    
            let destinationVC = segue.destination as! KurralListViewController
            destinationVC.adikaramKurralList = self.adikaramKurralList
        }
    }
}

//MARK: - AdikaramManagerDelegate

extension KurralAdikaramViewController: AdikaramManagerDelegate {
    func didUpdateKurralList(kurralList: Array<KurralList>) {
        print("O My God")
        self.adikaramKurralList = kurralList
    }
    
    func didFailKurralWithError(error: Error) {
        print(error)
    }
    
    
    
    func didUpdate(adikaram: Array<Adikaram>) {
        adikaramObj = adikaram
//        adikaramList = adikaram
        for adi in adikaram  {
            adikaramList.append(adi.adikaram)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension KurralAdikaramViewController: DatasourceDelegate{
    func didSelectGoToMainMenu() {
        print("Arun")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "KurralTableList", sender: self)
            
        }
    }
    
    
}


//MARK: - UITableViewDataSource

extension KurralAdikaramViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = adikaramList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        
        cell.adikaramLabel.text = message
        cell.adikaramId.text = String(indexPath.row + 1)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adikaramList.count
    }
    
    
}

//MARK: - UITableViewDelegate

extension KurralAdikaramViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        print(adikaramObj[indexPath.row].adikaram)
        
        
        networkManger.fetchKurraList(beginIndex: adikaramObj[indexPath.row].beginIndex, endIndex: adikaramObj[indexPath.row].endIndex)
    }
}




//extension KurralAdikaramViewController: KurralListDelegate {
//    func didFailKurralWithError(error: Error) {
//        print(error)
//    }
//
//    func didUpdateKurralList(kurralList: Array<KurralList>) {
//        print("I Love You")
//        adikaramKurralList = kurralList
//    }
//
//
//}
