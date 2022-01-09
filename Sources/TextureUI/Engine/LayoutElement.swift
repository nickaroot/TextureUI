//
//  LayoutElement.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public protocol LayoutElement {
    var node: LazySequence<[ASLayoutElement]> { get }

    var layoutElement: ASLayoutElement { get }

    var style: ASLayoutElementStyle { get }
}

extension LayoutElement {
    public var layoutElement: ASLayoutElement {
        let layoutElements = node

        guard layoutElements.count == 1, let layoutElement = layoutElements.first else {
            return ASWrapperLayoutSpec(layoutElements: layoutElements.elements)
        }

        return layoutElement
    }

    public var layoutElements: [ASLayoutElement] {
        let layoutElements = node

        guard layoutElements.count == 1, let layoutElement = layoutElements.first else {
            return layoutElements.elements
        }

        return [layoutElement]
    }

    public var style: ASLayoutElementStyle {
        guard let styleable = self as? StyleableLayout else {
            return layoutElement.style
        }

        return styleable.style
    }
}

extension ASLayoutSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [self].lazy
    }
}

extension ASDisplayNode: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [self].lazy
    }
}

extension Optional: LayoutElement where Wrapped: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        self.map { $0.node } ?? ASLayoutSpec().node
    }

    public var style: ASLayoutElementStyle {
        guard let styleable = self as? StyleableLayout else {
            return layoutElement.style
        }
        return styleable.style
    }
}

extension Optional where Wrapped: LayoutElement & ASLayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [self].compactMap { $0 }.lazy
    }
}

extension Array: LayoutElement where Element: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        self.map { $0.layoutElement }.lazy
    }

    public var style: ASLayoutElementStyle {
        guard let styleable = self as? StyleableLayout else {
            return layoutElement.style
        }
        return styleable.style
    }
}

extension Array where Element: Sequence & LayoutElement & ASLayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        self.lazy.flatMap { $0 }.lazy
    }
}
