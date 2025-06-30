import Foundation
import SpriteKit

class RotationButton
{
    
    let btn = SKSpriteNode()
    
    init()
    {
        btn.texture = SKTexture(imageNamed: "rotation_btn1")
        btn.size = CGSize(width: 50, height: 50)
        btn.name = "rotation"
        btn.zPosition = 1
        btn.position = CGPoint(x: Int(Variables.scene.frame.width) / 2 , y: -Int(Variables.scene.frame.height) + 50)
        Variables.scene.addChild(btn)
    }
    
    func anim()
    {
        var textures = Array<SKTexture>()
        var action = SKAction()
        for i in 1...15
        {
            let name = "rotation_btn\(i)"
            let texture = SKTexture(imageNamed: name)
            textures.append(texture)
        }
        action = SKAction.animate(with: textures, timePerFrame: 0.03)
        btn.run(action )
    }
    
    func brickRotation()
    {
        if isRotatable()
        {
            let sinX = CGFloat(1)
            let cosX = CGFloat(0)
            var rotatedBrick = Array<CGPoint>()
            var action = SKAction()
            
            for (i, item) in Variables.brickArrays.enumerated()
            {
                let r = item.y
                let c = item.x
                let currentX = Int(item.x) + Variables.dx
                let currentY = Int(item.y) + Variables.dy
                Variables.backarrays[currentY][currentX] -= 1
                
                // 삼각함수 공식 사용해서 회전시킴
                let newBrickX = (c * cosX) - (r * sinX)
                let newBrickY = (c * sinX) + (r * cosX)
                rotatedBrick.append(CGPoint(x: newBrickX, y: newBrickY))
                
                // 변경된값 적용하기
                let newX = Int(newBrickX) + Variables.dx
                let newY = Int(newBrickY) + Variables.dy
                Variables.backarrays[newY][newX] += 1
                
                // 움직임 보이도록
                let xValue = Int(newX) * Variables.brickValue.brickSize + Int(Variables.startPoint.x)
                let yValue = Int(newY) * Variables.brickValue.brickSize + Int(Variables.startPoint.y)
                action = SKAction.move(to: CGPoint(x: xValue, y: -yValue), duration: 0.1)
                Variables.brickNode[i].run(action)
            }
            Variables.brickArrays = rotatedBrick
            
        }
        
        anim()
        
        for item in Variables.backarrays
        {
            print(item)
        }
    }
    
    func isRotatable() -> Bool
    {
        // 네모는 회전 안되도록
        if Variables.brickValue.brickName == "brick5"
        {
            return false
        }
         
        // 테두리 침범하지 않도록 조건설정하기
        let sinX = CGFloat(1)
        let cosX = CGFloat(0)
        for item in Variables.brickArrays
        {
            // 0의 0 값은 건드리면 안된다..??? -> 원점 제외하고 나머지 돌렸을때
            if item.x != 0 || item.y != 0
            {
                let r = item.y
                let c = item.x
                let x = Int((c * cosX) - (r * sinX)) + Variables.dx
                let y = Int((c * sinX) - (r * cosX)) + Variables.dy

                if Variables.backarrays[y][x] == 2
                {
                    // 테두리가 2 이므로 2인경우는 회전이 안되도록
                    return false
                }
            }
        }
        
        return true
    }
    
    
}
