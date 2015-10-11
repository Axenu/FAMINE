//
//  mat4.h
//  FAM
//
//  Created by Simon Nilsson on 12/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

#ifndef mat4_h
#define mat4_h


#import <UIKit/UIKit.h>
#import <GLKit/GLKMath.h>

@interface mat4 : NSObject {
@public
    GLKMatrix4 glkMatrix;
}

+ (mat4 *)makePerspectiveViewAngle:(float)angle
                          aspectRatio:(float)aspect
                                nearZ:(float)near
                                 farZ:(float)far;

- (instancetype)init;
- (instancetype)initWithPerspectiveAngle:(float)angle
                             aspectRatio:(float)aspect
                                   nearPlane:(float)near
                                    farPlane:(float)far;
- (instancetype)copy;


- (void)scale:(float)x y:(float)y z:(float)z;
- (void)rotateAroundX:(float)xAngleRad y:(float)yAngleRad z:(float)zAngleRad;
- (void)translate:(float)x y:(float)y z:(float)z;
- (void)multiplyLeft:(mat4 *)matrix;


- (void *)raw;
- (void)transpose;

+ (float)degreesToRad:(float)degrees;
+ (NSInteger)numberOfElements;

@end

#endif