$! define sys$output build.txt
$ basic/debug/list/show=all/machine_code main
$ basic/debug/list/show=all/machine_code display
$ basic/debug/list/show=all/machine_code simloop
$ basic/debug/list/show=all/machine_code cls
$ basic/debug/list/show=all/machine_code delay
$ basic/debug/list/show=all/machine_code testland
$ basic/debug/list/show=all/machine_code getkey
$ basic/debug/list/show=all/machine_code print_tab
$ basic/debug/list/show=all/machine_code print_tabv
$ basic/debug/list/show=all/machine_code print_tabvw
$ basic/debug/list/show=all/machine_code keys
$ basic/debug/list/show=all/machine_code navdisplay
$ basic/debug/list/show=all/machine_code tape
$ basic/debug/list/show=all/machine_code minw0dp
$ basic/debug/list/show=all/machine_code tenw2dp
$ basic/debug/list/show=all/machine_code pause
$ basic/debug/list/show=all/machine_code restart
$ basic/debug/list/show=all/machine_code initial
$ basic/debug/list/show=all/machine_code landed
$ basic/debug/list/show=all/machine_code updsim
$ basic/debug/list/show=all/machine_code instr
$ basic/debug/list/show=all/machine_code more
$ basic/debug/list/show=all/machine_code read
$ basic/debug/list/show=all/machine_code alt
$ basic/debug/list/show=all/machine_code vsi
$ basic/debug/list/show=all/machine_code updtape
$ link vaxlander28g.opt/opt
$! deassign sys$output
