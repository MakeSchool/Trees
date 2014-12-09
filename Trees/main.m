//
//  main.m
//  Trees
//
//  Created by Daniel Haaser on 12/8/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinarySearchTree.h"
#import "Person.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static const NSInteger kPersonCount = 10000;

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        BinarySearchTree* binarySearchTree = [BinarySearchTree new];
        NSMutableArray* persons = [NSMutableArray arrayWithCapacity:kPersonCount];
        
        for (NSInteger i = 0; i < kPersonCount; ++i)
        {
            [persons addObject:[Person randomPerson]];
        }
        
        // Fill BST with people, benchmark the speed
        uint64_t creationTime = dispatch_benchmark(1, ^
        {
            for (NSInteger i = 0; i < kPersonCount; ++i)
            {
                Person* person = persons[i];
                NSString* key = [person description];
                [binarySearchTree addObject:person forKey:key];
            }
        });
        
        
        NSLog(@"Binary Search Tree filled in %llu ms", creationTime / 1000000);
        
        
        // Check the hashtable content, benchmark the speed
        
        __block BOOL retreivalSuccessfull = YES;
        
        uint64_t retrievalTime = dispatch_benchmark(3, ^
        {
            for (NSInteger i = 0; i < kPersonCount; i++)
            {
                Person* person = persons[i];
                NSString* key = [person description];
                
                Person* retrievedPerson = (Person*) [binarySearchTree objectForKey:key];
                
                if (person != retrievedPerson)
                {
                    NSLog(@"ERROR: Retrieved person doesn't match the expected result!");
                    retreivalSuccessfull = NO;
                    break;
                }
            }
        });
        
        if (retreivalSuccessfull)
        {
            NSLog(@"Successfully retrieved objects from binary search tree in %llu ms", retrievalTime / 1000000);
        }
        else
        {
            return 1;
        }
        
        __block NSUInteger count = 0;
        
        uint64_t countTime = dispatch_benchmark(3, ^
        {
            count = [binarySearchTree count];
        });
        
        if (count == kPersonCount)
        {
            NSLog(@"Count was correct and ran in %llu ms", countTime / 1000000);
        }
        else
        {
            NSLog(@"ERROR! Count did not match expected result!");
            return 1;
        }
        
        NSUInteger itemsToDelete = kPersonCount;
        
        uint64_t deleteTime = dispatch_benchmark(1, ^
        {
            for (NSUInteger i = 0; i < itemsToDelete; ++i)
            {
                NSUInteger index = arc4random() % persons.count;
                
                Person* personToDelete = persons[index];
                [persons removeObjectAtIndex:index];
                
                NSString* key = [personToDelete description];
                
                [binarySearchTree removeObjectForKey:key];
            }
        });
        
        NSUInteger postDeleteCount = [binarySearchTree count];
        
        if (postDeleteCount == kPersonCount - itemsToDelete)
        {
            NSLog(@"Deletion seems to have worked in %llu ms", deleteTime / 1000000);
        }
        else
        {
            NSLog(@"Deleting stuff has gone horribly wrong.  Disaster.");
        }

    }
                                                   
    return 0;
}