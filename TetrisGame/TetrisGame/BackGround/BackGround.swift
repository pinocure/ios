import Foundation
import SpriteKit

// 2차원 배열위에서 진행될것이다
class BackGround
{
//    var arrays = [[Int]]()
    //var arrays1 = Array<Array<Int>>() // 이런식으로 2차원 배열을 생성할 수 있다
    
    // 가로 10, 세로 20
    let row = Variables.row
    let col = Variables.col
    
    // 벽 생성하는 부분
    let brickSize = Variables.brickValue.brickSize
    let gab = Variables.gab
    let scene = Variables.scene
    
    init()
    {
        Variables.backarrays  = Array(repeating: Array(repeating: 0, count: row), count: col)
        // 시작 포인트는 width 값에서 벽블럭의 값을 뺀 값에 나누기 2를 하면 중간으로
        let xValue = ((Int(scene.frame.width) - row * brickSize) + brickSize) / 2
        Variables.startPoint = CGPoint(x: xValue, y: 100)
        bg()
    }
    
    // 사각형의 테두리 벽 만들기 0에서 1로 변경
    func bg()
    {
        // 배경화면 색상
        let bg = SKSpriteNode()
        bg.color = .black
        bg.size = Variables.scene.frame.size
        bg.position = CGPoint(x: 0, y: 0)
        bg.anchorPoint = CGPoint(x: 0, y: 1)
        bg.lightingBitMask = 0b0001
        Variables.scene.addChild(bg)
        
        for i in 0..<row
        {
            Variables.backarrays[col-1][i] = 2
//            Variables.scene.addChild(wall(x: i, y: col-1))
        }
        for i in 0..<col-1
        {
            Variables.backarrays[i][0] = 2
//            Variables.scene.addChild(wall(x: 0, y: i))
        }
        for i in 0..<col-1
        {
            Variables.backarrays[i][row-1] = 2
//            Variables.scene.addChild(wall(x: row-1, y: i))
        }
        for i in 0..<row
        {
            Variables.backarrays[0][i] = 2
//            Variables.scene.addChild(wall(x: i, y: 0))
        }
        lines()
    }
    
    // 새로운 테두리
    func lines()
    {
        let leftX = Int(Variables.startPoint.x) + (Variables.brickValue.brickSize / 2)
        let rightX = Variables.brickValue.brickSize * (row - 2) + leftX
        let topY = Int(Variables.startPoint.y) - (Variables.brickValue.brickSize / 2)
        let bottomY = Variables.brickValue.brickSize * (col - 1) + topY
        
        let leftline = SKSpriteNode()
        leftline.color = .darkGray
        leftline.anchorPoint = CGPoint(x: 0.5, y: 1)
        leftline.size = CGSize(width: 1, height: Variables.brickValue.brickSize * (col - 1))
        leftline.position = CGPoint(x: leftX, y: -topY)
        Variables.scene.addChild(leftline)
        
        let rightline = SKSpriteNode()
        rightline.color = .darkGray
        rightline.anchorPoint = CGPoint(x: 0.5, y: 1)
        rightline.size = CGSize(width: 1, height: Variables.brickValue.brickSize * (col - 1))
        rightline.position = CGPoint(x: rightX, y: -topY)
        Variables.scene.addChild(rightline)
        
        let bottomLine = SKSpriteNode()
        bottomLine.color = .darkGray
        bottomLine.anchorPoint = CGPoint(x: 0, y: 0.5)
        bottomLine.size = CGSize(width: rightX - leftX, height: 1)
        bottomLine.position = CGPoint(x: leftX, y: -bottomY)
        Variables.scene.addChild(bottomLine)
        
        let topLine = SKSpriteNode()
        topLine.color = .darkGray
        topLine.anchorPoint = CGPoint(x: 0, y: 0.5)
        topLine.size = CGSize(width: rightX - leftX, height: 1)
        topLine.position = CGPoint(x: leftX, y: -topY)
        Variables.scene.addChild(topLine)
    }
    
    // 테두리 벽을 폰 화면에 보이도록 ( 구 테두리 )
//    func wall(x: Int, y: Int) -> SKSpriteNode
//    {
//        let brick = SKSpriteNode()
//        brick.size = CGSize(width: brickSize - gab, height: brickSize - gab)
//        brick.color = .blue
//        brick.name = "wall"
//        brick.zPosition = 1
//
//        let xValue = x * brickSize + Int(Variables.startPoint.x)
//        let yValue = y * brickSize + Int(Variables.startPoint.y)
//        brick.position = CGPoint(x: xValue, y: -yValue)
//        return brick
//    }
}
