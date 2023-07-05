# TCL File Generated by Component Editor 19.1
# Sat Apr 29 11:14:58 PDT 2023
# DO NOT MODIFY


# 
# Feed_Forward "Feed Forward" v1.0
# Jaydon Alexis 2023.04.29.11:14:58
# Forward RGBA image from Avalon streaming source to frame writer
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module Feed_Forward
# 
set_module_property DESCRIPTION "Forward RGBA image from Avalon streaming source to frame writer"
set_module_property NAME Feed_Forward
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "Jaydon Alexis"
set_module_property DISPLAY_NAME "Feed Forward"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL feed_forward
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file feed_forward.v VERILOG PATH ip/sync/feed_forward.v


# 
# parameters
# 
add_parameter IDW INTEGER 23
set_parameter_property IDW DEFAULT_VALUE 23
set_parameter_property IDW DISPLAY_NAME IDW
set_parameter_property IDW TYPE INTEGER
set_parameter_property IDW UNITS None
set_parameter_property IDW ALLOWED_RANGES -2147483648:2147483647
set_parameter_property IDW HDL_PARAMETER true
add_parameter ODW INTEGER 31
set_parameter_property ODW DEFAULT_VALUE 31
set_parameter_property ODW DISPLAY_NAME ODW
set_parameter_property ODW TYPE INTEGER
set_parameter_property ODW UNITS None
set_parameter_property ODW ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ODW HDL_PARAMETER true
add_parameter EW INTEGER 1 ""
set_parameter_property EW DEFAULT_VALUE 1
set_parameter_property EW DISPLAY_NAME EW
set_parameter_property EW TYPE INTEGER
set_parameter_property EW UNITS None
set_parameter_property EW ALLOWED_RANGES -2147483648:2147483647
set_parameter_property EW DESCRIPTION ""
set_parameter_property EW HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point conduit
# 
add_interface conduit conduit end
set_interface_property conduit associatedClock clock
set_interface_property conduit associatedReset ""
set_interface_property conduit ENABLED true
set_interface_property conduit EXPORT_OF ""
set_interface_property conduit PORT_NAME_MAP ""
set_interface_property conduit CMSIS_SVD_VARIABLES ""
set_interface_property conduit SVD_ADDRESS_GROUP ""

add_interface_port conduit out_data data Output "(ODW) - (0) + 1"
add_interface_port conduit out_data_valid valid Output 1


# 
# connection point avalon_forward_sink
# 
add_interface avalon_forward_sink avalon_streaming end
set_interface_property avalon_forward_sink associatedClock clock
set_interface_property avalon_forward_sink associatedReset reset
set_interface_property avalon_forward_sink dataBitsPerSymbol 8
set_interface_property avalon_forward_sink errorDescriptor ""
set_interface_property avalon_forward_sink firstSymbolInHighOrderBits true
set_interface_property avalon_forward_sink maxChannel 0
set_interface_property avalon_forward_sink readyLatency 0
set_interface_property avalon_forward_sink ENABLED true
set_interface_property avalon_forward_sink EXPORT_OF ""
set_interface_property avalon_forward_sink PORT_NAME_MAP ""
set_interface_property avalon_forward_sink CMSIS_SVD_VARIABLES ""
set_interface_property avalon_forward_sink SVD_ADDRESS_GROUP ""

add_interface_port avalon_forward_sink stream_data data Input "(IDW) - (0) + 1"
add_interface_port avalon_forward_sink stream_startofpacket startofpacket Input 1
add_interface_port avalon_forward_sink stream_endofpacket endofpacket Input 1
add_interface_port avalon_forward_sink stream_empty empty Input "(EW) - (0) + 1"
add_interface_port avalon_forward_sink stream_valid valid Input 1
add_interface_port avalon_forward_sink stream_ready ready Output 1

