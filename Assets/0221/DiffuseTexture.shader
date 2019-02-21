Shader "Example0221/DiffuseTexture" {
	Properties
	{
		_TintColor("Color",color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}
		_AlphaCut("AlphaTest", Range(0,1)) = 0.5
			[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull mode", Float) =2
	}
	SubShader
	{
		Cull [_Cull]
		  Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}


		  CGPROGRAM
		  #pragma surface surf Lambert alpha

		  struct Input {
			  float2 uv_MainTex;
		  };

		  sampler2D _MainTex;
		  fixed4 _TintColor;
		  half _AlphaCut;

		  void surf(Input IN, inout SurfaceOutput o) {
			  fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			  o.Albedo = c * _TintColor;
			  o.Alpha = c.a *_AlphaCut;
		  }
		  ENDCG
	}
		Fallback "Diffuse"
}