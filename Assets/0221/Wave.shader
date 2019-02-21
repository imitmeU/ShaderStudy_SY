Shader "Example0221/Wave" {
	Properties{
	  _MainTex("Texture", 2D) = "white" {}
	  _MainTex1("Noise Texture", 2D) = "white" {}
	  _Amount("Extrusion Amount", range(0,10)) =1
	  _Color("Color", Color) = (1,1,1,1)
	}
		SubShader{
		  Tags { "RenderType" = "Opaque" }
		  CGPROGRAM
		  #pragma surface surf Lambert vertex:vert
		  struct Input {
			  float2 uv_MainTex;
			 // float2 uv_MainTex1;
		  };
		  sampler2D _MainTex;
		  sampler2D _MainTex1;
		  half _Amount;
		  fixed4 _Color;

		  void vert (inout appdata_full v) {
			 float4 waveNoise = tex2Dlod(_MainTex1, float4(v.texcoord.xy * 4, 0, 0));
			 half value = v.vertex.x + v.vertex.x + v.vertex.z;
			 v.vertex.y += sin(_Time.y + value * waveNoise);
		  }

		  void surf(Input IN, inout SurfaceOutput o) {
			  fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			  o.Albedo = c * _Color;
		  }
		  ENDCG
	}
		Fallback "Diffuse"
}