
import UIKit
import Alamofire

class ViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //removed for brevity
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.dishes.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cello") as VoteCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        let g:VoteRecognizer=VoteRecognizer(target: cell, action: nil
            ,voteUpBlock: { () -> Void in
                //make ui changes, send vote UP to server etc...
                println("vote up!")
            },voteDownBlock: { () -> Void in
                //make ui changes, send vote DOWN to server etc...
                println("vote down!")
        })
        cell.addGestureRecognizer(g)
        
        cell.voteTextLabel.text = self.menu.dishes[indexPath.row]
        
        return cell
    }
    
    
}

