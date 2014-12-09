//
//  BinarySearchTree.m
//  Trees
//
//  Created by Daniel Haaser on 12/8/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "BinarySearchTree.h"
#import "Node.h"

@interface BinarySearchTree ()

@property (nonatomic, strong) Node* rootNode;

@end


@implementation BinarySearchTree

- (id)objectForKey:(NSString *)key
{
    Node* node = [self recursivelyFindNodeForKey:key withCurrentNode:self.rootNode];
    
    if (node)
    {
        return node.data;
    }
    else
    {
        return nil;
    }
}

- (void)addObject:(id)object forKey:(NSString *)key
{
    Node* newNode = [Node new];
    newNode.data = object;
    newNode.key = key;
    
    if (!self.rootNode)
    {
        newNode.parent = nil;
        self.rootNode = newNode;
    }
    else
    {
        [self recursivelyAddNode:newNode withCurrentNode:self.rootNode];
    }
}

- (NSUInteger)count
{
    return [self recursivelyCountSubtreeWithCurrentNode:self.rootNode];
}

@end
