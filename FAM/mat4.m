//
//  mat4.m
//  FAM
//
//  Created by Simon Nilsson on 12/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

#import "mat4.h"
#import "FAM-Swift.h"

@implementation mat4

#pragma mark - Matrix creation

+ (mat4 *)makePerspectiveViewAngle:(float)angle
                          aspectRatio:(float)aspect
                                nearZ:(float)near
                                 farZ:(float)far{
    mat4 *matrix = [[mat4 alloc] init];
    matrix->glkMatrix = GLKMatrix4MakePerspective(angle, aspect, near, far);
    return matrix;
}

- (instancetype)init{
    self = [super init];
    if(self != nil){
        glkMatrix = GLKMatrix4Identity;
    }
    return self;
}

- (instancetype)initWithPerspectiveAngle:(float)angle
                             aspectRatio:(float)aspect
                               nearPlane:(float)near
                                farPlane:(float)far {
    self = [super init];
    if (self != nil){
        glkMatrix = GLKMatrix4MakePerspective(angle, aspect, near, far);
    }
    return self;
}

- (instancetype)copy{
    mat4 *mCopy = [[mat4 alloc] init];
    mCopy->glkMatrix = self->glkMatrix;
    return mCopy;
}

#pragma mark - Matrix transformation

- (void)scale:(float)x y:(float)y z:(float)z{
    glkMatrix = GLKMatrix4Scale(glkMatrix, x, y, z);
}

- (void)rotateAroundX:(float)xAngleRad y:(float)yAngleRad z:(float)zAngleRad{
    glkMatrix = GLKMatrix4Rotate(glkMatrix, xAngleRad, 1, 0, 0);
    glkMatrix = GLKMatrix4Rotate(glkMatrix, yAngleRad, 0, 1, 0);
    glkMatrix = GLKMatrix4Rotate(glkMatrix, zAngleRad, 0, 0, 1);
}

- (void)translate:(float)x y:(float)y z:(float)z{
    glkMatrix = GLKMatrix4Translate(glkMatrix, x, y, z);
}

//- (void)translate:(vec3) vec{
//    glkMatrix = GLKMatrix4Translate(glkMatrix, vec.x, vec.y, vec.z);
//}

- (void)multiplyLeft:(mat4 *)matrix{
    glkMatrix = GLKMatrix4Multiply(matrix->glkMatrix, glkMatrix);
}

#pragma mark - Helping methods

- (void *)raw{
    return glkMatrix.m;
}

- (void)transpose{
    glkMatrix = GLKMatrix4Transpose(glkMatrix);
}

+ (float)degreesToRad:(float)degrees{
    return GLKMathDegreesToRadians(degrees);
}

+ (NSInteger)numberOfElements{
    return 16;
}

@end
