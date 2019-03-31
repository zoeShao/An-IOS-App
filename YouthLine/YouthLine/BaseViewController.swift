import UIKit

class BaseViewController: UIViewController {
    
    var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "BackBtn")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white //custom_menuBarPink//RGBColor(49, 242, 75)//custom_menuBarPink
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .gray
        
        backBtn.addTarget(self, action: #selector(backAction(button:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = item1
        
        
    }
    
    @objc func backAction(button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

