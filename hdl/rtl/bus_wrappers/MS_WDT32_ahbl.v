/*
	Copyright 2020 Mohamed Shalan

	Author: Mohamed Shalan (mshalan@aucegypt.edu)

	This file is auto-generated by wrapper_gen.py on 2023-10-30

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/


`timescale			1ns/1ns
`default_nettype	none

`define		AHB_BLOCK(name, init)		always @(posedge HCLK or negedge HRESETn) if(~HRESETn) name <= init;
`define		AHB_REG(name, init, size)	`AHB_BLOCK(name, init) else if(ahbl_we & (last_HADDR[15:0]==``name``_ADDR)) name <= HWDATA[``size``-1:0];
`define		AHB_ICR(size)				`AHB_BLOCK(ICR_REG, sz'b0) else if(ahbl_we & (last_HADDR[15:0]==ICR_REG_ADDR)) ICR_REG <= HWDATA[``size``-1:0]; else ICR_REG <= ``size``'d0;

module MS_WDT32_ahbl (
	input	wire 		HCLK,
	input	wire 		HRESETn,
	input	wire [31:0]	HADDR,
	input	wire 		HWRITE,
	input	wire [1:0]	HTRANS,
	input	wire 		HREADY,
	input	wire 		HSEL,
	input	wire [2:0]	HSIZE,
	input	wire [31:0]	HWDATA,
	output	wire [31:0]	HRDATA,
	output	wire 		HREADYOUT,
	output	wire 		irq
);
	localparam[15:0] TIMER_REG_ADDR = 16'h0000;
	localparam[15:0] LOAD_REG_ADDR = 16'h0004;
	localparam[15:0] CONTROL_REG_ADDR = 16'h0008;
	localparam[15:0] ICR_REG_ADDR = 16'h0f00;
	localparam[15:0] RIS_REG_ADDR = 16'h0f04;
	localparam[15:0] IM_REG_ADDR = 16'h0f08;
	localparam[15:0] MIS_REG_ADDR = 16'h0f0c;

	reg             last_HSEL;
	reg [31:0]      last_HADDR;
	reg             last_HWRITE;
	reg [1:0]       last_HTRANS;

	always@ (posedge HCLK or negedge HRESETn) begin
		if (!HRESETn) begin
			last_HSEL       <= 0;
			last_HADDR      <= 0;
			last_HWRITE     <= 0;
			last_HTRANS     <= 0;
		end else if (HREADY) begin
			last_HSEL       <= HSEL;
			last_HADDR      <= HADDR;
			last_HWRITE     <= HWRITE;
			last_HTRANS     <= HTRANS;
		end
	end

	reg	[31:0]	LOAD_REG;
	reg	[0:0]	CONTROL_REG;
	reg	[0:0]	RIS_REG;
	reg	[0:0]	ICR_REG;
	reg	[0:0]	IM_REG;

	wire[31:0]	WDTMR;
	wire[31:0]	TIMER_REG	= WDTMR;
	wire[31:0]	WDTLOAD	= LOAD_REG[31:0];
	wire		WDTEN	= CONTROL_REG[0:0];
	wire		WDTOV;
	wire		_WDTOV_FLAG_	= WDTOV;
	wire		MIS_REG	= RIS_REG & IM_REG;
	wire		ahbl_valid	= last_HSEL & last_HTRANS[1];
	wire		ahbl_we	= last_HWRITE & ahbl_valid;
	wire		ahbl_re	= ~last_HWRITE & ahbl_valid;
	wire		_clk_	= HCLK;
	wire		_rst_	= ~HRESETn;

	MS_WDT32 inst_to_wrap (
		.clk(_clk_),
		.rst_n(~_rst_),
		.WDTMR(WDTMR),
		.WDTLOAD(WDTLOAD),
		.WDTOV(WDTOV),
		.WDTEN(WDTEN)
	);

	`AHB_REG(LOAD_REG, 0, 32)
	`AHB_REG(CONTROL_REG, 0, 1)
	`AHB_REG(IM_REG, 0, 1)

	`AHB_ICR(1)

	always @(posedge HCLK or negedge HRESETn)
		if(~HRESETn) RIS_REG <= 32'd0;
		else begin
			if(_WDTOV_FLAG_) RIS_REG[0] <= 1'b1; else if(ICR_REG[0]) RIS_REG[0] <= 1'b0;

		end

	assign irq = |MIS_REG;

	assign	HRDATA = 
			(last_HADDR[15:0] == LOAD_REG_ADDR) ? LOAD_REG :
			(last_HADDR[15:0] == CONTROL_REG_ADDR) ? CONTROL_REG :
			(last_HADDR[15:0] == RIS_REG_ADDR) ? RIS_REG :
			(last_HADDR[15:0] == ICR_REG_ADDR) ? ICR_REG :
			(last_HADDR[15:0] == IM_REG_ADDR) ? IM_REG :
			(last_HADDR[15:0] == TIMER_REG_ADDR) ? TIMER_REG :
			(last_HADDR[15:0] == MIS_REG_ADDR) ? MIS_REG :
			32'hDEADBEEF;


	assign HREADYOUT = 1'b1;

endmodule
