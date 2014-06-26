

import UIKit
import QuartzCore
class YYSegmentedControl: UIControl {

    var stylesTitleForSelectedSegment:Bool?
    
    var _titleFont:UIFont?
    var titleFont:UIFont?{
    set{
        self._titleFont = newValue
        self.setNeedsDisplay()
    }
    get{
       return self._titleFont
    }
    }
    
    var _titleColor:UIColor?
    var titleColor:UIColor?{
    set{
        self._titleColor = newValue
        self.setNeedsDisplay()
    }
    get{
       return self._titleColor
    }
    }
    
    var _selectedTitleFont:UIFont?
    var selectedTitleFont:UIFont?{
    set{
        self._selectedTitleFont = newValue
        self.setNeedsDisplay()
    }
    get{
        return self._selectedTitleFont
    }
    }
    
    var _selectedTitleTextColor:UIColor?
    var selectedTitleTextColor:UIColor?{
    set{
        self._selectedTitleTextColor = newValue
        self.setNeedsDisplay()
    }
    get{
        return self._selectedTitleTextColor
    }
    }
    
    var cornerRadius:Float?{
        set{
            self.layer.cornerRadius = newValue!
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
    var borderWidth:Float?{
    set{
        self.layer.borderWidth = newValue!
    }
    get{
        return self.layer.borderWidth
    }
    }
    
    var borderColor:UIColor?{
    set{
        self.layer.borderColor = newValue!.CGColor
    }
    get{
        return UIColor(CGColor: self.layer!.borderColor)
    }
    }
    
    var drawsGradientBackground:Bool?
    
    var gradientTopColor:UIColor?
    
    var gradientBottomColor:UIColor?
    
    var segmentIndicatorAnimationDuration:NSTimeInterval?
    
    var _segmentIndicatorInset:Float?
    var segmentIndicatorInset:Float?{
    set{
        self._segmentIndicatorInset = newValue
        self.setNeedsLayout()
    }
    get{
        return self._segmentIndicatorInset
    }
    }
    
    var drawsSegmentIndicatorGradientBackground:Bool?{
    set{
        self.selectedSegmentIndicator!.drawsGradientBackground = newValue!
    }
    get{
        return self.selectedSegmentIndicator!.drawsGradientBackground
    }
    }
    
    var segmentIndicatorBackgroundColor:UIColor?{
    set{
        self.selectedSegmentIndicator!.backgroundColor = newValue!
    }
    get{
        return self.selectedSegmentIndicator!.backgroundColor
    }
    }
    
    var segmentIndicatorGradientTopColor:UIColor?{
    set{
        self.selectedSegmentIndicator!.gradientTopColor = newValue!
    }
    get{
        return self.selectedSegmentIndicator!.gradientTopColor
    }
    }
    
    var segmentIndicatorGradientBottomColor:UIColor?{
    set{
        self.selectedSegmentIndicator!.gradientBottomColor = newValue!
    }
    get{
        return self.selectedSegmentIndicator!.gradientBottomColor
    }
    }
    
    var segmentIndicatorBorderColor:UIColor?{
    set{
        self.selectedSegmentIndicator!.borderColor = newValue!
    }
    get{
        return self.selectedSegmentIndicator!.borderColor
    }
    }
    
    var segmentIndicatorBorderWidth:Float?{
    set{
        self.selectedSegmentIndicator!.borderWidth = newValue!
    }
    get{
        return self.selectedSegmentIndicator!.borderWidth
    }
    }
    
    var segmentIndicatorCornerRadius:Float?{
    set{
        self.selectedSegmentIndicator!.layer.cornerRadius = newValue!-self.segmentIndicatorInset!/2.0
    }
    get{
        return self.selectedSegmentIndicator!.layer.cornerRadius
    }
    }
    
    var numberOfSegments:Int?{

       return self.segments!.count
    
    }
    
    var _selectedSegmentIndex:Int?
    var selectedSegmentIndex:Int?{
    set{
        self._selectedSegmentIndex = newValue
        if self._selectedSegmentIndex! >= self.numberOfSegments {
            self._selectedSegmentIndex = self.numberOfSegments!-1
        }
        
        self.moveSelectedSegmentIndicatorToSegment(index:self._selectedSegmentIndex!,animated:false)
    }
    get{
        return self._selectedSegmentIndex
    }
    }
    
    var segments:NSArray?
    
    var selectedSegmentIndicator:YYSegmentIndicator?
    
    override class func layerClass()->AnyClass{
        return CAGradientLayer.self
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    init(items: NSArray){
        super.init(frame: CGRectZero)
        self.initialize()
        var mutableSegments = NSMutableArray()
        
        for segmentTitle : AnyObject in items {
            var segment = YYSegment(title: segmentTitle as NSString)
            self.addSubview(segment)
            mutableSegments.addObject(segment)
        }
        
        self.segments = NSArray(array:mutableSegments)
        self.selectedSegmentIndex = 0
    }
    
    func initialize(){
        self.titleFont = UIFont.systemFontOfSize(13.0)
        self.titleColor = UIColor.blackColor()
        self.selectedTitleFont = UIFont.boldSystemFontOfSize(13.0)
        self.selectedTitleTextColor = UIColor.blackColor()
        self.stylesTitleForSelectedSegment = true
        self.segmentIndicatorInset = 0.0
        self.segmentIndicatorAnimationDuration = 0.15
        self.gradientTopColor = UIColor(red:0.21,green:0.21,blue:0.21,alpha:1.0)
        self.gradientBottomColor = UIColor(red:0.16,green:0.16,blue:0.16,alpha:1.0)
        
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1.0
        
        self.backgroundColor = UIColor(white:0.9,alpha:1.0)
        self.drawsGradientBackground = false
        self.opaque = false
        self.segments = NSArray()
        
        self.selectedSegmentIndicator = YYSegmentIndicator(frame:CGRectZero)
        self.drawsSegmentIndicatorGradientBackground = true
        self.addSubview(self.selectedSegmentIndicator)
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        
        var maxSegmentWidth:Float = 0.0
        
        for  segment:AnyObject in self.segments! {
            var segmentWidth = segment.sizeThatFits(size).width
            if (segmentWidth > maxSegmentWidth) {
                maxSegmentWidth = segmentWidth
            }
        }
        var num = self.segments!.count
        var width:Float = maxSegmentWidth * Float(num)
        return CGSizeMake(width, 30.0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var segmentWidth = CGRectGetWidth(self.frame) / Float(self.segments!.count)
        var segmentHeight = CGRectGetHeight(self.frame)
        for var i = 0 ;i < self.segments!.count;i++ {
            var segment = self.segments![i] as YYSegment
            segment.frame = CGRectMake(segmentWidth * Float(i), 0.0, segmentWidth, segmentHeight)
            
            if self.stylesTitleForSelectedSegment && self.selectedSegmentIndex == i {
                segment.titleLabel!.font = self.selectedTitleFont
                segment.titleLabel!.textColor = self.selectedTitleTextColor
            } else {
                segment.titleLabel!.font = self.titleFont
                segment.titleLabel!.textColor = self.titleColor
            }
        }
        
        self.selectedSegmentIndicator!.frame = self.indicatorFrameForSegment(self.segments![self.selectedSegmentIndex!] as YYSegment)
    }
    
    
    override func drawRect(rect: CGRect)
    {
        if self.drawsGradientBackground {
            var gradientLayer = self.layer as CAGradientLayer
            gradientLayer.colors = [self.gradientTopColor!.CGColor,self.gradientBottomColor!.CGColor]
        } else {
            self.layer.backgroundColor = self.backgroundColor.CGColor
        }
    }
    
    func insertSegmentWithTitle(#title:NSString,var index:Int){
        var num = self.segments!.count
        if index > num {
            index = self.segments!.count
        }
        
        var newSegment:YYSegment = YYSegment(title:title)
        self.addSubview(newSegment)
        
        var mutableSegments = NSMutableArray(array:self.segments)
        mutableSegments.insertObject(newSegment,atIndex:index)
        self.segments = NSArray(array:mutableSegments)
        
        self.setNeedsLayout()
    }
    
    func removeSegmentAtIndex(var index:Int){
        if (index >= self.numberOfSegments) {
            index = self.numberOfSegments! - 1
        }
        
        var segment:YYSegment = self.segments![index] as YYSegment
        segment.removeFromSuperview()
        
        var mutableSegments = NSMutableArray(array:self.segments)
        mutableSegments.removeObjectAtIndex(index)
        self.segments = NSArray(array:mutableSegments)
        
        self.setNeedsLayout()
    }
    
    func removeAllSegments(){
        for seg:AnyObject in self.segments! {
            var segment = seg as YYSegment
            segment.removeFromSuperview()
        }
        
        self.segments = NSArray()
        self.setNeedsLayout()
    }
    
    
    func setTitle(title:NSString,index:Int){
        var segment = self.segments![index] as YYSegment
        segment.titleLabel!.text = title
    }
    
    func titleForSegmentAtIndex(index:Int)->NSString{
        var segment = self.segments![index] as YYSegment
        return segment.titleLabel!.text
    }
    
    
    func indicatorFrameForSegment(segment:YYSegment)->CGRect{
        return CGRectMake(CGRectGetMinX(segment.frame) + self.segmentIndicatorInset!,
            CGRectGetMinY(segment.frame) + self.segmentIndicatorInset!,
            CGRectGetWidth(segment.frame) - (2.0 * self.segmentIndicatorInset!),
            CGRectGetHeight(segment.frame) - (2.0 * self.segmentIndicatorInset!))
    }
    
    func moveSelectedSegmentIndicatorToSegment(#index:Int,animated:Bool){
        // If we're moving the indicator back to the originally selected segment, don't change the segment's font style
        if index != self.selectedSegmentIndex! {
            var previousSegment = self.segments![self.selectedSegmentIndex!] as YYSegment
            previousSegment.titleLabel!.font = self.titleFont
            previousSegment.titleLabel!.textColor = self.titleColor
        }
        
        var selectedSegment = self.segments![index] as YYSegment
        
        if animated {
            UIView.animateWithDuration(self.segmentIndicatorAnimationDuration!, animations: {
                self.selectedSegmentIndicator!.frame = self.indicatorFrameForSegment(selectedSegment)
                }, completion:{(_)-> Void in
                    if self.stylesTitleForSelectedSegment {
                        selectedSegment.titleLabel!.font = self.selectedTitleFont
                        selectedSegment.titleLabel!.textColor = self.selectedTitleTextColor
                
                    if self.drawsSegmentIndicatorGradientBackground {
                    //selectedSegment.titleLabel.shadowColor = [UIColor darkGrayColor]
                    }
                    }
                })
        } else {
            self.selectedSegmentIndicator!.frame = self.indicatorFrameForSegment(selectedSegment)
            
            if self.stylesTitleForSelectedSegment {
                selectedSegment.titleLabel!.font = self.selectedTitleFont
                selectedSegment.titleLabel!.textColor = self.selectedTitleTextColor
            }
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch!, withEvent event: UIEvent!) -> Bool {
        // If the user is touching the slider, start tracking the drag. Otherwise, select the segement that was tapped
        if CGRectContainsPoint(self.selectedSegmentIndicator!.bounds, touch.locationInView(self.selectedSegmentIndicator)) {
            return true
        } else {
            // Otherwise, find the segment that the user touched, and select it
            
            
            for var index = 0; index<self.segments!.count; ++index{
                var segment = self.segments![index] as YYSegment
                if (CGRectContainsPoint(segment.frame, touch.locationInView(self))) {
                    if self.selectedSegmentIndicator!.frame.size.width == 0{
                        self.setSelectedSegmentIndex(index:index,animation:false)
                        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
                    }else if index != self.selectedSegmentIndex! {
                        self.setSelectedSegmentIndex(index:index,animation:true)
                        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
                    }
                }
            }
        }
        return false
    }
    
    
    func setSelectedSegmentIndex(#index:Int,animation:Bool){
        if selectedSegmentIndex >= self.numberOfSegments {
            selectedSegmentIndex = self.numberOfSegments! - 1;
        }
        
        self.moveSelectedSegmentIndicatorToSegment(index:index ,animated:animation)
        self.selectedSegmentIndex = index
    }
    
    func continueMove(x:Float){
        if self.stylesTitleForSelectedSegment {
            
            for var index = 0; index<self.segments!.count; ++index{
                var segment = self.segments![index] as YYSegment
                if CGRectContainsPoint(segment.frame, self.selectedSegmentIndicator!.center) {
                    segment.titleLabel!.font = self.selectedTitleFont;
                    segment.titleLabel!.textColor = self.selectedTitleTextColor
                } else {
                    segment.titleLabel!.font = self.titleFont;
                    segment.titleLabel!.textColor = self.titleColor;
                }
            }
        }
        
        // Check that the indicator doesn't exit the bounds of the control
        var newSegmentIndicatorFrame = self.selectedSegmentIndicator!.frame
        newSegmentIndicatorFrame.origin.x = x
        
        if (CGRectContainsRect(CGRectInset(self.bounds, self.segmentIndicatorInset!, 0), newSegmentIndicatorFrame)) {
            self.selectedSegmentIndicator!.frame = newSegmentIndicatorFrame;
        }
    }
    
    override func endTrackingWithTouch(touch: UITouch!, withEvent event: UIEvent!) {
        for var index = 0; index<self.segments!.count; ++index{
            var segment = self.segments![index] as YYSegment
            
            if (CGRectContainsPoint(segment.frame, self.selectedSegmentIndicator!.center)) {
                self.moveSelectedSegmentIndicatorToSegment(index: index, animated: true)
                if index != self.selectedSegmentIndex {
                    self.selectedSegmentIndex = index
                    self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
                }
            }
        }
        
    }
    
    func setBackgroundColor(backgroundColor:UIColor){
        self.layer!.backgroundColor = backgroundColor.CGColor
    }
    
    func backgroundColor()->UIColor{
        return UIColor(CGColor:self.layer!.backgroundColor)
    }
    
    func setFrame(frame:CGRect){
        super.frame = frame
    }
    
}
