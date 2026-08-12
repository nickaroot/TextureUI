import XCTest
import AsyncDisplayKit
@testable import TextureUI

final class CharacterizationTests: XCTestCase {

    private func makeStyledNode() -> ASDisplayNode {
        let node = ASDisplayNode()
        node.style.flexGrow = 3
        node.style.flexShrink = 4
        node.style.spacingBefore = 5
        node.style.spacingAfter = 6
        node.style.alignSelf = .center
        node.style.width = ASDimensionMake(77)
        node.style.height = ASDimensionMake(88)
        node.style.minWidth = ASDimensionMake(10)
        node.style.maxWidth = ASDimensionMake(999)
        node.style.ascender = 9
        node.style.descender = -9
        return node
    }

    private func snapshot(_ style: ASLayoutElementStyle) -> [String: CGFloat] {
        [
            "flexGrow": style.flexGrow,
            "flexShrink": style.flexShrink,
            "spacingBefore": style.spacingBefore,
            "spacingAfter": style.spacingAfter,
            "alignSelf": CGFloat(style.alignSelf.rawValue),
            "width": style.width.value,
            "height": style.height.value,
            "minWidth": style.minWidth.value,
            "maxWidth": style.maxWidth.value,
            "ascender": style.ascender,
            "descender": style.descender,
        ]
    }

    func testXCTestActuallyDiscoversTestsInThisTarget() {
        XCTAssertTrue(true)
    }

    func testStackContainersPreserveChildStyle() {
        for (name, make) in Self.nodePathContainers {
            let node = makeStyledNode()
            _ = make(node)
            XCTAssertEqual(node.style.flexGrow, 3, accuracy: 0.001, "\(name) flexGrow")
            XCTAssertEqual(node.style.spacingBefore, 5, accuracy: 0.001, "\(name) spacingBefore")
        }
    }

    func testSingleChildSpecsPreserveChildStyle() {
        for (name, make) in Self.layoutElementPathContainers {
            let node = makeStyledNode()
            XCTAssertEqual(node.style.flexGrow, 3, "\(name) precondition")

            _ = make(node)

            let after = snapshot(node.style)
            XCTAssertEqual(after["flexGrow"], 3, "\(name) flexGrow")
            XCTAssertEqual(after["flexShrink"], 4, "\(name) flexShrink")
            XCTAssertEqual(after["spacingBefore"], 5, "\(name) spacingBefore")
            XCTAssertEqual(after["alignSelf"], CGFloat(ASStackLayoutAlignSelf.center.rawValue),
                           "\(name) alignSelf")
            XCTAssertEqual(after["width"], 77, "\(name) width")
            XCTAssertEqual(after["ascender"], 9, "\(name) ascender")
        }
    }

    func testModifierFormDoesNotEraseStyle() {
        let node = makeStyledNode()
        _ = node.padding(8)
        XCTAssertEqual(node.style.flexGrow, 3, accuracy: 0.001)

        let node2 = makeStyledNode()
        _ = node2.aspectRatio(1.5)
        XCTAssertEqual(node2.style.flexGrow, 3, accuracy: 0.001)
    }

    func testNestedPaddingIsNotInflated() {
        let node = ASDisplayNode()
        let padded = node.padding(8).padding(4)

        guard let outer = padded.layoutElement as? ASInsetLayoutSpec else {
            return XCTFail("expected ASInsetLayoutSpec, got \(type(of: padded.layoutElement))")
        }
        let outerTop = outer.insets.top
        let innerTop = (outer.child as? ASInsetLayoutSpec)?.insets.top

        XCTAssertEqual(outerTop, 4, accuracy: 0.001)
        XCTAssertEqual(innerTop ?? -1, 8, accuracy: 0.001)
        XCTAssertEqual(outerTop + (innerTop ?? 0), 12, accuracy: 0.001)
    }

    func testStyleLeaksBetweenLayoutPasses_BUG() {
        let node = ASDisplayNode()

        var highlighted = true
        _ = LayoutSpec { highlighted ? node.flexGrow(1) : node.flexGrow(0) }
        XCTAssertEqual(node.style.flexGrow, 1, accuracy: 0.001)

        highlighted = false
        _ = LayoutSpec { node }
        XCTAssertEqual(node.style.flexGrow, 1, accuracy: 0.001)
    }

    func testStackAllocatesSpecEagerlyInInit_BUG() {
        let stack = HStack { ASDisplayNode() }
        XCTAssertTrue(stack.layoutElement is ASStackLayoutSpec)
    }

