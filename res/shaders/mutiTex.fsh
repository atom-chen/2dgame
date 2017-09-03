//纹理混合
#ifdef GL_ES                                                                      
precision mediump float;
#endif 

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;

uniform sampler2D orgTexture;

void main()
{
    //高光模糊后的颜色
    vec4 texColor = texture2D(CC_Texture0, v_texCoord);

    //原始颜色
    vec4 orgColor = texture2D(orgTexture, v_texCoord);
    
    //根据alpha值在原始颜色和纹理颜色做一个插值
    gl_FragColor = (texColor * (1.0-orgColor.a)) + (orgColor * orgColor.a);
}

