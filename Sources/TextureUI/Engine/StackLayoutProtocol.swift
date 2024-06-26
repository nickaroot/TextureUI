//
//  StackLayoutProtocol.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public protocol StackLayoutProtocol {
    associatedtype Content

    var direction: ASStackLayoutDirection { get }
    var spacing: CGFloat { get }
    var justifyContent: ASStackLayoutJustifyContent { get }
    var alignItems: ASStackLayoutAlignItems { get }
    var flexWrap: ASStackLayoutFlexWrap { get }
    var alignContent: ASStackLayoutAlignContent { get }
    var lineSpacing: CGFloat { get }
    var isConcurrent: Bool { get }
    var content: Content { get }

    init(
        spacing: CGFloat,
        justifyContent: ASStackLayoutJustifyContent,
        alignItems: ASStackLayoutAlignItems,
        flexWrap: ASStackLayoutFlexWrap,
        alignContent: ASStackLayoutAlignContent,
        lineSpacing: CGFloat,
        isConcurrent: Bool,
        @LayoutSpecBuilder _ content: () -> Content
    )

    init(
        content: Content,
        spacing: CGFloat,
        justifyContent: ASStackLayoutJustifyContent,
        alignItems: ASStackLayoutAlignItems,
        flexWrap: ASStackLayoutFlexWrap,
        alignContent: ASStackLayoutAlignContent,
        lineSpacing: CGFloat,
        isConcurrent: Bool
    )
}

extension StackLayoutProtocol where Self: StyleableLayout, Content: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [
            ASStackLayoutSpec(
                direction: direction,
                spacing: spacing,
                justifyContent: justifyContent,
                alignItems: alignItems,
                flexWrap: flexWrap,
                alignContent: alignContent,
                lineSpacing: lineSpacing,
                children: content.node.elements
            )
            .styled({ style in
                style.width = self.style.width
                style.height = self.style.height
                style.minHeight = self.style.minHeight
                style.maxHeight = self.style.maxHeight
                style.minWidth = self.style.minWidth
                style.maxWidth = self.style.maxWidth
                style.preferredSize = self.style.preferredSize
                style.preferredLayoutSize = self.style.preferredLayoutSize
                style.minLayoutSize = self.style.minLayoutSize
                style.maxLayoutSize = self.style.maxLayoutSize
                style.spacingBefore = self.style.spacingBefore
                style.spacingAfter = self.style.spacingAfter
                style.flexGrow = self.style.flexGrow
                style.flexShrink = self.style.flexShrink
                style.flexBasis = self.style.flexBasis
                style.alignSelf = self.style.alignSelf
                style.ascender = self.style.ascender
                style.descender = self.style.descender
                style.layoutPosition = self.style.layoutPosition
            })
        ]
        .lazy
    }
    
    public var layoutElement: ASLayoutElement {
        ASStackLayoutSpec(
            direction: direction,
            spacing: spacing,
            justifyContent: justifyContent,
            alignItems: alignItems,
            flexWrap: flexWrap,
            alignContent: alignContent,
            lineSpacing: lineSpacing,
            children: content.node.elements
        )
        .styled({ style in
            style.width = self.style.width
            style.height = self.style.height
            style.minHeight = self.style.minHeight
            style.maxHeight = self.style.maxHeight
            style.minWidth = self.style.minWidth
            style.maxWidth = self.style.maxWidth
            style.preferredSize = self.style.preferredSize
            style.preferredLayoutSize = self.style.preferredLayoutSize
            style.minLayoutSize = self.style.minLayoutSize
            style.maxLayoutSize = self.style.maxLayoutSize
            style.spacingBefore = self.style.spacingBefore
            style.spacingAfter = self.style.spacingAfter
            style.flexGrow = self.style.flexGrow
            style.flexShrink = self.style.flexShrink
            style.flexBasis = self.style.flexBasis
            style.alignSelf = self.style.alignSelf
            style.ascender = self.style.ascender
            style.descender = self.style.descender
            style.layoutPosition = self.style.layoutPosition
        })
    }
}
