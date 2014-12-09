//
//  Node.h
//  Trees
//
//  Created by Daniel Haaser on 12/8/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, copy) NSString* key;
@property (nonatomic, strong) id data;

@property (nonatomic, strong) Node* left;
@property (nonatomic, strong) Node* right;
@property (nonatomic, weak) Node* parent;

@end
