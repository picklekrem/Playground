//
//  PinkViewController.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 8.01.2021.
//

import UIKit
import Firebase

class PinkViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    
    var pulsatingLayer: CAShapeLayer!
    var taskTimesDid = Int()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.outlinestroke
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()

//    let imageview : UIImageView = {
//        let imageview = UIImage()
//        imageview.images
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "pink view cont"
        print(dataSingleton.sharedCommanInf.howManyTimesDid)
        view.backgroundColor = UIColor.bacgroundColor
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)

        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.fillColor = UIColor.pulsatingfillcolor.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.position = view.center
        view.layer.addSublayer(pulsatingLayer)
        
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        view.layer.addSublayer(trackLayer)
        trackLayer.strokeColor = UIColor.trackstorecolor.cgColor
        trackLayer.fillColor = UIColor.bacgroundColor.cgColor
        trackLayer.lineWidth = 20
        trackLayer.position = view.center
        
        animatePulsatinLayer()
        
        shapeLayer.path = circularPath.cgPath
        view.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = UIColor.outlinestroke.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.position = view.center
//        todo imageview hallet
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
        percentageLabel.text = "\(dataSingleton.sharedCommanInf.howManyTimesDid) / 50"
        
        let basicanim = CABasicAnimation(keyPath: "strokeEnd")
        basicanim.toValue = (dataSingleton.sharedCommanInf.otherNumber / 100) * 2
        basicanim.duration = 2
        basicanim.fillMode = .forwards
        basicanim.isRemovedOnCompletion = false
        shapeLayer.add(basicanim, forKey: "basic")
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle)))

    }
    
    

    private func animatePulsatinLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("here i off")
    } 
    
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
