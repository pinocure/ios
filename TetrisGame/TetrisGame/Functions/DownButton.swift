import Foundation
import SpriteKit

class DownButton
{
    let btn = SKSpriteNode()
    
    init()
    {
        btn.texture = SKTexture(imageNamed: "down_btn1")
        btn.size = CGSize(width: 50, height: 50)
        btn.name = "down"
        btn.zPosition = 1
        
        let point1 = Int(Variables.scene.frame.width) / 2
        let point2 = -50
        let xValue = (point1 - point2) / 2
        
        btn.position = CGPoint(x: xValue , y: -Int(Variables.scene.frame.height) + 50)
        Variables.scene.addChild(btn)
    }
    
    func anim()
    {
        var textures = Array<SKTexture>()
        var action = SKAction()
        for i in 1...15
        {
            let name = "down_btn\(i)"
            let texture = SKTexture(imageNamed: name)
            textures.append(texture)
        }
        action = SKAction.animate(with: textures, timePerFrame: 0.03)
        btn.run(action )
    }
    
    func brickDown()
    {
        if isbrickDownable()
        {
            possibleDown()
        }
        else
        {
            impossibleDown()
        }
    }
    
    // 블록이 내려갈 수 있는 경우
    func possibleDown()
    {
        Variables.dy += 1
        var action = SKAction()
        for (i, item) in Variables.brickArrays.enumerated()
        {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            Variables.backarrays[y - 1][x] -= 1
            Variables.backarrays[y][x] += 1
            action = SKAction.moveBy(x: 0, y: -CGFloat(Variables.brickValue.brickSize), duration: 0.1)
            Variables.brickNode[i].run(action)
        }
        anim()
    }
    
    // 블록이 내려갈 수 없는 경우
    func impossibleDown()
    {
        // 값을 2로 변경
        for item in Variables.brickArrays
        {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            Variables.backarrays[y][x] = 2
            
            // 새로운 블럭 생성
            let blocked = SKSpriteNode()
            blocked.color = .gray
            blocked.size = CGSize(width: Variables.brickValue.brickSize - Variables.gab, height: Variables.brickValue.brickSize - Variables.gab)
            blocked.name = "blocked"
            
            let xValue = x * Variables.brickValue.brickSize + Int(Variables.startPoint.x)
            let yValue = y * Variables.brickValue.brickSize + Int(Variables.startPoint.y)
            blocked.position = CGPoint(x: xValue, y: -yValue)
            Variables.scene.addChild(blocked)
            Variables.blockedArrays.append(blocked)
        }
        
        // 기존 블럭 삭제
        for item in Variables.brickNode
        {
            item.removeFromParent()
        }
        
        // 데이터 확인
        for item in Variables.backarrays
        {
            print(item)
        }
        
        checkDelete()
    }
    
    func checkDelete()
    {
        // 블록에서 중복된 y 값을 제거 ( 가로 1줄 만들어지면 삭제되어야 하는데 ㄱ 모양에서 y 값이 2개, 3개 동일한 값이 생기는것을 방지 -> (1,3), (2,3), (3,3), (3,2) 이런식으로 )
        var set = Set<Int>()
        for item in Variables.brickArrays
        {
            let y = Int(item.y) + Variables.dy
            set.insert(y)
        }
        
        // 가로줄을 확인했을때 0이 없고 모두 2라면 삭제
        for y in set.sorted()
        {
            let yValue = y * Variables.brickValue.brickSize + Int(Variables.startPoint.y)
            
            if !Variables.backarrays[y].contains(0)
            {
                Variables.backarrays.remove(at: y)
                
                // row, col 바뀌는거에 따라 자동으로 바뀌도록
                var rowArray = Array<Int>()
                for _ in 0..<Variables.row
                {
                    rowArray.append(0)
                }
                rowArray[rowArray.startIndex] = 2
                rowArray[rowArray.endIndex - 1] = 2
                Variables.backarrays.insert(rowArray, at: 1)
//                Variables.backarrays.insert([2,0,0,0,0,0,0,0,0,2], at:1)                // 수동으로 넣는 방법
                print("삭제되었습니다")
                
                // 삭제 효과음
                Variables.blockedArrays.first?.run(SKAction.playSoundFileNamed("delete.wav", waitForCompletion: false))
                
                // 삭제 효과 emitter
                fire(position: CGPoint(x: Int(Variables.scene.frame.width) / 2, y: -yValue))
                
                for item in Variables.blockedArrays
                {
                    // 같은 라인에 있는 경우 삭제
                    if Int(item.position.y) == -yValue
                    {
                        if let removeItem = Variables.blockedArrays.firstIndex(of: item)
                        {
                            Variables.blockedArrays.remove(at: removeItem)
                            var action = SKAction()
                            action = SKAction.fadeOut(withDuration: 0.1)
                            item.run(action)
                            {
                                item.removeFromParent()
                            }
                        }
                    }
                    
                    // 삭제된 라인위에 있는 블럭 아래로
                    if Int(item.position.y) > -yValue
                    {
                        var action = SKAction()
                        action = SKAction.moveBy(x: 0, y: -CGFloat(Variables.brickValue.brickSize), duration: 0.5)
                        item.run(action)
                    }
                }
            }
        }
        
        // 새로운 블럭 생성
        if isGameOver(deadLine: Variables.dy)
        {
            NextBricks().nextBrickMoveleft()
            _ = BrickGenerator()
        }
    }
    
    func isbrickDownable() -> Bool
    {
        // 테두리 2인것을 기준으로해서 다시 작성
        for item in Variables.brickArrays
        {
            let x = Int(item.x) + Variables.dx
            let y = Int(item.y) + Variables.dy
            if Variables.backarrays[y + 1][x] == 2
            {
                return false
            }
        }
        return true
    }
    
    // 게임 오버
    func isGameOver(deadLine : Int) -> Bool
    {
        if deadLine > 2
        {
            return true
        }
        else
        {
            if let scene = GameOver(fileNamed: "GameOver")
            {
                let transition = SKTransition.moveIn(with: .right, duration: 1)
                Variables.scene.view?.presentScene(scene , transition: transition)
            }
            return false
        }
    }
    
    func fire(position : CGPoint)
    {
        let fire = SKEmitterNode(fileNamed: "Fire.sks")
        fire?.particlePosition = position
        fire?.particlePositionRange = CGVector(dx: Int(Variables.scene.frame.width) - Variables.brickValue.brickSize * 2, dy: Variables.brickValue.brickSize)
        Variables.scene.addChild(fire!)
        
        // 일정시간 지나면 삭제
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            fire?.removeFromParent()
        }
    }
}