    func testHStackFlexGrowGeometryBaseline() {
        let a = ASDisplayNode()
        let b = ASDisplayNode()
        b.style.width = ASDimensionMake(50)
        b.style.height = ASDimensionMake(40)
        a.style.height = ASDimensionMake(40)
        a.style.flexGrow = 1

        let spec = LayoutSpec { HStack { a; b } }
        let maxSize = CGSize(width: 320, height: CGFloat.greatestFiniteMagnitude)
        let layout = spec.layoutThatFits(ASSizeRangeMake(CGSize(width: 320, height: 0), maxSize))

        guard let stackLayout = layout.sublayouts.first else {
            return XCTFail("expected nested stack layout")
        }
        let frames = stackLayout.sublayouts.map { $0.frame }
        XCTAssertEqual(frames.count, 2)
        XCTAssertEqual(frames[0].width, 270, accuracy: 0.5)
        XCTAssertEqual(frames[1].minX, 270, accuracy: 0.5)
    }

    func testNilOptionalWithModifierDropsFromStack() {
        let missing: ASDisplayNode? = nil

        let a = ASDisplayNode()
        a.style.preferredSize = CGSize(width: 50, height: 40)
        let b = ASDisplayNode()
        b.style.preferredSize = CGSize(width: 50, height: 40)

        let withModifier = LayoutSpec {
            HStack(spacing: 8) {
                a
                missing.flexGrow(1)
                b
            }
        }

        let sizeRange = ASSizeRangeMake(
            CGSize(width: 0, height: 0),
            CGSize(width: 320, height: 400)
        )

        guard let stack1 = withModifier.layoutThatFits(sizeRange).sublayouts.first else {
            return XCTFail("expected stack layout")
        }
        XCTAssertEqual(stack1.sublayouts.count, 2)
        XCTAssertEqual(stack1.sublayouts[1].frame.minX, 58, accuracy: 0.5)

        let c = ASDisplayNode()
        c.style.preferredSize = CGSize(width: 50, height: 40)
        let d = ASDisplayNode()
        d.style.preferredSize = CGSize(width: 50, height: 40)

        let bare = LayoutSpec {
            HStack(spacing: 8) {
                c
                missing
                d
            }
        }
        guard let stack2 = bare.layoutThatFits(sizeRange).sublayouts.first else {
            return XCTFail("expected stack layout")
        }
        XCTAssertEqual(stack2.sublayouts.count, 2)
        XCTAssertEqual(stack2.sublayouts[1].frame.minX, 58, accuracy: 0.5)
    }

    func testNilOptionalInArrayDropsFromStack() {
        let a = ASDisplayNode()
        a.style.preferredSize = CGSize(width: 50, height: 40)
        let maybeB: ASDisplayNode? = nil
        let c = ASDisplayNode()
        c.style.preferredSize = CGSize(width: 50, height: 40)

        let spec = LayoutSpec {
            VStack(spacing: 8) {
                [a, maybeB, c]
            }
        }
        let layout = spec.layoutThatFits(
            ASSizeRangeMake(CGSize(width: 0, height: 0), CGSize(width: 320, height: 400))
        )
        guard let stack = layout.sublayouts.first else {
            return XCTFail("expected stack layout")
        }
        XCTAssertEqual(stack.sublayouts.count, 2)
        XCTAssertEqual(stack.sublayouts[1].frame.minY, 48, accuracy: 0.5)
    }

    func testDuplicateModifierInnermostWins_BUG() {
        let node = ASDisplayNode()
        let chained = node.flexGrow(1).flexGrow(2)

        _ = chained.layoutElement

        XCTAssertEqual(node.style.flexGrow, 1, accuracy: 0.001)
    }

    func testModifierIsDeferredSideEffect_BUG() {
        let node = ASDisplayNode()
        let el = node.flexGrow(1)

        XCTAssertEqual(node.style.flexGrow, 0, accuracy: 0.001)

        _ = el.layoutElement

        XCTAssertEqual(node.style.flexGrow, 1, accuracy: 0.001)
    }

    func testArrayStyleModifierIsSilentNoOp_BUG() {
        let a = ASDisplayNode()
        let b = ASDisplayNode()

        let modified = [a, b].flexGrow(1)
        _ = modified.layoutElement

        XCTAssertEqual(a.style.flexGrow, 0, accuracy: 0.001)
        XCTAssertEqual(b.style.flexGrow, 0, accuracy: 0.001)
        XCTAssertEqual(modified.style.flexGrow, 0, accuracy: 0.001)
    }

