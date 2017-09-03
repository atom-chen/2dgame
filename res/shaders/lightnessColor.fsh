#ifdef GL_ES
precision mediump float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
varying vec2 v_texCoord2;

uniform sampler2D texture2;

void main(void)
{
    vec4 c  = texture2D(CC_Texture0, v_texCoord);
	vec4 c2 = texture2D(texture2, vec2(v_texCoord2.x - CC_SinTime.x,v_texCoord2.y  - CC_SinTime.y));

	float t = lerp(0.3,0.7,abs(CC_SinTime.w));
	float alphaFactor =  any(greaterThan(vec2(c.w,c.w),vec2(0.01,0.01)));
	gl_FragColor.xyz =(  c.xyz  +  c2.xyz * t ) * alphaFactor;
    gl_FragColor.w = c.w;
}
