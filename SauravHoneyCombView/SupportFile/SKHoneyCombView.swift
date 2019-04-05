//
//  SKHoneyCombView.swift
//  SauravHoneyCombView
//
//  Created by Saurav on 2/20/19.
//  Copyright © 2019 Saurav. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Protocols...
protocol HoneyCombViewDelegate {
    func didSelectHoneyComb(_ honeyCombObject: SKHoneyCombObject,_ honeyCombView: HoneyComb)
}

class SKHoneyCombView:UIView {
    
    //MARK: Variables.....
    
    public var honeyCombObjectsArr: [SKHoneyCombObject] = []
    public var numberOfRows = 4
    let padding: CGFloat = 8
    var scrollView: UIScrollView!
    var contentView: UIView!
    var shiftYRowView:CGFloat = 0
    var delegate:HoneyCombViewDelegate?
    
    
    //MARK:- App life Cycle....
    
    override func layoutSubviews() {
        reloadData()
    }
   
    //MARK:- Private Methods....
    
    private func reloadData() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
        createLayout()
    }
    
    //This Function will Create layout....
    
    private func createLayout() {
        let topAndBottomPadding = (CGFloat(self.numberOfRows / 2) * self.padding)
        self.scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = .clear
        self.addSubview(self.scrollView)
        self.contentView = UIView(frame: CGRect(x: 0, y: topAndBottomPadding, width: self.scrollView.bounds.width, height: (self.bounds.height - 2 * topAndBottomPadding)))
        self.contentView.backgroundColor = UIColor.clear
        self.scrollView.addSubview(self.contentView)
        drawRowView()
    }
    
    /*This Fucntion will tell,
     how many items will place inside the particular row*/
    
    private func numberOfItemsInRow() -> [Int:[SKHoneyCombObject]] {
        var sortedDataSource = [Int:[SKHoneyCombObject]]()
        var honeyCombMutableObjects = self.honeyCombObjectsArr
        var quotient = 0;
        var remainder = 0;
        let totalCountOfObjects = honeyCombMutableObjects.count
        let value = totalCountOfObjects.quotientAndRemainder(dividingBy: self.numberOfRows)
        quotient = value.quotient
        remainder = value.remainder
        if quotient != 0 {
            for i in 0..<self.numberOfRows {
                for _ in 0..<quotient {
                    if (sortedDataSource[i] != nil) {
                        sortedDataSource[i]?.append(honeyCombMutableObjects.removeFirst())
                    } else {
                        sortedDataSource[i] = [honeyCombMutableObjects.removeFirst()]
                    }
                }
            }
        }
        
        if (remainder != 0) {
            for x in 0..<remainder {
                if (sortedDataSource[x] != nil) {
                    sortedDataSource[x]?.append(honeyCombMutableObjects.removeFirst())
                } else {
                    sortedDataSource[x] = [honeyCombMutableObjects.removeFirst()]
                }
            }
        }
        
        return sortedDataSource
    }
    
    private func drawRowView() {
        let sourceData:[Int:[SKHoneyCombObject]] =  numberOfItemsInRow()
        let height = self.contentView.frame.size.height
        let heightOfRowView = (height/CGFloat(self.numberOfRows))
        var itemCount = 0
        
        for (key,value) in sourceData {
            
            itemCount = value.count
            let rowView = UIView()
            rowView.tag = key
            rowView.frame.size = CGSize(width: 0, height: heightOfRowView)
            //Place Button in row View....
            
            for x in 0..<itemCount {
                let backView = UIView()
                let honeyView = HoneyComb()
                let itemWidth = heightOfRowView
                //item.frame.size = CGSize(width: itemWidth , height: itemWidth)
                backView.frame.size = CGSize(width: itemWidth, height: itemWidth)
                honeyView.frame.size = CGSize(width: itemWidth , height: itemWidth)
                
                honeyView.honeyCombButton.tag = x
                var centerX:CGFloat!
                let centerY:CGFloat!
                
                /* how much X- space will reduce because
                 when we create Hexagon inside the Square in that case,the Side of Hexagon are
                 smaller than Square .
                 */
                let shiftLeftX =  itemWidth * CGFloat(1 - sin((Double.pi / 3)))
                
                //Calculation for Center Of X points of items which will be placed inside Row....
                
                if(isEven(key)) {
                    centerX = ((CGFloat(x + 1)) * self.padding) + ((honeyView.frame.width / 2) * ((2 * CGFloat(x)) + 1)) - (CGFloat(x) * (shiftLeftX))
                } else {
                    
                    let extraSpace = (honeyView.frame.width / 2) + (self.padding / 2) - (shiftLeftX / 2)
                    centerX = extraSpace + ((CGFloat(x + 1)) * self.padding) + ((honeyView.frame.width / 2) * ((2 * CGFloat(x)) + 1))  - (CGFloat(x) * (shiftLeftX))
                    
                    if(x == 0) {
                        rowView.frame.size.width += (extraSpace)
                    }
                }
                
                
                // To maintain Y-Distance between Hexgons
                
                let shiftUpY = (((itemWidth / 2) * (CGFloat(sin(Double.pi / 5.8))) - (self.padding)))
                
                let itemShifty =  CGFloat(key) * shiftUpY
                
                centerY = rowView.center.y - itemShifty
                
                shiftYRowView = shiftUpY
                backView.center = CGPoint(x: centerX, y: centerY)
    
               
                applyHexagonMaskOnUIView(view: backView)
                
                
                honeyView.backgroundColor = .green
                honeyView.transform = honeyView.transform.rotated(by: -CGFloat(Double.pi / 2))
                backView.addSubview(honeyView)
              
                honeyView.honeyCombButton.accessibilityElements = [value[x],honeyView]
                honeyView.honeyCombButton.addTarget(self, action: #selector(didSelectItem(_:)), for: .touchUpInside)
                rowView.frame.size.width += (honeyView.frame.size.width + self.padding - shiftLeftX)
                rowView.addSubview(backView)
               
            }//end....
            
            rowView.frame.size.width += (2 * self.padding)
            rowView.frame.origin = CGPoint(x: 0, y: CGFloat(key) * rowView.frame.height + (shiftYRowView))
            if (self.contentView.frame.size.width < rowView.frame.size.width) {
                self.scrollView.contentSize.width = rowView.frame.size.width
                self.contentView.frame.size.width = rowView.frame.size.width
            }
            self.contentView.addSubview(rowView)
        }
        
        
    }
    
    private func isEven(_ number: Int) -> Bool {
        
        var result: Bool
        
        if number % 2 == 0 {
            result = true
        }
        else {
            result = false
        }
        return result
    }
    
    
    private func applyHexagonMaskOnUIView(view:UIView) {
        let maskPath = UIBezierPath(frame: view.bounds, numberOfSides: 6, cornerRadius: 0.0)
        let maskingLayer = CAShapeLayer()
        maskingLayer.path = maskPath?.cgPath
        view.transform = view.transform.rotated(by: CGFloat(Double.pi / 2))
        view.layer.mask = maskingLayer
    }
    
    @objc func didSelectItem(_ target: UIButton) {
        if let firstData = target.accessibilityElements?.first as? SKHoneyCombObject,let honeyView = target.accessibilityElements?.last as? HoneyComb {
            delegate?.didSelectHoneyComb(firstData, honeyView)
          //  print(firstData.name)
        }
    }
}//Class......

