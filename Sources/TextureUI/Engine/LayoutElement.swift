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

extension ASLayoutSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [self].lazy
    }

    public var layoutElement: ASLayoutElement {
        self
    }
}

extension ASDisplayNode: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [self].lazy
    }

    public var layoutElement: ASLayoutElement {
        self
    }
}

extension Optional: LayoutElement where Wrapped: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        self.map { $0.node } ?? ASLayoutSpec().node
    }

    public var layoutElement: ASLayoutElement {
        self.map { $0.layoutElement } ?? ASLayoutSpec()
    }

    public var style: ASLayoutElementStyle {
        layoutElement.style
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

    public var layoutElement: ASLayoutElement {
        ASWrapperLayoutSpec(layoutElements: self.map { $0.layoutElement })
    }

    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}

extension Array where Element: Sequence & LayoutElement & ASLayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        self.lazy.flatMap { $0 }.lazy
    }
}
