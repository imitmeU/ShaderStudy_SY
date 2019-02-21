Shader "Example0221/Clip"
{
	Properties{
		_MainTex("Texture", 2D) = "white" {}

	//[Toggle(ENABLE_Clip)] _Clip("Clip enable", Float) = 0
	[KeywordEnum(None, Xpos, YPos)] _Clip("Clip mode", Float) = 0
	}
		SubShader{
		  Tags { "RenderType" = "Opaque" }

		  Cull off
		  CGPROGRAM

		  #pragma surface surf Lambert
		  //#pragma shader_feature _CLIP_ON
		  #pragma shader_feature ENABLE_Clip
		  #pragma multi_compile _CLIP_NONE _CLIP_XPOS _CLIP_YPOS

		  struct Input {
			  float2 uv_MainTex;
			  float3 worldPos;
		  };
		  sampler2D _MainTex;


		  void surf(Input IN, inout SurfaceOutput o) {
		  #if _CLIP_XPOS
			  clip(frac(IN.worldPos.x) - 0.5);
		  #elif _CLIP_YPOS
			  clip(frac(IN.worldPos.y) - 0.5);
		  #endif
			  o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		  }
		  ENDCG
	}
		Fallback "Diffuse"
}
