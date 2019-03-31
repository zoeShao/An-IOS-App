import UIKit

struct cellData {
    let cellId : Int!
    let img : UIImage!
}

class PersonalPageVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1000))
        
        //user profile pic
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 150, y: 0, width: 100, height: 100))
        imageView.image = #imageLiteral(resourceName: "Night_Tabbar_More_Highlight_28x28_")
        headerView.addSubview(imageView)
        
        //user information
        let userNameLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 80, width: 100, height: 100))
        userNameLabel.text = "User Name"
        headerView.addSubview(userNameLabel)
        
        //User Place holder
        let userNameTextField = UITextField(frame: CGRect(x: 160, y: 80, width: 100, height: 100))
        userNameTextField.placeholder = NSLocalizedString("User Name", comment: "")
        userNameTextField.autocorrectionType = .yes
        userNameTextField.returnKeyType = .done
        userNameTextField.clearButtonMode = .never
        headerView.addSubview(userNameTextField)
        
        //Contact information
        let contactNameLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 120, width: 100, height: 100))
        contactNameLabel.text = "Contact"
        headerView.addSubview(contactNameLabel)
        
        //Contact Place holder
        let contactTextField = UITextField(frame: CGRect(x: 160, y: 120, width: 100, height: 100))
        contactTextField.placeholder = NSLocalizedString("Contact Info", comment: "")
        contactTextField.autocorrectionType = .yes
        contactTextField.returnKeyType = .done
        contactTextField.clearButtonMode = .never
        headerView.addSubview(contactTextField)
        
        self.tableView.tableHeaderView = headerView
        
        //add navigation button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Setting",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(openNextView))
        

        var custom_color =  UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 0.5)
        // Making resource button
        let button = UIButton()
        button.frame = CGRect(x:50, y:200, width: 250, height: 50)
        button.backgroundColor = custom_color
        button.setTitle("My Event ", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        headerView.addSubview(button)
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


// data for cell data

//        var arraryOfCelldata = [cellData]()
//        arraryOfCelldata = [cellData(cellId: 1, img: #imageLiteral(resourceName: "AppIcon_76x76_")),
//                            cellData(cellId: 1, img: #imageLiteral(resourceName: "AppIcon_76x76_"))]
//

//controll cell1 and cell2
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return arraryOfCelldata.count
//        }

//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let cell = Bundle.main.loadNibNamed("Cell1", owner: self, options: nil)?.first as! Cell1
//            cell.img1.image = arraryOfCelldata[indexPath.row].img
//            cell.img2.image = arraryOfCelldata[indexPath.row].img
//            cell.img2.image = arraryOfCelldata[indexPath.row].img
//            return cell
//
//        }
