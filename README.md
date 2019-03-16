# SKHoneyComb

[![SKHoney-Comb-View.gif](https://i.postimg.cc/QC9Y7w0V/SKHoney-Comb-View.gif)](https://postimg.cc/sGzJd6FR)

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
 func didSelectHoneyComb(_ honeyCombObject: SKHoneyCombObject) {
        print(honeyCombObject.name)
    }
 ```
