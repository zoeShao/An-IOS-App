import UIKit
import FirebaseUI

struct cellData {
    let cellId : Int!
    let img : UIImage!
}
public var myUserid = UILabel(frame: CGRect(x: 210, y: 110, width: 200, height: 100))
public var userID = 9999
let userEmail = UILabel(frame: CGRect(x: 210, y: 150, width: 200, height: 100))
let headerView: UIView = UIView(frame: CGRect(x: 0, y: 30, width: ScreenWidth, height: 1000))
let button = UIButton()
var barButton: UIBarButtonItem!
//public var uuid = 0



class PersonalPageVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        let backgroupd: UIImageView = UIImageView(frame: CGRect(x: 150, y: 30, width: 100, height: 100))
//        backgroupd.image = #imageLiteral(resourceName: "rainbow_3")
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "rainbow_3.jpg")!)
    
        
        
        //user profile pic
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 150, y: 30, width: 100, height: 100))
        imageView.image = #imageLiteral(resourceName: "person_color")
        imageView.contentMode = .scaleAspectFit
        headerView.addSubview(imageView)
        
        //user information
        let userNameLabel: UILabel = UILabel(frame: CGRect(x: 100, y: 110, width: 100, height: 100))
        userNameLabel.text = "User ID"
        userNameLabel.font = UIFont(name: "Copperplate-Bold", size: 23)
        userNameLabel.isHighlighted = true
        headerView.addSubview(userNameLabel)
        
        //User Place holder
        
        myUserid.text = "N/A"
        headerView.addSubview(myUserid)
        
        //Contact information
        let contactNameLabel: UILabel = UILabel(frame: CGRect(x: 100, y: 150, width: 100, height: 100))
        contactNameLabel.text = "Email"
        contactNameLabel.font = UIFont(name: "Copperplate-Bold", size: 23)
        contactNameLabel.isHighlighted = true
        headerView.addSubview(contactNameLabel)
        
        //Contact Place holder
        userEmail.text = "N/A"
        headerView.addSubview(userEmail)
        
        self.tableView.tableHeaderView = headerView
        
        //add navigation button
        barButton = UIBarButtonItem(title: "Sign Out",
                                         style: .plain,
                                         target: self,
                                         action: #selector(openNextView))
       
        self.navigationItem.rightBarButtonItem = nil
        

        var custom_color =  UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 0.5)
        // Making resource button
        button.frame = CGRect(x:80, y:230, width: 250, height: 50)
    
        button.backgroundColor = custom_color
        button.setTitle("Log In ", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        headerView.addSubview(button)
    }
    
    //button action for setting
    @objc func openNextView(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            userEmail.text = "N/A"
            myUserid.text = "N/A"
            button.isHidden = false
            userID = 9999
            self.navigationItem.rightBarButtonItem = nil
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
  
    }
    
    //button action for resoucres
    @objc func buttonAction(sender: UIButton!) {
        let authUI = FUIAuth.defaultAuthUI()
        
        // Check that it isn't nil
        guard authUI != nil else {
            return
        }
        
        // Set delegate and specify sign in options
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        // Get the auth view controller and present it
        let authViewController = authUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
        
    }
    
}

extension PersonalPageVC: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check for error
        guard error == nil else {
            return
        }
        //after log in, do following..
        let MyEmail = Auth.auth().currentUser?.email
        let MyID = Auth.auth().currentUser?.uid
        userEmail.text = MyEmail
        myUserid.text = MyID
        button.isHidden = true
        //show side bar
        self.navigationItem.rightBarButtonItem = barButton
        submitAction(uuid: MyID!)
}

func submitAction(uuid: String) {
    
    
//    print("My uuid is")
//    print(uuid)
    let parameters = ["uuid": uuid]
    let url = URL(string: "http://youthline-test-server.herokuapp.com/users")!
    let session = URLSession.shared
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard error == nil else {
            return
        }
        
        guard let data = data else {
            return
        }
        
        do {
            //create json object from data
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                print(json, "response received")
                // handle json...
                userID = json["uid"]! as! Int
//                print("my userID is")
//                print(userID)
//                print("-------------")
            }
        } catch let error {
            print(error.localizedDescription)
        }
    })
    task.resume()
    }
}
