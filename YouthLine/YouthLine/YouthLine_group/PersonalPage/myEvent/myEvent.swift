

import UIKit


struct Myevent {
    var eventName : String
    var date : String
}

class MyEventVC: UITableViewController {
    
    let cellId = "cellId"
    var events : [Myevent] = [Myevent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createProductArray()
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
        let currentLastItem = events[indexPath.row]
        cell.textLabel?.text = currentLastItem.eventName
        cell.detailTextLabel?.text = currentLastItem.date
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func createProductArray() {
        events.append(Myevent(eventName: "Event1",date:"2018-01-22" ))
        events.append(Myevent(eventName: "Event2",date:"2018-01-22" ))
        events.append(Myevent(eventName: "Event3",date:"2018-01-22" ))
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
        // do something when button was hitted!
    }
    
}
