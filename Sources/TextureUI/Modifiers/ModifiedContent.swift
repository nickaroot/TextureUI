//
//  ModifiedContent.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

@frozen
public struct ModifiedContent<Content, Modifier: LayoutModifier> {
    public var content: Content

    public var modifier: Modifier

    public init(
        content: Content,
        modifier: Modifier
    ) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedContent: LayoutElement where Modifier.Content == Content {
    public var node: LazySequence<[ASLayoutElement]> {
        modifier.modify(content: content).node
    }
    
    public var layoutElement: ASLayoutElement {
        modifier.modify(content: content).layoutElement
    }
    
    public var style: ASLayoutElementStyle {
        content.style
    }
}

extension LayoutElement {
    public func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
        ModifiedContent(content: self, modifier: modifier)
    }
}
