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
//    func noHandler(alert: UIAlertAction!) {
//        dismiss(animated: true, completion: nil)
//    }
    
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
//            let alert = UIAlertController(title: "Message sent successfully!", message: "Do you want to send more?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
////            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: noHandler))
//            self.present(alert, animated: true)
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
    @objc func openInstagram(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "instagram://user?username=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.instagram.com/lgbtyouthline/")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openTwitter(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "twitter://user?screen_name=LGBTYouthLine")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://twitter.com/LGBTYouthLine")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openFacebook(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "fb://profile")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.facebook.com/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openYoutube(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "youtube://www.youtube.com/user/lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "https://www.youtube.com/user/lgbtyouthline")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
    @objc func openTumblr(sender: UIButton) {
        let instURL: NSURL = NSURL (string: "tumblr://x-callback-url/blog?blogName=lgbtyouthline")! // Replace = Instagram by the your instagram user name
        let instWB: NSURL = NSURL (string: "http://lgbtyouthline.tumblr.com")! // Replace the link by your instagram weblink
        
        if (UIApplication.shared.canOpenURL(instURL as URL)) {
            // Open Instagram application
            UIApplication.shared.open(instURL as URL)
        } else {
            // Open in Safari
            UIApplication.shared.open(instWB as URL)
        }
    }
    
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
        currentNewsIndex = currentNewsIndex + 2
        if currentNewsIndex == AllNewsFeedModelList!.count {
            currentNewsIndex = 0
        }
        print(currentNewsIndex)
        CurrentNewsFeedModelList?.removeAll()
        CurrentNewsFeedModelList?.append(AllNewsFeedModelList![currentNewsIndex])
        CurrentNewsFeedModelList?.append(AllNewsFeedModelList![currentNewsIndex+1])
        self.tableView.reloadData()
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
        if model?.image != nil {
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

// extension for data fetching
extension HomeListVC {
    //    func updateData(){
    ////        if let news1 = test() {
    ////            //            CurrentNewsFeedModelList?.append(news1)
    ////            AllNewsFeedModelList?.append(news1)
    ////            AllNewsFeedModelList?.append(news1)
    ////        } else {
    ////            CurrentNewsFeedModelList = []
    ////            AllNewsFeedModelList = []
    ////        }
    ////        if let news2 = test1() {
    ////            //            CurrentNewsFeedModelList?.append(news2)
    ////            AllNewsFeedModelList?.append(news2)
    ////            AllNewsFeedModelList?.append(news2)
    ////        } else {
    ////            CurrentNewsFeedModelList = []
    ////            AllNewsFeedModelList = []
    ////        }
    //        let resJson = fetchData()
    //        print(resJson)
    //        if let mappedObject = JSONDeserializer<NewsFeedModel>.deserializeModelArrayFrom(json: resJson.description){
    //            print("heyy")
    //            for model in mappedObject as! [NewsFeedModel] {
    //                // if model.common_card != nil || model.fields != nil
    //                AllNewsFeedModelList!.append(model)
    //                print("neic")
    //            }
    //            print(AllNewsFeedModelList!.count)
    //            if AllNewsFeedModelList!.count >= 2 {
    //
    //                CurrentNewsFeedModelList?.append(AllNewsFeedModelList![0])
    //                CurrentNewsFeedModelList?.append(AllNewsFeedModelList![1])
    //                print("buling")
    //            } else if AllNewsFeedModelList!.count == 1{
    //                CurrentNewsFeedModelList?.append(AllNewsFeedModelList![0])
    //            }
    //        }
    //        print(AllNewsFeedModelList!.count)
    //
    //    }
    
    //    func fetchData() -> JSON?{
    //        var json = JSON()
    //        Alamofire.request("http://youthline-test-server.herokuapp.com/home").responseJSON { (responseObject) -> Void in
    //
    ////            print(responseObject)
    //            if responseObject.result.isSuccess {
    //                json = JSON(responseObject.result.value!)
    //                print("fetchsuccess")
    //
    //            }
    //            if responseObject.result.isFailure {
    //                let error : NSError = responseObject.result.error! as NSError
    //                print("news fetch failed")
    //            }
    //        }
    //        print("pass")
    //        return json
    //    }
}


//extension HomeListVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        if scrollView == self.scrollView {
//            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
//        }
//
//        if scrollView == self.tableView {
//            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
//        }
//    }
//
//    func beginBatchFetch() {
//        fetchingMore = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
//            let newItems = self.NewsFeedModelList!
//            self.NewsFeedModelList?.append(contentsOf: newItems)
//            self.fetchingMore = false
//            self.tableView.reloadData()
//        })
//    }
//}
//                let jsonArray = resJson.array!

