import UIKit
import FirebaseUI
import TransitionButton
import Alamofire
import HandyJSON
import SwiftyJSON


struct cellData {
    let cellId : Int!
    let img : UIImage!
}

public var userID = 999999
public var userIDString: String = ""
public var userName: String = ""

//let userEmail = UILabel(frame: CGRect(x: 150, y: ScreenWidth/2 + 100, width: 200, height: 100))
//let myUserName = UILabel(frame: CGRect(x: 150, y: ScreenWidth/2 + 50, width: 200, height: 100))
//let imageView: UIImageView = UIImageView(frame: CGRect(x: ScreenWidth/2 -  50, y: ScreenWidth/2 -  50, width: 100, height: 100))
let contactNameLabel: UILabel = UILabel(frame: CGRect(x: 100, y: ScreenWidth/2 + 100, width: 100, height: 100))
let userNameLabel: UILabel = UILabel(frame: CGRect(x: 50, y: ScreenWidth/2 + 50, width: 300, height: 100))
let userNameLabel_1: UILabel = UILabel(frame: CGRect(x: 50, y: ScreenWidth/2 + 80, width: 300, height: 100))
//let headerView: UIView = UIView(frame: CGRect(x: 0, y: 30, width: ScreenWidth, height: 1000))
let button = TransitionButton(frame: CGRect(x:55, y:ScreenHeight/2 - 30, width: 250, height: 50))
let signupbutton = TransitionButton(frame: CGRect(x:55, y:ScreenHeight/2  - 30, width: 250, height: 50))
var barButton: UIBarButtonItem!
var event_count = 0
var monthDict:[String:String] = ["Jan":"01", "Feb":"02", "Mar":"03", "Apr": "04", "May": "05", "Jun": "06", "Jul": "07", "Aug": "08", "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12", "Jin": "13"]

var greeting_count = 0
var greeting_max = 6
var greetingDict:[String] = ["How is your day ？ ", "Everyone needs a break, ", "No pain, no gain, ", "Don't let others define you, ", "Good to see you, ", "Life is not all roses, ", "Time tries truth, "]

//public var uuid = 0

class PersonalPageVC: UIViewController {
    
    
    //    var loginImageView : UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.layer.masksToBounds = true
    //        imageView.layer.cornerRadius = 5
    //        imageView.frame = CGRect(x: ScreenWidth/2 - 200, y: StatusBarHeight, width: 400, height: 400)
    //        print(imageView.frame.width, "check")
    //        imageView.contentMode = .scaleAspectFit
    //        return imageView
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up background image
        view.backgroundColor = UIColor(patternImage: UIImage(named: "family_bkg")!)
        
        
        //set up animation button
        self.view.addSubview(button)
        
        //set up login icon image
        //        let url = URL(string: "http://aswedesign.com/wp-content/uploads/2018/07/a-982x982.png")
        //        let data = try? Data(contentsOf: url!)
        //        if let imageData = data {
        //            let image = UIImage(data: imageData)
        //            loginImageView.image = image
        //        }
        //view.addSubview(loginImageView)
        
        //set up user information display
        userNameLabel.text = "Sign in to save your favourite events !"
        userNameLabel.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        userNameLabel.isHighlighted = true
        view.addSubview(userNameLabel)
        
        userNameLabel_1.text = ""
        userNameLabel_1.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        userNameLabel_1.isHighlighted = true
        view.addSubview(userNameLabel)
        
        //User Place holder
        
        //        myUserName.text = "N/A"
        //        view.addSubview(myUserName)
        
        //Contact information
        contactNameLabel.text = "Email"
        contactNameLabel.font = UIFont(name: "VAGRoundedStd-thin", size: 18)
        contactNameLabel.isHighlighted = true
        //        view.addSubview(contactNameLabel)
        
