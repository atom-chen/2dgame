#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

uniform float alphaGo;

void main(void)
{
	vec4 texColor = texture2D(CC_Texture0, v_texCoord);

	float grey = 0.2126 * texColor.r + 0.7152 * texColor.g + 0.0722 * texColor.b;
	// vec4 final = vec4(grey * alphaGo + texColor.r * (1 - alphaGo), grey * alphaGo + texColor.g * (1 - alphaGo), grey * alphaGo + texColor.b * (1 - alphaGo), texColor.a);
    // gl_FragColor = v_fragmentColor * final;
    gl_FragColor = v_fragmentColor * vec4(grey, grey, grey, texColor.a);
}
