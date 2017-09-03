// http://www.cocos2d-iphone.org

#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
uniform float intensity_offset;
uniform float intensity_scale;

void main(void) 
{
	vec4 texColor = texture2D(CC_Texture0, v_texCoord);
    float gray = dot(texColor.rgb, vec3(0.3, 0.59, 0.11));
    float intensity = (gray+intensity_offset) * intensity_scale;
    gl_FragColor = texColor * intensity;
}