        //Contact Place holder
        //        userEmail.text = "N/A"
        
        
        
        
        // Making resource button
        button.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1)
        button.setTitle("Log in / Sign up →", for: .normal)
        button.cornerRadius = 20
        button.spinnerColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
        
        signupbutton.backgroundColor = UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1)
        signupbutton.setTitle("Sign out", for: .normal)
        signupbutton.cornerRadius = 20
        signupbutton.spinnerColor = .white
        signupbutton.addTarget(self, action: #selector(openNextView_1), for: .touchUpInside)
        
        
    }
    
    @objc func openNextView_1(sender: UIButton) {
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            //sleep(0) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .shake, completion: {
                    
                })
                self.openNextView()
                
            })
        })
        userNameLabel.text = "Sign in to save your favourite events !"
        userNameLabel_1.text = ""
    }
    
    //button action for setting
    @objc func openNextView(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //            userEmail.text = "N/A"
            //            myUserName.text = "N/A"
            button.isHidden = false
            userID = 99999
            self.navigationItem.rightBarButtonItem = nil
            signupbutton.removeFromSuperview()
            //            myUserName.removeFromSuperview()
            //            userEmail.removeFromSuperview()
            contactNameLabel.removeFromSuperview()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    //button action for resoucres
    @objc func buttonAction(sender: UIButton!) {
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(2) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .expand, completion: {
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
                    self.present(authViewController, animated: true, completion: nil)
                })
            })
        })
        
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
        let MyName = Auth.auth().currentUser?.displayName
        //        userEmail.text = MyEmail
        //        myUserName.text = MyName
        button.isHidden = true
        view.addSubview(userNameLabel)
        
        userNameLabel.text = greetingDict[greeting_count] + (MyName ?? "My guest")
        greeting_count += 1
        if (greeting_count > greeting_max) {greeting_count = 1}
        //        userNameLabel_1.text = String(event_count) + " events you liked are going on today."
        //        view.addSubview(myUserName)
        //        view.addSubview(contactNameLabel)
        //        view.addSubview(userEmail)
        print(userID)
        //show side bar
        //        self.navigationItem.rightBarButtonItem = barButton
        self.view.addSubview(signupbutton)
        submitAction(uuid: MyID!)
        view.addSubview(userNameLabel_1)
        generate_sentence()
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
                    userIDString = String(userID)
                    print(userIDString)
                    refresh_matched_events(id: userIDString)
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

func refresh_matched_events(id: String) {
    event_count = 0
    print(id, "this is it")
    Alamofire.request("http://youthline-test-server.herokuapp.com/event_w_fav/" + String(id)).responseJSON { (responseObject) -> Void in
        
        let json = JSON(responseObject.result.value!)
        
        if let mappedObject_new = JSONDeserializer<EventModel>.deserializeModelArrayFrom(json: json.description){
            for model in mappedObject_new as! [EventModel] {
                //                    if model.common_card != nil || model.fields != nil
                if model.fav == "True" {
                    let event_month = monthDict[String(model.event_date?.dropFirst(4).prefix(3) ?? "Jin")]
                    let event_date = String(model.event_date?.dropFirst(8).prefix(2) ?? "00")
                    let event_year = String(model.event_date?.dropFirst(12).prefix(4) ?? "9999")
                    let compare_month = (event_month ?? "-1")
                    let compare_date_and_year = "-" + event_date + "-" + event_year
                    let final_date = compare_month + compare_date_and_year
                    print(compare_month + compare_date_and_year, "lolol")
                    
                    let date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy"
                    let dateString = "03-16-2019"//dateFormatter.string(from: date)
                    if dateString == final_date{
                        event_count += 1
                    }
                    generate_sentence()
                    
                }
            }
        }
    }
}

func generate_sentence(){
    if event_count < 2 {
        userNameLabel_1.text = String(event_count) + " event you liked is going on today."
    } else {
        userNameLabel_1.text = String(event_count) + " events you liked are going on today."
    }
}

