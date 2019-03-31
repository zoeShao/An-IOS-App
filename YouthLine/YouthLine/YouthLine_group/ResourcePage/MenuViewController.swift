//
//  MenuViewController.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case all
    case settlement
    case faith
    case sex
    case forms
    case service
    case education
    case type
}

class MenuViewController: UITableViewController {
    
    var didTapMenuTypte: ((MenuType) -> Void)?
    var allCell: UITableViewCell = UITableViewCell()
    var settlementCell: UITableViewCell = UITableViewCell()
    var faithCell: UITableViewCell = UITableViewCell()
    var sexCell: UITableViewCell = UITableViewCell()
    var formsCell: UITableViewCell = UITableViewCell()
    var serviceCell: UITableViewCell = UITableViewCell()
    var educationCell: UITableViewCell = UITableViewCell()
    var typeCell: UITableViewCell = UITableViewCell()
    var rowsInTableSection = 8
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        self.allCell.textLabel?.text = "all"
        self.allCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.allCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.settlementCell.textLabel?.text = "settlement"
        self.settlementCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.settlementCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.faithCell.textLabel?.text = "faith"
        self.faithCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.faithCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.sexCell.textLabel?.text = "Sex, Sexual Health & More"
        self.sexCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.sexCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.formsCell.textLabel?.text = "Ontario Forms"
        self.formsCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.formsCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.serviceCell.textLabel?.text = "Service Providers"
        self.serviceCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.serviceCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.educationCell.textLabel?.text = "Social Justice Education"
        self.educationCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.educationCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        self.typeCell.textLabel?.text = "Indigenous & Two-Spirit"
        self.typeCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.typeCell.textLabel?.font = UIFont(name:"Avenir Book", size: 18)
        
        //        self.shareCell.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            //            print("Dismissing: \(menuType)")
            self?.didTapMenuTypte?(menuType)
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInTableSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0: return self.allCell
        case 1: return self.settlementCell
        case 2: return self.faithCell
        case 3: return self.sexCell
        case 4: return self.formsCell
        case 5: return self.serviceCell
        case 6: return self.educationCell
        case 7: return self.typeCell
        default: fatalError("Unknown row in section 1")
        }
    }
}
