import UIKit
import FirebaseUI

struct cellData {
    let cellId : Int!
    let img : UIImage!
}
public var myUserid = UILabel(frame: CGRect(x: 160, y: 80, width: 200, height: 100))
public var userID = 9999
let userEmail = UILabel(frame: CGRect(x: 160, y: 120, width: 200, height: 100))
let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1000))
let button = UIButton()
var barButton: UIBarButtonItem!
//public var uuid = 0



class PersonalPageVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //user profile pic
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 150, y: 0, width: 100, height: 100))
        imageView.image = #imageLiteral(resourceName: "Night_Tabbar_More_Highlight_28x28_")
        headerView.addSubview(imageView)
        
        //user information
        let userNameLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 80, width: 100, height: 100))
        userNameLabel.text = "User ID"
        headerView.addSubview(userNameLabel)
        
        //User Place holder
        
        myUserid.text = "N/A"
        headerView.addSubview(myUserid)
        
        //Contact information
        let contactNameLabel: UILabel = UILabel(frame: CGRect(x: 50, y: 120, width: 100, height: 100))
        contactNameLabel.text = "Email"
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
        button.frame = CGRect(x:50, y:200, width: 250, height: 50)
        button.backgroundColor = custom_color
        button.setTitle("Log In ", for: .normal)
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
