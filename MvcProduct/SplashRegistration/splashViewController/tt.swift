//
//  tt.swift
//  MvcProduct
//
//  Created by Mahmoud on 28/06/2022.
//

import UIKit

class tt: UIView {


    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var tracklayer = CAShapeLayer()
    /*
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func draw(_ rect: CGRect) {
            // Drawing code
        }
        */
    override init(frame: CGRect) {
    super.init(frame: frame)
    createCircularPath()
        }
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    createCircularPath()
        }
    
//    var progressColor:UIColor = UIColor.red {
//    didSet {
//                progressLayer.strokeColor = progressColor.cgColor
//            }
//        }
    
    
//    var trackColor:UIColor = UIColor.white {
//    didSet {
//                tracklayer.strokeColor = trackColor.cgColor
//            }
//        }
    fileprivate func createCircularPath() {
        
 //   self.backgroundColor = UIColor.clear
//    self.layer.cornerRadius = self.frame.size.width/2.0
   
      //  let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
  //  radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * Double.pi),
 //   endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
       //     tracklayer.path = circlePath.cgPath
//            tracklayer.fillColor = UIColor.clear.cgColor
//            tracklayer.strokeColor = trackColor.cgColor
//            tracklayer.lineWidth = 10.0;
//            tracklayer.strokeEnd = 1.0
//            layer.addSublayer(tracklayer)
//        //    progressLayer.path = circlePath.cgPath
//            progressLayer.fillColor = UIColor.clear.cgColor
//            progressLayer.strokeColor = progressColor.cgColor
//            progressLayer.lineWidth = 10.0;
//            progressLayer.strokeEnd = 0.0
//            layer.addSublayer(progressLayer)
        
        ////
        ///
        ///
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.size.width*0.5  , y: UIScreen.main.bounds.size.height*0.5 ), radius: 140, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    
        self.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.center = self.center
        
        tracklayer.path = circlePath.cgPath
        tracklayer.lineWidth = 6
        tracklayer.strokeColor = UIColor.lightGray.cgColor
        tracklayer.fillColor = UIColor.clear.cgColor
         //view.layer.addSublayer(trackcolor)
     //   view.layer.addSublayer(trackcolor)
       // self.view.addSubview(view)
  //     self.view.layoutIfNeeded()
        layer.addSublayer(tracklayer)
        self.layer.layoutIfNeeded()
//
        progressLayer.path = circlePath.cgPath
        progressLayer.lineWidth = 6
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(shape)
//        self.view.layoutIfNeeded()
        layer.addSublayer(progressLayer)


        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 3.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        progressLayer.add(animation, forKey: "animation")
      //  self.view.layoutIfNeeded()
        }

}
