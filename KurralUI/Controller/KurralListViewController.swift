//
//  KurralListViewController.swift
//  KurralUI
//
//  Created by M_243704 on 2/9/21.
//

import UIKit

class KurralListViewController: UIViewController {
    
    var adikaramKurralList = Array<KurralList>()
    
    
    @IBOutlet weak var KurralListTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KurralListTable.dataSource = self
        
        KurralListTable.register(UINib(nibName: "KurralListTableViewCell", bundle: nil), forCellReuseIdentifier: "KurralListViewCell")

        title = adikaramKurralList[0].adikaram_name
    }
}

//MARK: - UITable View Data Source - Code to set Table Data

extension KurralListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.adikaramKurralList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "KurralListViewCell", for: indexPath) as! KurralListTableViewCell
        
        cell.kurralLine1.text = self.adikaramKurralList[indexPath.row].Line1
        
        cell.kurralLine2.text = self.adikaramKurralList[indexPath.row].Line2
        cell.indexLbl.text = "\(indexPath.row + 1). "
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}



