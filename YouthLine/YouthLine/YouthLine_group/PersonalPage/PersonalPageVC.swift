import UIKit

//struct MainCell {
//    var eventName : String
//}

class PersonalPageVC: UITableViewController {
    
    
    let cellId = "cellId"
//    var events : [MainCell] = [MainCell]()
    let events = ["Events","Resources"]
    
//    func createProductArray() {
//        events.append(MainCell(eventName: "Event"))
//        events.append(MainCell(eventName: "Resources"))
//
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Setting",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openNextView))
//        createProductArray()
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: cellId)
        
    
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let currentLastItem = events[indexPath.row]
        cell.textLabel?.text = currentLastItem
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = events[indexPath[1]]
        if model == "Events"{
            let vc = MyEventVC()
            //        vc.questionTitle = model?.news?.news_content?.title?.panel_text ?? ""
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)

        } else {
            let vc = MyResourceVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    //Make it subtitle style
    class SubtitleTableViewCell: UITableViewCell {
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    

    
    //button action for setting
    @objc func openNextView(){
        let subvc = ViewController()
        self.definesPresentationContext = true
        self.navigationController?.pushViewController(subvc, animated: true)
    }
    

    
    //button action for resoucres
    @objc func buttonAction(sender: UIButton!) {
        let subvc = MyEventVC()
        self.definesPresentationContext = true
        self.navigationController?.pushViewController(subvc, animated: true)
    }
    
    

    
    
}

