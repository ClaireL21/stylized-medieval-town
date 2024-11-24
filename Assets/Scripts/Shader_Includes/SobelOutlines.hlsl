SAMPLER(sampler_point_clamp);

void GetDepth_float(float2 uv, out float Depth)
{
    Depth = SHADERGRAPH_SAMPLE_SCENE_DEPTH(uv); // accessing node from shader graph
}

void GetNormal_float(float2 uv, out float3 Normal)
{
    Normal = SAMPLE_TEXTURE2D(_NormalsBuffer, sampler_point_clamp, uv).rgb;
}

// SOBEL
static float2 sobelSamplePoints[9] =
{
    float2(-1, 1), float2(0, 1), float2(1, 1),
    float2(-1, 0), float2(0, 0), float2(1, 1),
    float2(-1, -1), float2(0, -1), float2(1, -1),
};

// Weights for the x component
static float sobelXMatrix[9] =
{
    1, 0, -1,
    2, 0, -2,
    1, 0, -1
};

// Weights for the y component
static float sobelYMatrix[9] =
{
    1, 2, 1,
    0, 0, 0,
    -1, -2, -1
};

// Depth based outlines
void DepthSobel_float(float2 UV, float Thickness, float2 screenRatio, out float OUT)
{
    float2 sobel = 0;
    
    //[unroll]
    for (int i = 0; i < 9; i++)
    {
        float depth = SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV + sobelSamplePoints[i] * Thickness * screenRatio);
        sobel += depth * float2(sobelXMatrix[i], sobelYMatrix[i]);
    }

    OUT = length(sobel);
}

//void ReturnMainTex_float(float2 UV, out float3 OUT)
//{
//    OUT = SAMPLE_TEXTURE2D(_MainTex, sampler_point_clamp, UV).rgb; 
//}