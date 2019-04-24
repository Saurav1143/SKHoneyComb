# SKHoneyComb
[![Honey-Comb-View.gif](https://i.postimg.cc/cCfrt0FY/Honey-Comb-View.gif)](https://postimg.cc/sGDVtddD)

# Usage

```
@IBOutlet weak var skHoneyCombView: SKHoneyCombView!

var honeycombObjectsArray: [SKHoneyCombObject] = []

override func viewDidLoad() {
        super.viewDidLoad()
       for i in 0..<24 {
            let honeycombObject = SKHoneyCombObject()
            honeycombObject.name = "This Is HoneyComb Object \(i)"
            self.honeycombObjectsArray.append(honeycombObject)
        }
        self.skHoneyCombView.honeyCombObjectsArr = self.honeycombObjectsArray
    }
```
 # Delegate
 **HoneyCombViewDelegate**
 ```
func didSelectHoneyComb(_ honeyCombObject: SKHoneyCombObject, _ honeyCombView: HoneyComb) {
        honeyCombObject.isSelected = !honeyCombObject.isSelected
        if (honeyCombObject.isSelected){
            honeyCombView.backGroundImage.image = UIImage(named: "blue")
        } else {
           honeyCombView.backGroundImage.image = UIImage(named: "gray-honey")
        }
        
    }
 ```
