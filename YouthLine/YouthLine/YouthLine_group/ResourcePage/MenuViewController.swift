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
//    case favourite
    case settlement
    case faith
    case sex
    case forms
    case service
    case education
    case type
    case health
    case parents
    case gender
    case selfcare
    case homelessness
    case trans
    case school
    case comingout
    case emergency
    case community
    case selfharm
    case bullying
}

class MenuViewController: UITableViewController {
    
    var didTapMenuTypte: ((MenuType) -> Void)?
    var allCell: UITableViewCell = UITableViewCell()
//    var favouriteCell: UITableViewCell = UITableViewCell()
    var settlementCell: UITableViewCell = UITableViewCell()
    var faithCell: UITableViewCell = UITableViewCell()
    var sexCell: UITableViewCell = UITableViewCell()
    var formsCell: UITableViewCell = UITableViewCell()
    var serviceCell: UITableViewCell = UITableViewCell()
    var educationCell: UITableViewCell = UITableViewCell()
    var typeCell: UITableViewCell = UITableViewCell()
    var healthCell: UITableViewCell = UITableViewCell()
    var parentsCell: UITableViewCell = UITableViewCell()
    var genderCell: UITableViewCell = UITableViewCell()
    var selfcareCell: UITableViewCell = UITableViewCell()
    var homelessnessCell: UITableViewCell = UITableViewCell()
    var transCell: UITableViewCell = UITableViewCell()
    var schoolCell: UITableViewCell = UITableViewCell()
    var comingoutCell: UITableViewCell = UITableViewCell()
    var emergencyCell: UITableViewCell = UITableViewCell()
    var communityCell: UITableViewCell = UITableViewCell()
    var selfharmCell: UITableViewCell = UITableViewCell()
    var bullyingCell: UITableViewCell = UITableViewCell()
    var rowsInTableSection = 20
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        //all
        self.allCell.textLabel?.text = "All"
        self.allCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.allCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //favourite
//        self.favouriteCell.textLabel?.text = "My Favourite"
//        self.favouriteCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
//        self.favouriteCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //settlement
        self.settlementCell.textLabel?.text = "Settlement"
        self.settlementCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.settlementCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //faith
        self.faithCell.textLabel?.text = "Faith"
        self.faithCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.faithCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //sex
        self.sexCell.textLabel?.text = "Sex, Sexual Health & More"
        self.sexCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.sexCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //forms
        self.formsCell.textLabel?.text = "Ontario Forms"
        self.formsCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.formsCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //service
        self.serviceCell.textLabel?.text = "Service Providers"
        self.serviceCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.serviceCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //education
        self.educationCell.textLabel?.text = "Social Justice Education"
        self.educationCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.educationCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //type
        self.typeCell.textLabel?.text = "Indigenous & Two-Spirit"
        self.typeCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.typeCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //health
        self.healthCell.textLabel?.text = "Health & Mental Health"
        self.healthCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.healthCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //parents
        self.parentsCell.textLabel?.text = "Parents"
        self.parentsCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.parentsCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //gender
        self.genderCell.textLabel?.text = "Gender"
        self.genderCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.genderCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //self-care
        self.selfcareCell.textLabel?.text = "Self-Care"
        self.selfcareCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.selfcareCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //homelessness
        self.homelessnessCell.textLabel?.text = "Homelessness"
        self.homelessnessCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.homelessnessCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //trans
        self.transCell.textLabel?.text = "Trans Resources"
        self.transCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.transCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //school
        self.schoolCell.textLabel?.text = "School"
        self.schoolCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.schoolCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //coming out
        self.comingoutCell.textLabel?.text = "Coming Out"
        self.comingoutCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.comingoutCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //emergency
        self.emergencyCell.textLabel?.text = "Emergency/Crisis Services"
        self.emergencyCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.emergencyCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //community
        self.communityCell.textLabel?.text = "Community and Organizing"
        self.communityCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.communityCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //self-harm
        self.selfharmCell.textLabel?.text = "Self-Harm"
        self.selfharmCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.selfharmCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        //bullying
        self.bullyingCell.textLabel?.text = "Bullying, Abuse & Violence"
        self.bullyingCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.bullyingCell.textLabel?.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
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
//        case 1: return self.favouriteCell
        case 1: return self.settlementCell
        case 2: return self.faithCell
        case 3: return self.sexCell
        case 4: return self.formsCell
        case 5: return self.serviceCell
        case 6: return self.educationCell
        case 7: return self.typeCell
        case 8: return self.healthCell
        case 9: return self.parentsCell
        case 10: return self.genderCell
        case 11: return self.selfcareCell
        case 12: return self.homelessnessCell
        case 13: return self.transCell
        case 14: return self.schoolCell
        case 15: return self.comingoutCell
        case 16: return self.emergencyCell
        case 17: return self.communityCell
        case 18: return self.selfharmCell
        case 19: return self.bullyingCell
        default: fatalError("Unknown row in section 1")
        }
    }
}
