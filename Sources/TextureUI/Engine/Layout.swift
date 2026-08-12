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
        case .empty:
            ASLayoutSpec()

        case .single(let element, _):
            element.layoutElement

        case .composite(let elements, _):
            ASWrapperLayoutSpec(layoutElements: elements.map(\.layoutElement))
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
