import UIKit

struct Setting {
    var SettingName : String
}

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    var settings : [Setting] = [Setting]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSettingArray()
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: cellId)

        
    }
    
    //Call back to previsou
    @objc func openNextView(){
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let currentLastItem = settings[indexPath.row]
        cell.textLabel?.text = currentLastItem.SettingName
        
        //adding switch on
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func createSettingArray() {
        settings.append(Setting(SettingName: "Cellular Data"))
        settings.append(Setting(SettingName: "Notification"))
        settings.append(Setting(SettingName: "Bluetooth"))
    }

    //Make it subtitle style
    class SubtitleTableViewCell: UITableViewCell {
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        // do something when this button was hit!
    }
    
}

