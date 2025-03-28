#enable_beta_device *  

#xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
#xhub::install [xhub::get_xitems xilinx.com:xilinx_board_store:vck190:*] -quiet

set gen_pdi [lindex $argv 0]

# global variables
set ::platform "vck190"
set ::silicon "e-S"

# local variables
set project_dir "edt_versal"
set scripts_dir "scripts"
set constrs_dir "constrs"

variable design_name
set design_name edt_versal


set part "xcvc1902-vsva2197-2MP-${::silicon}"
puts "INFO: Target part selected: '$part'"

# set up project
# set_param board.repoPaths ./board_files
create_project $design_name $project_dir -part $part -force

set board_lat [ get_board_parts -latest_file_version  {*vck190:*} ]
set_property board_part $board_lat [current_project]


# set up bd design
create_bd_design $design_name
source $scripts_dir/pl_hsdp.tcl


# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/edt_versal.srcs/sources_1/bd/edt_versal/edt_versal.bd] -top
add_files -norecurse ./$project_dir/edt_versal.gen/sources_1/bd/edt_versal/hdl/edt_versal_wrapper.v
set_property top edt_versal_wrapper [current_fileset]


validate_bd_design
save_bd_design
update_compile_order -fileset sources_1
regenerate_bd_layout
save_bd_design
