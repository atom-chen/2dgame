//流光效果

#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

//亮条的宽度
uniform float width;
//颜色亮度系数
uniform float factor;
//亮条位置偏移
uniform float offset;
//亮条颜色
uniform vec3  color;

void main(void) 
{
	vec4 texColor = texture2D(CC_Texture0, v_texCoord);

	//求v_texCoord到直线x+y=offset的距离
	float distance = abs(v_texCoord.x + v_texCoord.y - offset)*0.707;

	//衰减不透明度
	float opacity = 1.0-(1.0/width)*distance;
	opacity = max(opacity, 0.0);

	//衰减颜色
	vec4 sample = vec4(color, 1.0)*opacity;

	//叠加到原始颜色
	float alpha = sample.w*texColor.w;
	texColor.xyz += sample.xyz*alpha*factor;

    gl_FragColor = v_fragmentColor * texColor;
}
