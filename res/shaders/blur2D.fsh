#ifdef GL_ES                                                                      
precision mediump float;
#endif                                                                            

varying vec4 v_fragmentColor;                                                     
varying vec2 v_texCoord; 

uniform vec2 pixelSize;

void main() 
{
    float weights[49];
    weights[0] =0.0194;
    weights[1] =0.0199;
    weights[2] =0.0202;
    weights[3] =0.0203;
    weights[4] =0.0202;
    weights[5] =0.0199;
    weights[6] =0.0194;
    weights[7] =0.0199;
    weights[8] =0.0204;
    weights[9] =0.0207;
    weights[10] =0.0208;
    weights[11] =0.0207;
    weights[12] =0.0204;
    weights[13] =0.0199;
    weights[14] =0.0202;
    weights[15] =0.0207;
    weights[16] =0.021;
    weights[17] =0.0211;
    weights[18] =0.021;
    weights[19] =0.0207;
    weights[20] =0.0202;
    weights[21] =0.0203;
    weights[22] =0.0208;
    weights[23] =0.0211;
    weights[24] =0.0212;
    weights[25] =0.0211;
    weights[26] =0.0208;
    weights[27] =0.0203;
    weights[28] =0.0202;
    weights[29] =0.0207;
    weights[30] =0.021;
    weights[31] =0.0211;
    weights[32] =0.021;
    weights[33] =0.0207;
    weights[34] =0.0202;
    weights[35] =0.0199;
    weights[36] =0.0204;
    weights[37] =0.0207;
    weights[38] =0.0208;
    weights[39] =0.0207;
    weights[40] =0.0204;
    weights[41] =0.0199;
    weights[42] =0.0194;
    weights[43] =0.0199;
    weights[44] =0.0202;
    weights[45] =0.0203;
    weights[46] =0.0202;
    weights[47] =0.0199;
    weights[48] =0.0194;

	vec4 sum = vec4(0,0,0,0);
	int radiusInStep = 3;
    for(int x=-radiusInStep;x<=radiusInStep;x++)
    {
        for(int y=-radiusInStep;y<=radiusInStep;y++)
        {
            //转换为一维数组索引
            int index = (x+radiusInStep)*(2*radiusInStep+1)+(y+radiusInStep);
            float weight = weights[index];
            sum += texture2D(CC_Texture0, v_texCoord + vec2(x, y)*pixelSize)*weight;     
        }
    }
    gl_FragColor = sum;
} 