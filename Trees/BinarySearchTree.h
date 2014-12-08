//
//  BinarySearchTree.h
//  Trees
//
//  Created by Daniel Haaser on 12/8/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinarySearchTree : NSObject

// --------------------------------------
//         Normal Tree Operations
// --------------------------------------

/**
 Searches the binary search tree, returning the object if it's found
 Returns nil if the object is not in the tree
 */
- (id)objectForKey:(NSString*)key;

/**
 Add an object to the tree for the given key
 */
- (void)addObject:(id)object forKey:(NSString*)key;

/**
 Delete the object from the tree for the given key
 */
- (void)removeObjectForKey:(NSString*)key;

/**
 Returns the number of objects stored in the BST
 */
- (NSUInteger)count;


// --------------------------------------
//          Implement These!
// --------------------------------------


@end
