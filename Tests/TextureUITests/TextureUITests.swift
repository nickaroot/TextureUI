import XCTest
@testable import TextureUI

final class TextureUITests: XCTestCase {
    func buildEmptyBlockTest() -> ASLayoutSpec {
        LayoutSpec { }
    }
    
    func buildBlockWithLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            Layout.single(ASDisplayNode())
        }
    }
    
    func buildBlockWithOptionalLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            Layout?.none
        }
    }
    
    func buildBlockWithLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            ASDisplayNode()
        }
    }
    
    func buildBlockWithOptionalLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            ASDisplayNode?.none
        }
    }
    
    func buildIfWithLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                Layout.single(ASDisplayNode())
            }
        }
    }
    
    func buildIfWithOptionalLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                Layout?.none
            }
        }
    }
    
    func buildIfWithLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                ASDisplayNode()
            }
        }
    }
    
    func buildIfWithOptionalLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                ASDisplayNode?.none
            }
        }
    }
    
    func buildIfElseWithLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                Layout.single(ASDisplayNode())
            } else {
                Layout.single(ASDisplayNode())
            }
        }
    }
    
    func buildIfElseWithOptionalLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                Layout?.none
            } else {
                Layout?.none
            }
        }
    }
    
    func buildIfElseWithLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                ASDisplayNode()
            } else {
                ASDisplayNode()
            }
        }
    }
    
    func buildIfElseWithOptionalLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            if Int.random(in: 0..<1) == 0 {
                ASDisplayNode?.none
            } else {
                ASDisplayNode?.none
            }
        }
    }
    
    func buildArrayOfLayoutsTest() -> ASLayoutSpec {
        LayoutSpec {
            [0..<100].map { _ in Layout.single(ASDisplayNode()) }
        }
    }
    
    func buildArrayOfOptionalLayoutsTest() -> ASLayoutSpec {
        LayoutSpec {
            [0..<100].map { _ in Layout?.none }
        }
    }
    
    func buildArrayOfLayoutElementsTest() -> ASLayoutSpec {
        LayoutSpec {
            [0..<100].map { _ in ASDisplayNode() }
        }
    }
    
    func buildArrayOfOptionalsLayoutElementsTest() -> ASLayoutSpec {
        LayoutSpec {
            [0..<100].map { _ in ASDisplayNode?.none }
        }
    }
    
    func buildExpressionWithLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            for layoutElement in [0..<100].map { _ in ASDisplayNode() } {
                layoutElement
            }
        }
    }
    
    func buildExpressionWithOptionalLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            for layoutElement in [0..<100].map { _ in ASDisplayNode?.none } {
                layoutElement
            }
        }
    }
    
    func buildExpressionWithLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            for layout in [0..<100].map { _ in Layout.single(ASDisplayNode()) } {
                layout
            }
        }
    }
    
    func buildExpressionWithOptionalLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            for layout in [0..<100].map { _ in Layout?.none } {
                layout
            }
        }
    }
    
    
    
    func buildLimitedAvailabilityWithLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            if #available(macOS 11.0, iOS 14.0, *) {
                Layout.single(ASDisplayNode())
            }
        }
    }
    
    func buildLimitedAvailabilityWithOptionalLayoutTest() -> ASLayoutSpec {
        LayoutSpec {
            if #available(macOS 11.0, iOS 14.0, *) {
                Layout?.none
            }
        }
    }
    
    func buildLimitedAvailabilityWithLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            if #available(macOS 11.0, iOS 14.0, *) {
                ASDisplayNode()
            }
        }
    }
    
    func buildLimitedAvailabilityWithOptionalLayoutElementTest() -> ASLayoutSpec {
        LayoutSpec {
            if #available(macOS 11.0, iOS 14.0, *) {
                ASDisplayNode?.none
            }
        }
    }
}
