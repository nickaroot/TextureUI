//
//  HStack.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct HStack<Content>: StackLayoutProtocol, LayoutElement, StyleableLayout
where Content: LayoutElement {
    public let direction: ASStackLayoutDirection = .horizontal
    public let spacing: CGFloat
    public let justifyContent: ASStackLayoutJustifyContent
    public let alignItems: ASStackLayoutAlignItems
    public let flexWrap: ASStackLayoutFlexWrap
    public let alignContent: ASStackLayoutAlignContent
    public let lineSpacing: CGFloat
    public let isConcurrent: Bool

    public let content: Content

    public var style: ASLayoutElementStyle = ASLayoutElementStyle()

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
        self.spacing = spacing
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.flexWrap = flexWrap
        self.alignContent = alignContent
        self.lineSpacing = lineSpacing
        self.isConcurrent = isConcurrent
        self.content = content()
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
        self.spacing = spacing
        self.justifyContent = justifyContent
        self.alignItems = alignItems
        self.flexWrap = flexWrap
        self.alignContent = alignContent
        self.lineSpacing = lineSpacing
        self.isConcurrent = isConcurrent
        self.content = content
    }
}
