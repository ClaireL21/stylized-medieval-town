SAMPLER(sampler_point_clamp);

void GetDepth_float(float2 uv, out float Depth)
{
    Depth = SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); // accessing node from shader graph
}

static float2 robertMatrix[4] =
{
    float2(-0.001, -0.001),
    float2(0.001, 0.001),
    float2(0.001, -0.001),
    float2(-0.001, 0.001)
};

// Robert cross edge detection - outlines 
void RobertCross_float(float2 offset, float strength, out float OUT)
{
   // float2 a = float2(-0.001, -0.001);
   // float2 b = float2(0.001, 0.001);
   // float2 c = float2(0.001, -0.001);
   // float2 d = float2(-0.001, 0.001);
    float2 depthMatrix[4] = {
        float2(0, 0),
        float2(0, 0),
        float2(0, 0),
        float2(0, 0)
    };
    
    // add offset to each vector
    for (int i = 0; i < 4; i++)
    {
        float2 vec_offset = robertMatrix[i] + offset;
        
        // sample scene depth
        float depth = SHADERGRAPH_SAMPLE_SCENE_DEPTH(vec_offset);
        depthMatrix[i] = depth;
    }
    
    float2 a = depthMatrix[0] - depthMatrix[1];
    float2 b = depthMatrix[2] - depthMatrix[3];
    
    OUT = sqrt(pow(a, 2) + pow(b, 2)) * strength;
    
    
    // a += offset;
    // b += offset;
    // c += offset;
    // d += offset;
    
    

}

//void ReturnMainTex_float(float2 UV, out float3 OUT)
//{
//    OUT = SAMPLE_TEXTURE2D(_MainTex, sampler_point_clamp, UV).rgb; 
//}