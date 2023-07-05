// Computer_System_Video_Subsystem.v

// Generated using ACDS version 17.1 590

`timescale 1 ps / 1 ps
module Computer_System_Video_Subsystem (
		input  wire        clk_clk,                                                 //                                       clk.clk
		input  wire        reset_reset_n,                                           //                                     reset.reset_n
		output wire [31:0] rgba_image_data,                                         //                                rgba_image.data
		output wire        rgba_image_valid,                                        //                                          .valid
		input  wire        stream_control_endofpacket,                              //                            stream_control.endofpacket
		output wire        stream_control_ready,                                    //                                          .ready
		output wire        stream_control_sreset,                                   //                                          .sreset
		input  wire        video_in_TD_CLK27,                                       //                                  video_in.TD_CLK27
		input  wire [7:0]  video_in_TD_DATA,                                        //                                          .TD_DATA
		input  wire        video_in_TD_HS,                                          //                                          .TD_HS
		input  wire        video_in_TD_VS,                                          //                                          .TD_VS
		input  wire        video_in_clk27_reset,                                    //                                          .clk27_reset
		output wire        video_in_TD_RESET,                                       //                                          .TD_RESET
		output wire        video_in_overflow_flag,                                  //                                          .overflow_flag
		input  wire [23:0] video_in_feed_forward_avalon_forward_sink_data,          // video_in_feed_forward_avalon_forward_sink.data
		input  wire        video_in_feed_forward_avalon_forward_sink_startofpacket, //                                          .startofpacket
		input  wire        video_in_feed_forward_avalon_forward_sink_endofpacket,   //                                          .endofpacket
		input  wire [1:0]  video_in_feed_forward_avalon_forward_sink_empty,         //                                          .empty
		input  wire        video_in_feed_forward_avalon_forward_sink_valid,         //                                          .valid
		output wire        video_in_feed_forward_avalon_forward_sink_ready,         //                                          .ready
		input  wire        video_in_scaler_avalon_scaler_source_ready,              //      video_in_scaler_avalon_scaler_source.ready
		output wire        video_in_scaler_avalon_scaler_source_startofpacket,      //                                          .startofpacket
		output wire        video_in_scaler_avalon_scaler_source_endofpacket,        //                                          .endofpacket
		output wire        video_in_scaler_avalon_scaler_source_valid,              //                                          .valid
		output wire [23:0] video_in_scaler_avalon_scaler_source_data                //                                          .data
	);

	wire         video_in_resampler_avalon_chroma_source_valid;         // Video_In_Resampler:stream_out_valid -> Video_In_Converter:stream_in_valid
	wire  [23:0] video_in_resampler_avalon_chroma_source_data;          // Video_In_Resampler:stream_out_data -> Video_In_Converter:stream_in_data
	wire         video_in_resampler_avalon_chroma_source_ready;         // Video_In_Converter:stream_in_ready -> Video_In_Resampler:stream_out_ready
	wire         video_in_resampler_avalon_chroma_source_startofpacket; // Video_In_Resampler:stream_out_startofpacket -> Video_In_Converter:stream_in_startofpacket
	wire         video_in_resampler_avalon_chroma_source_endofpacket;   // Video_In_Resampler:stream_out_endofpacket -> Video_In_Converter:stream_in_endofpacket
	wire         video_in_clipper_avalon_clipper_source_valid;          // Video_In_Clipper:stream_out_valid -> Video_In_Scaler:stream_in_valid
	wire  [23:0] video_in_clipper_avalon_clipper_source_data;           // Video_In_Clipper:stream_out_data -> Video_In_Scaler:stream_in_data
	wire         video_in_clipper_avalon_clipper_source_ready;          // Video_In_Scaler:stream_in_ready -> Video_In_Clipper:stream_out_ready
	wire         video_in_clipper_avalon_clipper_source_startofpacket;  // Video_In_Clipper:stream_out_startofpacket -> Video_In_Scaler:stream_in_startofpacket
	wire         video_in_clipper_avalon_clipper_source_endofpacket;    // Video_In_Clipper:stream_out_endofpacket -> Video_In_Scaler:stream_in_endofpacket
	wire         video_in_converter_avalon_csc_source_valid;            // Video_In_Converter:stream_out_valid -> Video_In_Clipper:stream_in_valid
	wire  [23:0] video_in_converter_avalon_csc_source_data;             // Video_In_Converter:stream_out_data -> Video_In_Clipper:stream_in_data
	wire         video_in_converter_avalon_csc_source_ready;            // Video_In_Clipper:stream_in_ready -> Video_In_Converter:stream_out_ready
	wire         video_in_converter_avalon_csc_source_startofpacket;    // Video_In_Converter:stream_out_startofpacket -> Video_In_Clipper:stream_in_startofpacket
	wire         video_in_converter_avalon_csc_source_endofpacket;      // Video_In_Converter:stream_out_endofpacket -> Video_In_Clipper:stream_in_endofpacket
	wire         video_in_decoder_avalon_decoder_source_valid;          // Video_In_Decoder:stream_out_valid -> Video_In_Resampler:stream_in_valid
	wire  [15:0] video_in_decoder_avalon_decoder_source_data;           // Video_In_Decoder:stream_out_data -> Video_In_Resampler:stream_in_data
	wire         video_in_decoder_avalon_decoder_source_ready;          // Video_In_Resampler:stream_in_ready -> Video_In_Decoder:stream_out_ready
	wire         video_in_decoder_avalon_decoder_source_startofpacket;  // Video_In_Decoder:stream_out_startofpacket -> Video_In_Resampler:stream_in_startofpacket
	wire         video_in_decoder_avalon_decoder_source_endofpacket;    // Video_In_Decoder:stream_out_endofpacket -> Video_In_Resampler:stream_in_endofpacket
	wire         rst_controller_reset_out_reset;                        // rst_controller:reset_out -> [Frame_Sync:reset, Video_In_Clipper:reset, Video_In_Converter:reset, Video_In_Decoder:reset, Video_In_Feed_Forward:reset, Video_In_Resampler:reset, Video_In_Scaler:reset]

	frame_sync frame_sync (
		.clk                (clk_clk),                        //   clock.clk
		.reset              (rst_controller_reset_out_reset), //   reset.reset
		.stream_endofpacket (stream_control_endofpacket),     // conduit.endofpacket
		.stream_ready       (stream_control_ready),           //        .ready
		.video_stream_reset (stream_control_sreset)           //        .sreset
	);

	Computer_System_Video_Subsystem_Video_In_Clipper video_in_clipper (
		.clk                      (clk_clk),                                              //                   clk.clk
		.reset                    (rst_controller_reset_out_reset),                       //                 reset.reset
		.stream_in_data           (video_in_converter_avalon_csc_source_data),            //   avalon_clipper_sink.data
		.stream_in_startofpacket  (video_in_converter_avalon_csc_source_startofpacket),   //                      .startofpacket
		.stream_in_endofpacket    (video_in_converter_avalon_csc_source_endofpacket),     //                      .endofpacket
		.stream_in_valid          (video_in_converter_avalon_csc_source_valid),           //                      .valid
		.stream_in_ready          (video_in_converter_avalon_csc_source_ready),           //                      .ready
		.stream_out_ready         (video_in_clipper_avalon_clipper_source_ready),         // avalon_clipper_source.ready
		.stream_out_data          (video_in_clipper_avalon_clipper_source_data),          //                      .data
		.stream_out_startofpacket (video_in_clipper_avalon_clipper_source_startofpacket), //                      .startofpacket
		.stream_out_endofpacket   (video_in_clipper_avalon_clipper_source_endofpacket),   //                      .endofpacket
		.stream_out_valid         (video_in_clipper_avalon_clipper_source_valid)          //                      .valid
	);

	Computer_System_Video_Subsystem_Video_In_Converter video_in_converter (
		.clk                      (clk_clk),                                               //               clk.clk
		.reset                    (rst_controller_reset_out_reset),                        //             reset.reset
		.stream_in_startofpacket  (video_in_resampler_avalon_chroma_source_startofpacket), //   avalon_csc_sink.startofpacket
		.stream_in_endofpacket    (video_in_resampler_avalon_chroma_source_endofpacket),   //                  .endofpacket
		.stream_in_valid          (video_in_resampler_avalon_chroma_source_valid),         //                  .valid
		.stream_in_ready          (video_in_resampler_avalon_chroma_source_ready),         //                  .ready
		.stream_in_data           (video_in_resampler_avalon_chroma_source_data),          //                  .data
		.stream_out_ready         (video_in_converter_avalon_csc_source_ready),            // avalon_csc_source.ready
		.stream_out_startofpacket (video_in_converter_avalon_csc_source_startofpacket),    //                  .startofpacket
		.stream_out_endofpacket   (video_in_converter_avalon_csc_source_endofpacket),      //                  .endofpacket
		.stream_out_valid         (video_in_converter_avalon_csc_source_valid),            //                  .valid
		.stream_out_data          (video_in_converter_avalon_csc_source_data)              //                  .data
	);

	Computer_System_Video_Subsystem_Video_In_Decoder video_in_decoder (
		.clk                      (clk_clk),                                              //                   clk.clk
		.reset                    (rst_controller_reset_out_reset),                       //                 reset.reset
		.stream_out_ready         (video_in_decoder_avalon_decoder_source_ready),         // avalon_decoder_source.ready
		.stream_out_startofpacket (video_in_decoder_avalon_decoder_source_startofpacket), //                      .startofpacket
		.stream_out_endofpacket   (video_in_decoder_avalon_decoder_source_endofpacket),   //                      .endofpacket
		.stream_out_valid         (video_in_decoder_avalon_decoder_source_valid),         //                      .valid
		.stream_out_data          (video_in_decoder_avalon_decoder_source_data),          //                      .data
		.TD_CLK27                 (video_in_TD_CLK27),                                    //    external_interface.export
		.TD_DATA                  (video_in_TD_DATA),                                     //                      .export
		.TD_HS                    (video_in_TD_HS),                                       //                      .export
		.TD_VS                    (video_in_TD_VS),                                       //                      .export
		.clk27_reset              (video_in_clk27_reset),                                 //                      .export
		.TD_RESET                 (video_in_TD_RESET),                                    //                      .export
		.overflow_flag            (video_in_overflow_flag)                                //                      .export
	);

	feed_forward #(
		.IDW (23),
		.ODW (31),
		.EW  (1)
	) video_in_feed_forward (
		.clk                  (clk_clk),                                                 //               clock.clk
		.reset                (rst_controller_reset_out_reset),                          //               reset.reset
		.out_data             (rgba_image_data),                                         //             conduit.data
		.out_data_valid       (rgba_image_valid),                                        //                    .valid
		.stream_data          (video_in_feed_forward_avalon_forward_sink_data),          // avalon_forward_sink.data
		.stream_startofpacket (video_in_feed_forward_avalon_forward_sink_startofpacket), //                    .startofpacket
		.stream_endofpacket   (video_in_feed_forward_avalon_forward_sink_endofpacket),   //                    .endofpacket
		.stream_empty         (video_in_feed_forward_avalon_forward_sink_empty),         //                    .empty
		.stream_valid         (video_in_feed_forward_avalon_forward_sink_valid),         //                    .valid
		.stream_ready         (video_in_feed_forward_avalon_forward_sink_ready)          //                    .ready
	);

	Computer_System_Video_Subsystem_Video_In_Resampler video_in_resampler (
		.clk                      (clk_clk),                                               //                  clk.clk
		.reset                    (rst_controller_reset_out_reset),                        //                reset.reset
		.stream_in_startofpacket  (video_in_decoder_avalon_decoder_source_startofpacket),  //   avalon_chroma_sink.startofpacket
		.stream_in_endofpacket    (video_in_decoder_avalon_decoder_source_endofpacket),    //                     .endofpacket
		.stream_in_valid          (video_in_decoder_avalon_decoder_source_valid),          //                     .valid
		.stream_in_ready          (video_in_decoder_avalon_decoder_source_ready),          //                     .ready
		.stream_in_data           (video_in_decoder_avalon_decoder_source_data),           //                     .data
		.stream_out_ready         (video_in_resampler_avalon_chroma_source_ready),         // avalon_chroma_source.ready
		.stream_out_startofpacket (video_in_resampler_avalon_chroma_source_startofpacket), //                     .startofpacket
		.stream_out_endofpacket   (video_in_resampler_avalon_chroma_source_endofpacket),   //                     .endofpacket
		.stream_out_valid         (video_in_resampler_avalon_chroma_source_valid),         //                     .valid
		.stream_out_data          (video_in_resampler_avalon_chroma_source_data)           //                     .data
	);

	Computer_System_Video_Subsystem_Video_In_Scaler video_in_scaler (
		.clk                      (clk_clk),                                              //                  clk.clk
		.reset                    (rst_controller_reset_out_reset),                       //                reset.reset
		.stream_in_startofpacket  (video_in_clipper_avalon_clipper_source_startofpacket), //   avalon_scaler_sink.startofpacket
		.stream_in_endofpacket    (video_in_clipper_avalon_clipper_source_endofpacket),   //                     .endofpacket
		.stream_in_valid          (video_in_clipper_avalon_clipper_source_valid),         //                     .valid
		.stream_in_ready          (video_in_clipper_avalon_clipper_source_ready),         //                     .ready
		.stream_in_data           (video_in_clipper_avalon_clipper_source_data),          //                     .data
		.stream_out_ready         (video_in_scaler_avalon_scaler_source_ready),           // avalon_scaler_source.ready
		.stream_out_startofpacket (video_in_scaler_avalon_scaler_source_startofpacket),   //                     .startofpacket
		.stream_out_endofpacket   (video_in_scaler_avalon_scaler_source_endofpacket),     //                     .endofpacket
		.stream_out_valid         (video_in_scaler_avalon_scaler_source_valid),           //                     .valid
		.stream_out_data          (video_in_scaler_avalon_scaler_source_data)             //                     .data
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
