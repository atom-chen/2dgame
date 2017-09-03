//默认顶点shader

attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec4 a_color;

#ifdef GL_ES
varying lowp vec4 v_fragmentColor;
varying mediump vec2 v_texCoord;
varying mediump vec2 v_texCoord2;
#else
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
varying vec2 v_texCoord2;
#endif
uniform vec4 rect;
void main()
{
    gl_Position = CC_PMatrix * a_position;
    v_fragmentColor = a_color;
    v_texCoord = a_texCoord;
	vec3 ori =  CC_MVMatrix * vec4(-rect.x,-rect.y,0,1);
	v_texCoord2.x = (a_position.x - ori.x)/rect.z;
	v_texCoord2.y = (a_position.y - ori.y)/rect.z;
}
