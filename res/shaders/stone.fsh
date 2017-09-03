#ifdef GL_ES
precision mediump float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;

void main(void)
{
    vec4 c = texture2D(CC_Texture0, v_texCoord);
    //0.2126*0.8, 0.7152*0.8, 0.0722*0.8
    gl_FragColor.xyz = vec3(0.17*c.r + 0.57*c.g + 0.06*c.b);
    gl_FragColor.w = c.w;
}
