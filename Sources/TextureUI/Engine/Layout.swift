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
            return ASLayoutSpec().node

        case .single(let element, _):
            return element.node

        case .composite(let elements, _):
            return elements.flatMap({ $0.node.elements }).lazy

        }
    }
    
    public var layoutElement: ASLayoutElement {
        switch self {
        case .empty(let style):
            return ASLayoutSpec()
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
            element.style.width = style.width
            element.style.height = style.height
            element.style.minHeight = style.minHeight
            element.style.maxHeight = style.maxHeight
            element.style.minWidth = style.minWidth
            element.style.maxWidth = style.maxWidth
            element.style.preferredSize = style.preferredSize
            element.style.preferredLayoutSize = style.preferredLayoutSize
            element.style.minLayoutSize = style.minLayoutSize
            element.style.maxLayoutSize = style.maxLayoutSize
            element.style.spacingBefore = style.spacingBefore
            element.style.spacingAfter = style.spacingAfter
            element.style.flexGrow = style.flexGrow
            element.style.flexShrink = style.flexShrink
            element.style.flexBasis = style.flexBasis
            element.style.alignSelf = style.alignSelf
            element.style.ascender = style.ascender
            element.style.descender = style.descender
            element.style.layoutPosition = style.layoutPosition
            
            return element.layoutElement
            
        case .composite(let elements, let style):
            return ASWrapperLayoutSpec(
                layoutElements: elements.map { $0.layoutElement }
            )
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
            return style
            
        case .single(_, let style):
            return style
            
        case .composite(_, let style):
            return style
        }
    }
}

extension Sequence where Element == Layout {
    public var dropEmpty: [Layout] {
        filter { layout in
            if case .empty = layout {
                return false
            } else {
                return true
            }
        }
    }
}
