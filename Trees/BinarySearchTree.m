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

- (void)removeObjectForKey:(NSString *)key
{
    Node* nodeToRemove = [self recursivelyFindNodeForKey:key withCurrentNode:self.rootNode];
    
    if (nodeToRemove)
    {
        // First Case - Deleting a leaf node (node has no children)
        if (!nodeToRemove.left && !nodeToRemove.right)
        {
#pragma message "implement this case!"
        }
        
        // Second Case - Node has one subtree (node has only one child)
        else if (!nodeToRemove.right != !nodeToRemove.left)  // This is a logical exclusive or (XOR), the ! coerces the pointers into BOOLs
        {
#pragma message "implement this case too!"
        }
        
        // Third Case - Node has two subtrees (node has two children)
        else
        {
#pragma message "you better believe you gotta implement this case!"
        }
    }
}

- (NSUInteger)count
{
    return [self recursivelyCountSubtreeWithCurrentNode:self.rootNode];
}


// --------------------------------------
//          Implement These!
// --------------------------------------


//  Add the node to it's proper place in the Binary Search Tree
//  Don't forget to assign the parent pointer!
- (void)recursivelyAddNode:(Node*)node withCurrentNode:(Node*)current
{
    NSComparisonResult comparisonResult = [current.key compare:node.key];
    
    if (comparisonResult == NSOrderedAscending)
    {
        if (current.left)
        {
            [self recursivelyAddNode:node withCurrentNode:current.left];
        }
        else
        {
            current.left = node;
            node.parent = current;
        }
    }
    else if (comparisonResult == NSOrderedDescending)
    {
        if (current.right)
        {
            [self recursivelyAddNode:node withCurrentNode:current.right];
        }
        else
        {
            current.right = node;
            node.parent = current;
        }
    }
    else
    {
        NSAssert(comparisonResult == NSOrderedSame, @"Object with key already added, cannot add again!");
    }
}

- (Node*)recursivelyFindNodeForKey:(NSString*)key withCurrentNode:(Node*)current
{
    if (current)
    {
        NSComparisonResult comparisonResult = [current.key compare:key];
        
        if (comparisonResult == NSOrderedAscending)
        {
            return [self recursivelyFindNodeForKey:key withCurrentNode:current.left];
        }
        else if (comparisonResult == NSOrderedDescending)
        {
            return [self recursivelyFindNodeForKey:key withCurrentNode:current.right];
        }
        else if (comparisonResult == NSOrderedSame)
        {
            return current;
        }
    }
    
    return nil;
}

- (NSUInteger)recursivelyCountSubtreeWithCurrentNode:(Node*)current
{
    if (current)
    {
        return 1 + [self recursivelyCountSubtreeWithCurrentNode:current.left] + [self recursivelyCountSubtreeWithCurrentNode:current.right];
    }
    else
    {
        return 0;
    }
}



@end
