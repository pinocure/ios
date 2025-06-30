import Foundation
import SpriteKit

class BrickGenerator
{
    
    init()
    {
        // 아래 3줄 새로운 블럭 생성해줌
        Variables.dx = 4
        Variables.dy = 2
        Variables.brickValue = Variables.newBrickArrays[0]
        
        let brickValue = Variables.brickValue
        let brick = brickValue.points
        
        Variables.brickArrays = brick
        Variables.brickNode.removeAll()
        
        for item in brick
        {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            Variables.backarrays[y][x] = 1
            
            let xValue = x * brickValue.brickSize + Int(Variables.startPoint.x)
            let yValue = y * brickValue.brickSize + Int(Variables.startPoint.y)
            let brick = SKSpriteNode()
            
            brick.color = brickValue.color
            brick.texture = SKTexture(imageNamed: brickValue.brickName)             // 블럭 색 적용하기
            brick.size = CGSize(width: brickValue.brickSize - Variables.gab, height: brickValue.brickSize - Variables.gab)
            brick.setScale(2.7)                                                     // 블럭 크기 2.5배 적용
            brick.lightingBitMask = 0b0001
            brick.name = brickValue.brickName
            brick.zPosition = brickValue.zPosition
            brick.position = CGPoint(x: xValue, y: -yValue)
            
            Variables.scene.addChild(brick)
            Variables.brickNode.append(brick)
        }
    }
}
