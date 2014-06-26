

import UIKit
import QuartzCore

class YYSegmentIndicator: UIView {

    var cornerRadius:Float?{
        set{
            self.layer.cornerRadius = self.cornerRadius!
            self.setNeedsDisplay()
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
    var borderWidth:Float?{
        set{
            self.layer.borderWidth = self.borderWidth!
        }
        get{
            return self.layer.borderWidth
        }
    }
    
    var borderColor:UIColor?{
        set{
            self.layer.borderColor = self.borderColor!.CGColor
        }
        get{
            return UIColor(CGColor:self.layer.borderColor)
        }
    }
    
    var _drawsGradientBackground:Bool?
    var drawsGradientBackground:Bool?{
        set{
            self._drawsGradientBackground = newValue
            self.setNeedsDisplay()
        }
        get{
            return self._drawsGradientBackground
        }
    }
    
    var _gradientTopColor:UIColor?
    var gradientTopColor:UIColor?{
        set{
            self._gradientTopColor = newValue
            self.setNeedsDisplay()
        }
        get{
            return self._gradientTopColor
        }
    }
    
    var _gradientBottomColor:UIColor?
    var gradientBottomColor:UIColor?{
        set{
            self._gradientBottomColor = newValue
            self.setNeedsDisplay()
        }
        get{
            return self._gradientBottomColor
        }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.userInteractionEnabled = false
        self.drawsGradientBackground = false
        self.opaque = false
        self.cornerRadius = 4.0
        self.gradientTopColor = UIColor(red:0.27,green:0.54,blue:0.21,alpha:1.0)
        self.gradientBottomColor = UIColor(red:0.22,green:0.43,blue:0.16,alpha:1.0)
        self.borderColor = UIColor.lightGrayColor()
        self.borderWidth = 1.0
        
        // Initialization code
    }

    override func drawRect(rect: CGRect) {
        if self.drawsGradientBackground {
            var gradientLayer:CAGradientLayer = self.superview.layer as CAGradientLayer
            gradientLayer.colors = [self.gradientTopColor!.CGColor,self.gradientBottomColor!.CGColor]
        } else {
            self.layer.backgroundColor = self.backgroundColor.CGColor
        }
    }
}
