#Read All Files
read_file -format verilog  geofence.v
current_design geofence
link

#Setting Clock Constraints
source -echo -verbose geofence.sdc
check_design
set high_fanout_net_threshold 0
uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]

#Synthesis all design
compile

#Save files
write -format ddc     -hierarchy -output "geofence_syn.ddc"
write_sdf -version 1.0 -context verilog geofence_syn.sdf
write -format verilog -hierarchy -output geofence_syn.v
report_area > area.log
report_timing > timing.log
report_qor   >  geofence_syn.qor
