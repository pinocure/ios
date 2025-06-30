import Foundation
import SpriteKit

class Brick
{
    struct Bricks
    {
        var color = UIColor()
        var points = Array<CGPoint>()
        let brickSize = 35
        let zPosition = CGFloat(1)
        var brickName = String()
    }
    
    func bricks() -> Bricks
    {
        var bricks = [Bricks]()
        
        var brick1 = [CGPoint]()                    //   mmm
        brick1.append(CGPoint(x: 0, y: 0))          //    m
        brick1.append(CGPoint(x: 1, y: 0))          //      위 모양의 블럭 생성 후 추가
        brick1.append(CGPoint(x: -1, y: 0))
        brick1.append(CGPoint(x: 0, y: 1))
        bricks.append(Bricks(color: .red, points: brick1, brickName: "brick1"))
        
        var brick2 = [CGPoint]()
        brick2.append(CGPoint(x: -1, y: 0))         //   mmmm
        brick2.append(CGPoint(x: 0, y: 0))          //       직선 모양을 블럭 생성 후 추가
        brick2.append(CGPoint(x: 1, y: 0))
        brick2.append(CGPoint(x: 2, y: 0))
        bricks.append(Bricks(color: .cyan, points: brick2, brickName: "brick2"))
        
        var brick3 = [CGPoint]()
        brick3.append(CGPoint(x: 0, y: 0))          //   mm
        brick3.append(CGPoint(x: 1, y: 0))          //  mm      총 모양 블럭 추가
        brick3.append(CGPoint(x: 0, y: 1))
        brick3.append(CGPoint(x: -1, y: 1))
        bricks.append(Bricks(color: .green, points: brick3, brickName: "brick3"))
        
        var brick4 = [CGPoint]()
        brick4.append(CGPoint(x: -1, y: 1))         //   mmm
        brick4.append(CGPoint(x: -1, y: 0))         //   m     저격총모양 블럭 생성 후 추가
        brick4.append(CGPoint(x: 0, y: 0))
        brick4.append(CGPoint(x: 1, y: 0))
        bricks.append(Bricks(color: .purple, points: brick4, brickName: "brick4"))
        
        var brick5 = [CGPoint]()
        brick5.append(CGPoint(x: 1, y: 0))          //   mm
        brick5.append(CGPoint(x: 0, y: 0))          //   mm    정사각형 블럭 생성 후 추가
        brick5.append(CGPoint(x: 0, y: 1))
        brick5.append(CGPoint(x: 1, y: 1))
        bricks.append(Bricks(color: .orange, points: brick5, brickName: "brick5"))
        
        var brick6 = [CGPoint]()
        brick6.append(CGPoint(x: 1, y: 0))         //   mmm
        brick6.append(CGPoint(x: 0, y: 0))         //     m  뒤집힌 저격총모양 블럭 생성 후 추가
        brick6.append(CGPoint(x: 0, y: 1))
        brick6.append(CGPoint(x: 1, y: 1))
        bricks.append(Bricks(color: .purple, points: brick6, brickName: "brick6"))
        
        var brick7 = [CGPoint]()
        brick7.append(CGPoint(x: 0, y: 0))          //   mm
        brick7.append(CGPoint(x: -1, y: 0))         //    mm    뒤집힌 총 모양 생성 후 추가
        brick7.append(CGPoint(x: 0, y: 1))
        brick7.append(CGPoint(x: 1, y: 1))
        bricks.append(Bricks(color: .systemPink, points: brick7, brickName: "brick7"))
        
        let random = Int.random(in: 0..<7)
        return bricks[random]
    }
}
