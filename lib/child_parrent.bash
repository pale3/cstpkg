is_child_of(){
	#local invokedby=$(pstree | grep customizepkg | awk -F'---' '{print $2}')
	local	invokedby=$(ps -ocommand= -p $PPID | awk '{print $2}' | awk -F/ '{print $NF}')
	echo $invokedby
}

is_parent_or_child(){
	local process=$(ps -o stat= -p $PPID)
	
	case $process in
		S+ ) echo child ;;
	  Ss ) echo parrent ;;
	esac 
}
