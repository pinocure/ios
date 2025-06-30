import Foundation
import SpriteKit

class NextBricks
{
    
    func addBrick()
    {
        Variables.nodeGroup.removeAll()
        Variables.newBrickArrays.removeAll()
        
        var xValue : CGFloat = 0
        for _ in 0..<10
        {
            xValue += 100
            brickGenerator(brickSpace: xValue)
        }
        
        Variables.nodeGroup.remove(at: 0)
        
        for bricks in Variables.nodeGroup
        {
            for item in bricks
            {
                Variables.scene.addChild(item)
            }
        }
    }
    
    func brickGenerator(brickSpace : CGFloat)
    {
        let yPosition : CGFloat = 50
        let blockValue = Brick().bricks()
        var nextBricksArrays = Array<SKSpriteNode>()
        
        for item in blockValue.points
        {
            let brick = SKSpriteNode()
            let x = item.x
            let y = item.y
            brick.size = CGSize(width: CGFloat(blockValue.brickSize / 2) - 1 , height: CGFloat(blockValue.brickSize / 2) - 1)
            brick.color = blockValue.color
            brick.name = "nextBrick"
            
            let xValue = x * CGFloat(blockValue.brickSize / 2) + brickSpace - 150
            let yValue = y * CGFloat(blockValue.brickSize / 2) + yPosition
            brick.position = CGPoint(x: xValue, y: -yValue)
            nextBricksArrays.append(brick)
        }
        
        Variables.nodeGroup.append(nextBricksArrays)
        Variables.newBrickArrays.append(blockValue)
    }
    
    func nextBrickMoveleft()
    {
        // 배열 첫번째 요소 삭제
        Variables.newBrickArrays.remove(at: 0)
        for item in Variables.nodeGroup.first!
        {
            item.removeFromParent()
        }
        Variables.nodeGroup.remove(at: 0)
        
        // 왼쪽으로 이동
        let action = SKAction.moveBy(x: -100, y: 0, duration: 1)
        for bricks in Variables.nodeGroup
        {
            for item in bricks
            {
                item.run(action)
            }
        }
        
        // 마지막 블럭 생성
        brickGenerator(brickSpace: 1000)
        for item in Variables.nodeGroup.last!
        {
            Variables.scene.addChild(item)
        }
    }
}
