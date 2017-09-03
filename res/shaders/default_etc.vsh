//默认顶点shader

attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec4 a_color;

#ifdef GL_ES
varying lowp vec4 v_fragmentColor;
varying mediump vec2 v_texCoord;
varying mediump vec2 v_alphaCoord;
#else
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
varying vec2 v_alphaCoord;
#endif

void main()
{
    gl_Position = CC_PMatrix * a_position;
    v_texCoord = a_texCoord * vec2(1.0, 1.0);
    v_alphaCoord = a_texCoord + vec2(0.0, 0.5);
    v_fragmentColor = a_color;
}
