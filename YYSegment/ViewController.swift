
import UIKit

class ViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var segment:YYSegmentedControl = self.segmentedNormalControlWithItems(["one","two","three"])
        self.view.addSubview(segment)
        
        segment.center = CGPointMake(160, 200)
        
        
        var circlesegment = self.segmentedControlSemicircleWithItems(["one","two","three"])
        self.view.addSubview(circlesegment)
        
        circlesegment.center = CGPointMake(160, 400)
        circlesegment.selectedSegmentIndex = 2
        circlesegment.addTarget(self, action: "circlesegmentValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        // Do any additional setup after loading the view.
    }

    func circlesegmentValueChanged(seg:YYSegmentedControl){
        println(seg.selectedSegmentIndex)
    }
    
    func segmentedNormalControlWithItems(items:NSArray)->YYSegmentedControl{
        var segmentedControl = YYSegmentedControl(items:items)
        segmentedControl.titleColor = UIColor(red:0xab/255.0,green:0xc8/255.0, blue:0x8c/255.0,alpha:1)
        segmentedControl.selectedTitleTextColor = UIColor.whiteColor()
        segmentedControl.selectedTitleFont = UIFont.boldSystemFontOfSize(13.0)
        segmentedControl.segmentIndicatorBackgroundColor = UIColor(red:0x63/255.0 ,green:0x9f/255.0 ,blue:0x24/255.0 ,alpha:1)
        segmentedControl.backgroundColor = UIColor(red:0xd8/255.0 ,green:0xe7/255.0 ,blue:0xc8/255.0 ,alpha:1)
        segmentedControl.borderWidth = 0.0
        segmentedControl.segmentIndicatorBorderWidth = 2.0
        segmentedControl.segmentIndicatorBorderColor = UIColor(red:0x63/255.0, green:0x9f/255.0,blue:0x24/255.0,alpha:1)
        segmentedControl.sizeToFit()
        segmentedControl.segmentIndicatorCornerRadius = 0
        return segmentedControl
    }
    
    
    func segmentedControlSemicircleWithItems(items:NSArray)->YYSegmentedControl{
        var segmentedControl = YYSegmentedControl(items:items)
        segmentedControl.titleColor = UIColor(red:0xab/255.0,green:0xc8/255.0, blue:0x8c/255.0,alpha:1)
        segmentedControl.selectedTitleTextColor = UIColor.whiteColor()
        segmentedControl.selectedTitleFont = UIFont.boldSystemFontOfSize(13.0)
        segmentedControl.segmentIndicatorBackgroundColor = UIColor(red:0x63/255.0 ,green:0x9f/255.0 ,blue:0x24/255.0 ,alpha:1)
        segmentedControl.backgroundColor = UIColor(red:0xd8/255.0 ,green:0xe7/255.0 ,blue:0xc8/255.0 ,alpha:1)
        segmentedControl.borderWidth = 0.0
        segmentedControl.segmentIndicatorBorderWidth = 2.0
        segmentedControl.segmentIndicatorBorderColor = UIColor(red:0x63/255.0, green:0x9f/255.0,blue:0x24/255.0,alpha:1)
        segmentedControl.segmentIndicatorInset = 3.0
        segmentedControl.sizeToFit()
        segmentedControl.cornerRadius = CGRectGetHeight(segmentedControl.frame) / 2.0
        segmentedControl.segmentIndicatorCornerRadius = CGRectGetHeight(segmentedControl.frame) / 2.0
        return segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
