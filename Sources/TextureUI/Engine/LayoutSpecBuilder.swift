//
//  LayoutSpecBuilder.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

@resultBuilder
public struct LayoutSpecBuilder {
    public static func buildBlock() -> Layout {
        .empty
    }
    
    public static func buildBlock(_ layout: Layout...) -> Layout {
        .composite(layout)
    }
    
    public static func buildBlock(_ layout: Layout?...) -> Layout {
        let layouts = layout.compactMap { $0 }
        
        guard
            !layouts.isEmpty
        else {
            return .empty
        }
        
        if layouts.count == 1, let layout = layouts.first {
            return layout
        }
        
        return .composite(layouts)
    }
    
    public static func buildBlock<Content>(
        _ content: Content...
    ) -> Layout where Content: LayoutElement {
        .composite(content)
    }
    
    public static func buildBlock<Content>(
        _ content: Content?...
    ) -> Layout where Content: LayoutElement {
        let content = content.compactMap { $0 }
        
        guard
            !content.isEmpty
        else {
            return .empty
        }
        
        if content.count == 1, let content = content.first {
            return .single(content)
        }
        
        return .composite(content)
    }
    
    public static func buildOptional(_ layout: Layout?) -> Layout {
        guard
            let layout = layout
        else {
            return .empty
        }
        
        return layout
    }
    
    public static func buildOptional(_ content: (some LayoutElement)?) -> Layout {
        guard
            let content = content
        else {
            return .empty
        }
        
        return .single(content)
    }
    
    public static func buildEither(first layout: Layout) -> Layout {
        layout
    }
    
    public static func buildEither(first layout: Layout?) -> Layout {
        guard
            let layout = layout
        else {
            return .empty
        }
        
        return layout
    }
    
    public static func buildEither(second layout: Layout) -> Layout {
        layout
    }
    
    public static func buildEither(second layout: Layout?) -> Layout {
        guard
            let layout = layout
        else {
            return .empty
        }
        
        return layout
    }
    
    public static func buildEither(first content: some LayoutElement) -> Layout {
        .single(content)
    }
    
    public static func buildEither(first content: (some LayoutElement)?) -> Layout {
        guard
            let content = content
        else {
            return .empty
        }
        
        return .single(content)
    }
    
    public static func buildEither(second content: some LayoutElement) -> Layout {
        .single(content)
    }
    
    public static func buildEither(second content: (some LayoutElement)?) -> Layout {
        guard
            let content = content
        else {
            return .empty
        }
        
        return .single(content)
    }
    
    public static func buildArray(_ layout: [Layout]) -> Layout {
        if layout.count == 1, let layout = layout.first {
            return layout
        }
        
        return .composite(layout)
    }
    
    public static func buildArray(_ layout: [Layout?]) -> Layout {
        let layout = layout.compactMap { $0 }
        
        guard
            !layout.isEmpty
        else {
            return .empty
        }
        
        if layout.count == 1, let layout = layout.first {
            return layout
        }
        
        return .composite(layout)
    }
    
    public static func buildArray(_ content: [some LayoutElement]) -> Layout {
        if content.count == 1, let content = content.first {
            return .single(content)
        }
        
        return .composite(content)
    }
    
    public static func buildArray(_ content: [(some LayoutElement)?]) -> Layout {
        let content = content.compactMap { $0 }
        
        guard
            !content.isEmpty
        else {
            return .empty
        }
        
        if content.count == 1, let content = content.first {
            return .single(content)
        }
        
        return .composite(content)
    }
    
    public static func buildExpression(_ layout: Layout) -> Layout {
        layout
    }
    
    public static func buildExpression(_ layout: Layout?) -> Layout {
        guard
            let layout = layout
        else {
            return .empty
        }
        
        return layout
    }
    
    public static func buildExpression(_ content: some LayoutElement) -> Layout {
        .single(content)
    }
    
    public static func buildExpression(_ content: (some LayoutElement)?) -> Layout {
        guard
            let content = content
        else {
            return .empty
        }
        
        return .single(content)
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func buildLimitedAvailability(_ layout: Layout) -> Layout {
        layout
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func buildLimitedAvailability(_ layout: Layout?) -> Layout {
        guard
            let layout = layout
        else {
            return .empty
        }
        
        return layout
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func buildLimitedAvailability(_ content: some LayoutElement) -> Layout {
        .single(content)
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func buildLimitedAvailability(_ content: (some LayoutElement)?) -> Layout {
        guard
            let content = content
        else {
            return .empty
        }
        
        return .single(content)
    }
}
