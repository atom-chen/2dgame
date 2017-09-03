/*
  Created by guanghui on 4/8/14.
http://www.idevgames.com/forums/thread-3010.html
*/
#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;

uniform float radius;
uniform float threshold;
uniform float outlineColorx;
uniform float outlineColory;
uniform float outlineColorz;

void main()
{
    vec4 normal = texture2D(CC_Texture0, v_texCoord);
    normal.xyz = vec3(0.0,0.0,0.0);
    //计算描边颜色的透明度
    vec4 accum = vec4(0.0);
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x - radius, v_texCoord.y - radius));
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x + radius, v_texCoord.y - radius));
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x + radius, v_texCoord.y + radius));
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x - radius, v_texCoord.y + radius));

    accum *= threshold;

    accum.r = 0.97;
    accum.g = 0.93;
    accum.b = 0.79;

    //根据alpha值在原始颜色和描边颜色做一个插值
    if (accum.a*(1.0 - normal.a) > 0.01) {
        normal = (accum * (1.0 - normal.a)) + (normal * normal.a);
    }

    gl_FragColor = v_fragmentColor * normal;
}