    func testPaddingWithoutLengthIsNoOp_BUG() {
        let node = ASDisplayNode()

        guard let inset = node.padding().layoutElement as? ASInsetLayoutSpec else {
            return XCTFail("expected ASInsetLayoutSpec")
        }
        XCTAssertEqual(inset.insets, .zero)

        guard let horizontal = node.padding(.horizontal).layoutElement as? ASInsetLayoutSpec else {
            return XCTFail("expected ASInsetLayoutSpec")
        }
        XCTAssertEqual(horizontal.insets, .zero)
    }

    func testZStackPreservesPreferredSizeStillPinsTopLeft() {
        let big = ASDisplayNode()
        big.style.preferredSize = CGSize(width: 100, height: 100)
        let small = ASDisplayNode()
        small.style.preferredSize = CGSize(width: 20, height: 20)

        let spec = LayoutSpec {
            ZStack {
                big
                small
            }
        }
        let layout = spec.layoutThatFits(
            ASSizeRangeMake(CGSize(width: 0, height: 0), CGSize(width: 320, height: 320))
        )
        guard let z = layout.sublayouts.first, z.sublayouts.count == 2 else {
            return XCTFail("expected wrapper with two children")
        }
        XCTAssertEqual(z.sublayouts[1].frame.origin, CGPoint.zero)
        XCTAssertEqual(z.sublayouts[1].frame.width, 20, accuracy: 0.5)
        XCTAssertEqual(z.sublayouts[0].frame.width, 100, accuracy: 0.5)
        XCTAssertEqual(z.size.width, 100, accuracy: 0.5)
    }

    func testDecorationSlotPreservesStyle() {
        let overlayNode = makeStyledNode()
        let overlaySpec = OverlaySpec { ASDisplayNode() } overlay: { overlayNode }
        _ = overlaySpec.layoutElement
        XCTAssertEqual(overlayNode.style.flexGrow, 3, accuracy: 0.001)
        XCTAssertEqual(overlayNode.style.width.value, 77, accuracy: 0.001)

        let backgroundNode = makeStyledNode()
        let backgroundSpec = BackgroundSpec { ASDisplayNode() } background: { backgroundNode }
        _ = backgroundSpec.layoutElement
        XCTAssertEqual(backgroundNode.style.flexGrow, 3, accuracy: 0.001)
        XCTAssertEqual(backgroundNode.style.width.value, 77, accuracy: 0.001)
    }

    func testMultipleConsecutiveNilsDropFromStack() {
        let a = ASDisplayNode()
        a.style.preferredSize = CGSize(width: 50, height: 40)
        let n1: ASDisplayNode? = nil
        let n2: ASDisplayNode? = nil
        let c = ASDisplayNode()
        c.style.preferredSize = CGSize(width: 50, height: 40)

        let spec = LayoutSpec {
            VStack(spacing: 8) {
                [a, n1, n2, c]
            }
        }
        let layout = spec.layoutThatFits(
            ASSizeRangeMake(CGSize(width: 0, height: 0), CGSize(width: 320, height: 400))
        )
        guard let stack = layout.sublayouts.first else {
            return XCTFail("expected stack layout")
        }
        XCTAssertEqual(stack.sublayouts.count, 2)
        XCTAssertEqual(stack.sublayouts[1].frame.minY, 48, accuracy: 0.5)
    }

    func testAllNilArrayIsSafe() {
        let n1: ASDisplayNode? = nil
        let n2: ASDisplayNode? = nil

        let spec = LayoutSpec {
            VStack(spacing: 8) {
                [n1, n2]
            }
        }
        let layout = spec.layoutThatFits(
            ASSizeRangeMake(CGSize(width: 0, height: 0), CGSize(width: 320, height: 400))
        )
        guard let stack = layout.sublayouts.first else {
            return XCTFail("expected stack layout")
        }
        XCTAssertEqual(stack.sublayouts.count, 0)
    }

    static let nodePathContainers: [(String, (ASDisplayNode) -> ASLayoutElement)] = [
        ("HStack", { n in HStack { n }.layoutElement }),
        ("VStack", { n in VStack { n }.layoutElement }),
        ("LayoutSpec", { n in LayoutSpec { n } }),
    ]

    static let layoutElementPathContainers: [(String, (ASDisplayNode) -> ASLayoutElement)] = [
        ("ZStack", { n in ZStack { n }.layoutElement }),
        ("CenterSpec", { n in CenterSpec { n }.layoutElement }),
        ("InsetSpec", { n in InsetSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)) { n }.layoutElement }),
        ("OverlaySpec", { n in OverlaySpec(overlay: ASDisplayNode()) { n }.layoutElement }),
        ("AspectRatioSpec", { n in AspectRatioSpec(ratio: 1.0) { n }.layoutElement }),
        ("BackgroundSpec", { n in BackgroundSpec(background: ASDisplayNode()) { n }.layoutElement }),
    ]
}
