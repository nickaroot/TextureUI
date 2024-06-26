//
//  Layout.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public enum Layout {
    case empty(style: ASLayoutElementStyle)
    case single(_ content: LayoutElement, style: ASLayoutElementStyle)
    case composite(_ content: [LayoutElement], style: ASLayoutElementStyle)
    
    static var empty: Self {
        .empty(style: ASLayoutElementStyle())
    }
    
    static func single(_ content: LayoutElement) -> Self {
        .single(content, style: ASLayoutElementStyle())
    }
    
    static func composite(_ content: [LayoutElement]) -> Self {
        .composite(content, style: ASLayoutElementStyle())
    }
}

extension Layout: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        switch self {

        case .empty:
            ASLayoutSpec().node

        case .single(let element, _):
            element.node

        case .composite(let elements, _):
            elements.flatMap({ $0.node.elements }).lazy

        }
    }
    
    public var layoutElement: ASLayoutElement {
        switch self {
        case .empty(let style):
            ASLayoutSpec()
                .styled {
                    $0.width = style.width
                    $0.height = style.height
                    $0.minHeight = style.minHeight
                    $0.maxHeight = style.maxHeight
                    $0.minWidth = style.minWidth
                    $0.maxWidth = style.maxWidth
                    $0.preferredSize = style.preferredSize
                    $0.preferredLayoutSize = style.preferredLayoutSize
                    $0.minLayoutSize = style.minLayoutSize
                    $0.maxLayoutSize = style.maxLayoutSize
                    $0.spacingBefore = style.spacingBefore
                    $0.spacingAfter = style.spacingAfter
                    $0.flexGrow = style.flexGrow
                    $0.flexShrink = style.flexShrink
                    $0.flexBasis = style.flexBasis
                    $0.alignSelf = style.alignSelf
                    $0.ascender = style.ascender
                    $0.descender = style.descender
                    $0.layoutPosition = style.layoutPosition
                }
            
        case .single(let element, let style):
            (element.layoutElement as? ASLayoutElement & ASLayoutElementStylability)?
                .styled {
                    $0.width = style.width
                    $0.height = style.height
                    $0.minHeight = style.minHeight
                    $0.maxHeight = style.maxHeight
                    $0.minWidth = style.minWidth
                    $0.maxWidth = style.maxWidth
                    $0.preferredSize = style.preferredSize
                    $0.preferredLayoutSize = style.preferredLayoutSize
                    $0.minLayoutSize = style.minLayoutSize
                    $0.maxLayoutSize = style.maxLayoutSize
                    $0.spacingBefore = style.spacingBefore
                    $0.spacingAfter = style.spacingAfter
                    $0.flexGrow = style.flexGrow
                    $0.flexShrink = style.flexShrink
                    $0.flexBasis = style.flexBasis
                    $0.alignSelf = style.alignSelf
                    $0.ascender = style.ascender
                    $0.descender = style.descender
                    $0.layoutPosition = style.layoutPosition
                } ?? element.layoutElement
            
        case .composite(let elements, let style):
            ASWrapperLayoutSpec(layoutElements: elements.map(\.layoutElement))
                .styled {
                    $0.width = style.width
                    $0.height = style.height
                    $0.minHeight = style.minHeight
                    $0.maxHeight = style.maxHeight
                    $0.minWidth = style.minWidth
                    $0.maxWidth = style.maxWidth
                    $0.preferredSize = style.preferredSize
                    $0.preferredLayoutSize = style.preferredLayoutSize
                    $0.minLayoutSize = style.minLayoutSize
                    $0.maxLayoutSize = style.maxLayoutSize
                    $0.spacingBefore = style.spacingBefore
                    $0.spacingAfter = style.spacingAfter
                    $0.flexGrow = style.flexGrow
                    $0.flexShrink = style.flexShrink
                    $0.flexBasis = style.flexBasis
                    $0.alignSelf = style.alignSelf
                    $0.ascender = style.ascender
                    $0.descender = style.descender
                    $0.layoutPosition = style.layoutPosition
                }
        }
    }
    
    public var style: ASLayoutElementStyle {
        switch self {
        case .empty(let style):
            style
            
        case .single(_, let style):
            style
            
        case .composite(_, let style):
            style
        }
    }
}

extension Sequence where Element == Layout {
    public var dropEmpty: [Layout] {
        filter { layout in
            if case .empty = layout {
                false
            } else {
                true
            }
        }
    }
}
