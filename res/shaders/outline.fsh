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
uniform vec3 outlineColor;

void main()
{
    vec4 normal = texture2D(CC_Texture0, v_texCoord);

    //计算描边颜色的透明度
    vec4 accum = vec4(0.0);
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x - radius, v_texCoord.y - radius));
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x + radius, v_texCoord.y - radius));
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x + radius, v_texCoord.y + radius));
    accum += texture2D(CC_Texture0, vec2(v_texCoord.x - radius, v_texCoord.y + radius));

    accum *= threshold;

    accum.r = outlineColor.x;
    accum.g = outlineColor.y;
    accum.b = outlineColor.z;

    //根据alpha值在原始颜色和描边颜色做一个插值
    normal = (accum * (1.0 - normal.a)) + (normal * normal.a);

    gl_FragColor = v_fragmentColor * normal;
}
