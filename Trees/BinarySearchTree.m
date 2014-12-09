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
}

- (Node*)recursivelyFindNodeForKey:(NSString*)key withCurrentNode:(Node*)current
{
}

// http://en.wikipedia.org/wiki/Binary_search_tree#Deletion

- (void)recursivelyDeleteNode:(Node*)nodeToRemove
{
    // First Case - Deleting a leaf node (node has no children)
    if (!nodeToRemove.left && !nodeToRemove.right)
    {
    }
    
    // Second Case - Node has one subtree (node has only one child)
    else if (!nodeToRemove.right != !nodeToRemove.left)  // This is a logical exclusive or (XOR), the ! coerces the pointers into BOOLs
    {
    }
    
    // Third Case - Node has two subtrees (node has two children)
    else
    {
    }

}

- (NSUInteger)recursivelyCountSubtreeWithCurrentNode:(Node*)current
{
}



@end
