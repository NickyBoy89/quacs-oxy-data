            //This file was automatically generated. Please do not modify it directly
            use ::phf::{{phf_map, Map}};

            pub const BIT_VEC_LEN: usize = 1;

            pub static CRN_TIMES: Map<u32, [u64; BIT_VEC_LEN]> = phf_map! {
            	3032u32 => [28],
	3003u32 => [2],
	3005u32 => [1],
	3008u32 => [0],
	3007u32 => [8],
	3009u32 => [4],
	3010u32 => [1],
	3012u32 => [3],
	3011u32 => [20],
	3013u32 => [16],
	3015u32 => [0],

            };

            pub static CRN_COURSES: Map<u32, &'static str> = phf_map! {
            	3032u32 => "CORE-111",
	3003u32 => "DWA-236",
	3005u32 => "HIST-209",
	3008u32 => "MATH-212",
	3007u32 => "MATH-120",
	3009u32 => "MAC-248",
	3010u32 => "MUSC-101",
	3012u32 => "PHYS-115L",
	3011u32 => "PHYS-115",
	3013u32 => "SOC-101",
	3015u32 => "WRD-201",
};