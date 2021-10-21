Shader "Lockwood/Diffuse_Cubemap_ProbeLit" {
	Properties {
		_MainColor ("Main Tint", Vector) = (1,1,1,0.5)
		_ReflectColor ("Reflection Tint", Vector) = (1,1,1,0.5)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Cube ("Reflection Cubemap", Cube) = "_Skybox" {}
	}
	SubShader {
		Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
			GpuProgramID 43745
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform lowp vec4 _LightColor0;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 worldN_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_4[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_4[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * _glesNormal);
					  worldN_1 = tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = normalize(worldN_1);
					  mediump vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_6;
					  mediump vec3 res_8;
					  mediump vec3 x_9;
					  x_9.x = dot (unity_SHAr, tmpvar_7);
					  x_9.y = dot (unity_SHAg, tmpvar_7);
					  x_9.z = dot (unity_SHAb, tmpvar_7);
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
					    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
					  )));
					  res_8 = max (((1.055 * 
					    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = (_LightColor0.xyz + res_8);
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (_glesNormal * tmpvar_12);
					  xlv_TEXCOORD3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec3 _MainColor;
					uniform lowp vec3 _ReflectColor;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_1.w = tmpvar_2.w;
					  tex_1.xyz = (tmpvar_2.xyz * (_MainColor * xlv_TEXCOORD1));
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(xlv_TEXCOORD2);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = (xlv_TEXCOORD3 - (2.0 * (
					    dot (tmpvar_3, xlv_TEXCOORD3)
					   * tmpvar_3)));
					  tex_1.xyz = (tex_1.xyz + ((textureCube (_Cube, tmpvar_4) * tmpvar_2.w).xyz * _ReflectColor));
					  gl_FragData[0] = tex_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform lowp vec4 _LightColor0;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 worldN_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_4[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_4[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * _glesNormal);
					  worldN_1 = tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = normalize(worldN_1);
					  mediump vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_6;
					  mediump vec3 res_8;
					  mediump vec3 x_9;
					  x_9.x = dot (unity_SHAr, tmpvar_7);
					  x_9.y = dot (unity_SHAg, tmpvar_7);
					  x_9.z = dot (unity_SHAb, tmpvar_7);
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
					    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
					  )));
					  res_8 = max (((1.055 * 
					    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = (_LightColor0.xyz + res_8);
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (_glesNormal * tmpvar_12);
					  xlv_TEXCOORD3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec3 _MainColor;
					uniform lowp vec3 _ReflectColor;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_1.w = tmpvar_2.w;
					  tex_1.xyz = (tmpvar_2.xyz * (_MainColor * xlv_TEXCOORD1));
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(xlv_TEXCOORD2);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = (xlv_TEXCOORD3 - (2.0 * (
					    dot (tmpvar_3, xlv_TEXCOORD3)
					   * tmpvar_3)));
					  tex_1.xyz = (tex_1.xyz + ((textureCube (_Cube, tmpvar_4) * tmpvar_2.w).xyz * _ReflectColor));
					  gl_FragData[0] = tex_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform lowp vec4 _LightColor0;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  mediump vec3 worldN_1;
					  highp vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp mat3 tmpvar_4;
					  tmpvar_4[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_4[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_4[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * _glesNormal);
					  worldN_1 = tmpvar_5;
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = normalize(worldN_1);
					  mediump vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_6;
					  mediump vec3 res_8;
					  mediump vec3 x_9;
					  x_9.x = dot (unity_SHAr, tmpvar_7);
					  x_9.y = dot (unity_SHAg, tmpvar_7);
					  x_9.z = dot (unity_SHAb, tmpvar_7);
					  mediump vec3 x1_10;
					  mediump vec4 tmpvar_11;
					  tmpvar_11 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
					  x1_10.x = dot (unity_SHBr, tmpvar_11);
					  x1_10.y = dot (unity_SHBg, tmpvar_11);
					  x1_10.z = dot (unity_SHBb, tmpvar_11);
					  res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
					    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
					  )));
					  res_8 = max (((1.055 * 
					    pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  tmpvar_2 = (_LightColor0.xyz + res_8);
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_WorldToObject[0].xyz;
					  tmpvar_12[1] = unity_WorldToObject[1].xyz;
					  tmpvar_12[2] = unity_WorldToObject[2].xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (_glesNormal * tmpvar_12);
					  xlv_TEXCOORD3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec3 _MainColor;
					uniform lowp vec3 _ReflectColor;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tex_1.w = tmpvar_2.w;
					  tex_1.xyz = (tmpvar_2.xyz * (_MainColor * xlv_TEXCOORD1));
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(xlv_TEXCOORD2);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = (xlv_TEXCOORD3 - (2.0 * (
					    dot (tmpvar_3, xlv_TEXCOORD3)
					   * tmpvar_3)));
					  tex_1.xyz = (tex_1.xyz + ((textureCube (_Cube, tmpvar_4) * tmpvar_2.w).xyz * _ReflectColor));
					  gl_FragData[0] = tex_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
			}
		}
	}
	Fallback "Lockwood/Diffuse"
}