
import Foundation
import UIKit

class VoteRecognizer:UIGestureRecognizer{
    
    var voteCell:VoteCell?
    
    var voteUpBlock:()->Void
    var voteDownBlock:()->Void
    
    init(target: AnyObject, action: Selector,voteUpBlock:()->Void,voteDownBlock:()->Void) {
        self.voteUpBlock=voteUpBlock
        self.voteDownBlock=voteDownBlock
        
        super.init(target: target, action: action)
        self.voteCell = target as? VoteCell
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesBegan(touches, withEvent: event)
        if touches.count != 1 {
            self.state=UIGestureRecognizerState.Failed
            return
        }
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesMoved(touches, withEvent: event)
        
        if let point:CGPoint = touches.anyObject()?.locationInView(self.view){
            
            let screenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
            
            //here, only background color is changed. However you can detect percentage like in touchesEnded function and for example using self.voteCell you can display an voting animation/view to emphasize that vote will be counted if person raises finger
            if point.x >= screenWidth/2{
                var greenness = ((point.x-screenWidth/2)/screenWidth)
                if greenness>1{
                    greenness=1
                }
                if greenness<0{
                    greenness=0}
                self.view?.backgroundColor=UIColor(red: 1-greenness, green: 1, blue: 1-greenness, alpha: 1)
                
                var thumbUpRatio = (point.x-160)/320
                if thumbUpRatio<0{thumbUpRatio=0}
                if thumbUpRatio>1{thumbUpRatio=1}
                
            }else{
                var redness = ((screenWidth/2-point.x)/screenWidth)
                if redness>1{
                    redness=1
                }
                if redness<0{
                    redness=0}
                self.view?.backgroundColor=UIColor(red: 1, green: 1-redness, blue: 1-redness, alpha: 1)
                
                var thumbUpRatio = (point.x-160)/320
                if thumbUpRatio<0{thumbUpRatio=0}
                if thumbUpRatio>1{thumbUpRatio=1}
                
                
            }
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        super.touchesEnded(touches, withEvent: event)
        
        self.view?.backgroundColor=UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        if let point:CGPoint = touches.anyObject()?.locationInView(self.view){
            let screenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
            //detect which percentage from the edges counts as vote.. then run related block
            // for example 20% from right
            if (screenWidth-point.x)/screenWidth <= 0.2 {
                voteUpBlock()
            }
            // 20% from left
            if point.x/screenWidth <= 0.2 {
                voteDownBlock()
            }
            
        }
    }
    
}