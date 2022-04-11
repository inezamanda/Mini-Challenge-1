//
//  ProgressBar.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 12/04/22.
//

import UIKit

class ProgressBar: UIView {
    
    @IBInspectable public lazy var backgroundCircleColor: UIColor = UIColor.secondarySystemFill
    @IBInspectable public lazy var foregroundRedCircleColor: UIColor = UIColor.systemRed
    @IBInspectable public lazy var foregroundYellowCircleColor: UIColor = UIColor.systemYellow
    @IBInspectable public lazy var foregroundGreenCircleColor: UIColor = UIColor.systemGreen
    @IBInspectable public lazy var textColor: UIColor = UIColor.black

    private lazy var fillColor: UIColor = UIColor.clear
    
    private var backgroundLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
    public var progress: CGFloat = 0 {
        didSet {
          didProgressUpdated()
        }
      }
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
        backgroundLayer = createCircularLayer(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        
        print(progress)
        if (progress >= 0 && progress <= 0.35) {
            progressLayer = createCircularLayer(strokeColor: foregroundRedCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        } else if (progress > 0.35 && progress <= 0.7) {
            progressLayer = createCircularLayer(strokeColor: foregroundYellowCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        } else {
            progressLayer = createCircularLayer(strokeColor: foregroundGreenCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        }
        
        progressLayer.strokeEnd = progress

        textLayer = createTextLayer(textColor: textColor)
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
        layer.addSublayer(textLayer)
    }
    
    private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let width = frame.size.width
        let height = frame.size.height
        
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = fillColor
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
    private func createTextLayer(textColor: UIColor) -> CATextLayer {

      let width = frame.size.width
      let height = frame.size.height

      let fontSize = min(width, height) / 4 - 5
      let offset = min(width, height) * 0.1

      let layer = CATextLayer()
      layer.string = "\(Int(progress * 100))"
      layer.backgroundColor = UIColor.clear.cgColor
      layer.foregroundColor = textColor.cgColor
      layer.fontSize = fontSize
      layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: height)
      layer.alignmentMode = .center

      return layer
    }
    
    private func didProgressUpdated() {
        
        textLayer?.string = "\(Int(progress * 100))"
        progressLayer?.strokeEnd = progress
      }
}
