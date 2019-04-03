//
//  HomeListVCExtension.swift
//  YouthLine
//
//  Created by 林诗琪 on 2019-03-31.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import Foundation
import MessageUI
import Alamofire
import HandyJSON
import SwiftyJSON
// extension for message sender
extension HomeListVC:  MFMessageComposeViewControllerDelegate {

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self

        // Configure the fields of the interface.
        //        composeVC.recipients = ["6476944275"]
        composeVC.recipients = ["6478223876"]
        composeVC.body = "Enter texting messages here:"

        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
//            let homeViewVC = self
            self.present(composeVC, animated: true, completion: nil)
//            self.present(homeViewVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
}

// extension for button action
extension HomeListVC {
    
    @objc func makePhoneCall(sender: UIButton) {
        //18002689688
        guard let number = URL(string: "tel://" + "+18002689688") else { return }
        if (UIApplication.shared.canOpenURL(number)) {
            // Open Instagram application
            UIApplication.shared.open(number)
        } else {
            print("phone call not available")
        }
    }

    @objc func sendMessage(sender: UIButton) {
        displayMessageInterface()
    }
    
    @objc func nextNews(sender: UIButton) {
        print("update news")
        if currentNewsIndex % 2 == 0 {
            currentNewsIndex = currentNewsIndex + 2
        } else {
            currentNewsIndex = currentNewsIndex + 1
        }
        
        if currentNewsIndex == AllNewsFeedModelList!.count {
            currentNewsIndex = 0
            fetchData()
        } else {
            CurrentNewsFeedModelList?.removeAll()
            CurrentNewsFeedModelList?.append(AllNewsFeedModelList![currentNewsIndex])
            if currentNewsIndex+1 < AllNewsFeedModelList!.count {
                CurrentNewsFeedModelList?.append(AllNewsFeedModelList![currentNewsIndex+1])
            }
            self.homePageUIView.tableUIView.tableView.reloadData()
        }
    }
}

// extension for table view
extension HomeListVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CurrentNewsFeedModelList?.count ?? 0
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = CurrentNewsFeedModelList?[indexPath.section]
        let cell: NewsFeedBaseTableViewCell
        if model?.image != "" {
            cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedImageTableViewCellID, for: indexPath) as! NewsFeedImageTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedBaseTableViewCellID, for: indexPath) as! NewsFeedBaseTableViewCell
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = CurrentNewsFeedModelList?[indexPath.section]
        let vc = HomeDetailVC()
        vc.questionTitle = model?.title ?? ""
        vc.questionTime = model?.time ?? ""
        vc.questionImage = model?.image ?? ""
        vc.questionContent = model?.news_content ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// extension for collection view
extension HomeListVC {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return YouthlineIntroModelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = YouthlineIntroModelList?[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeEventCollectionViewCell", for: indexPath) as! HomeEventCollectionViewCell
        cell.model = model
        return cell
    }
}
