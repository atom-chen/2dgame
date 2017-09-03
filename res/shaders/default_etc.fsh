#ifdef GL_ES
precision mediump float;
#endif
varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
varying vec2 v_alphaCoord;

void main(void)
{
    vec4 v4Colour = texture2D(CC_Texture0, v_texCoord);
    v4Colour.a = texture2D(CC_Texture0, v_alphaCoord).r;
    v4Colour.xyz = v4Colour.xyz * v4Colour.a;
    gl_FragColor = v4Colour*v_fragmentColor.a;
}