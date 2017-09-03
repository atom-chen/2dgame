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
    float grey = 0.2126*v4Colour.r + 0.7152*v4Colour.g + 0.0722*v4Colour.b;
    gl_FragColor = vec4(grey, grey, grey, v4Colour.a)*v_fragmentColor.a;
}