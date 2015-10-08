//
//  Shaders.metal
//  FAM
//

//  Copyright (c) 2015 Simon Nilsson. All rights reserved.
//

#include <metal_stdlib>

using namespace metal;

struct Uniforms{
    float4x4 modelMatrix;
    float4x4 projectionMatrix;
};

struct VertexIn {
    packed_float3 position;
    packed_float4 color;
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

vertex VertexOut basic_vertex(const device VertexIn* vertex_array[[buffer(0)]],const device Uniforms&  uniforms    [[ buffer(1) ]], unsigned int vid [[vertex_id]]) {
    float4x4 mv_Matrix = uniforms.modelMatrix;
    float4x4 proj_Matrix = uniforms.projectionMatrix;
    VertexIn VertexIn = vertex_array[vid];
    VertexOut VertexOut;
    VertexOut.position = proj_Matrix * mv_Matrix * float4(VertexIn.position,1);
    VertexOut.color = VertexIn.color;
    return VertexOut;
}

fragment half4 basic_fragment(VertexOut interpolated [[stage_in]]) {
    return half4(interpolated.color[0], interpolated.color[1], interpolated.color[2], interpolated.color[3]);
}

//struct VertexInOut
//{
//    float4  position [[position]];
//    float4  color;
//};
//
//vertex VertexInOut passThroughVertex(uint vid [[ vertex_id ]],
//                                     constant packed_float4* position  [[ buffer(0) ]],
//                                     constant packed_float4* color    [[ buffer(1) ]])
//{
//    VertexInOut outVertex;
//    
//    outVertex.position = position[vid];
//    outVertex.color    = color[vid];
//    
//    return outVertex;
//};
//
//fragment half4 passThroughFragment(VertexInOut inFrag [[stage_in]])
//{
//    return half4(inFrag.color);
//};