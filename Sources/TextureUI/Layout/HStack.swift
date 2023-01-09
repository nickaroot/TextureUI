//
//  HStack.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct HStack<Content>
where Content: LayoutElement {
    
    public var layoutElement: ASLayoutElement

    public init(
        spacing: CGFloat = 0,
        justifyContent: ASStackLayoutJustifyContent = .start,
        alignItems: ASStackLayoutAlignItems = .stretch,
        flexWrap: ASStackLayoutFlexWrap = .noWrap,
        alignContent: ASStackLayoutAlignContent = .start,
        lineSpacing: CGFloat = 0,
        isConcurrent: Bool = false,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: spacing,
            justifyContent: justifyContent,
            alignItems: alignItems,
            flexWrap: flexWrap,
            alignContent: alignContent,
            lineSpacing: lineSpacing,
            children: content().node.elements
        )
    }

    public init(
        content: Content,
        spacing: CGFloat = 0,
        justifyContent: ASStackLayoutJustifyContent = .start,
        alignItems: ASStackLayoutAlignItems = .stretch,
        flexWrap: ASStackLayoutFlexWrap = .noWrap,
        alignContent: ASStackLayoutAlignContent = .start,
        lineSpacing: CGFloat = 0,
        isConcurrent: Bool = false
    ) {
        self.layoutElement = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: spacing,
            justifyContent: justifyContent,
            alignItems: alignItems,
            flexWrap: flexWrap,
            alignContent: alignContent,
            lineSpacing: lineSpacing,
            children: content.node.elements
        )
    }
}

extension HStack: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [
            layoutElement
        ]
            .lazy
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
