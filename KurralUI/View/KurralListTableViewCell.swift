//
//  KurralListTableViewCell.swift
//  KurralUI
//
//  Created by M_243704 on 2/9/21.
//

import UIKit

class KurralListTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var kurralLine1: UILabel!
    @IBOutlet weak var kurralLine2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
