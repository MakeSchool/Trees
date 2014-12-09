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
        [self recursivelyDeleteNode:nodeToRemove];
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

// http://en.wikipedia.org/wiki/Binary_search_tree#Deletion

- (void)recursivelyDeleteNode:(Node*)nodeToRemove
{
    BOOL rootNodeGettingDeleted = nodeToRemove == self.rootNode;
    
    // First Case - Deleting a leaf node (node has no children)
    if (!nodeToRemove.left && !nodeToRemove.right)
    {
        Node* parent = nodeToRemove.parent;
        
        if (parent.left == nodeToRemove)
        {
            parent.left = nil;
        }
        else if (parent.right == nodeToRemove)
        {
            parent.right = nil;
        }
        else if (rootNodeGettingDeleted)
        {
            self.rootNode = nil;
        }
    }
    
    // Second Case - Node has one subtree (node has only one child)
    else if (!nodeToRemove.right != !nodeToRemove.left)  // This is a logical exclusive or (XOR), the ! coerces the pointers into BOOLs
    {
        Node* parent = nodeToRemove.parent;
        Node* child;
        
        if (nodeToRemove.left)
        {
            child = nodeToRemove.left;
        }
        else
        {
            child = nodeToRemove.right;
        }
        
        if (parent.left == nodeToRemove)
        {
            parent.left = child;
        }
        else if (parent.right == nodeToRemove)
        {
            parent.right = child;
        }
        else if (rootNodeGettingDeleted)
        {
            self.rootNode = child;
        }
        
        child.parent = parent;
    }
    
    // Third Case - Node has two subtrees (node has two children)
    else
    {
        // Grab the value from the in-order predecessor (left subtree's rightmost (largest) child)
        Node* inOrderPredecessor = nodeToRemove.left;
        
        while (inOrderPredecessor.right)
        {
            inOrderPredecessor = inOrderPredecessor.right;
        }
        
        // Set the node we're removing's value to the in-order predecessor's value
        nodeToRemove.data = inOrderPredecessor.data;
        nodeToRemove.key = inOrderPredecessor.key;
        
        // Recursively delete the in-order predecessor
        [self recursivelyDeleteNode:inOrderPredecessor];
    }
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

- (void)recursivelyLogTree:(Node*)current
{
    if (current)
    {
        NSLog(@"%@", current.key);
        [self recursivelyLogTree:current.left];
        [self recursivelyLogTree:current.right];
    }
}



@end
