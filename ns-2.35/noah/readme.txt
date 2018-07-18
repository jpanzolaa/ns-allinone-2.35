http://icapeople.epfl.ch/widmer/uwb/ns-2/noah/

NO Ad-Hoc Routing Agent (NOAH)
NOAH is a wireless routing agent that (in contrast to DSDV, DSR, ...) only supports direct communication between wireless nodes or between base stations and mobile nodes in case Mobile IP is used. This allows to simulate scenarios where multi-hop wireless routing is undesired. NOAH does not send any routing related packets.
It has been updated to work with ns-2.26 - ns-2.30 and with non-Mobile IP scenarios. (For older versions of ns-2, take a look at http://www.informatik.uni-mannheim.de/informatik/pi4/projects/MobileIP/ns-extension/ but this version does not contain the bugfixes for non-Mobile IP scenarios.)
Further update to allow static multi-hop routes. The routes can be set up using the routing command which takes as parameters the number of destinations and then as many tuples of destination and next hop address. The following example sets up static routing for a line of nodes:
# setup static routing for line of nodes
for {set i 0} {$i < $val(nn) } {incr i} {
    set cmd "[$node_($i) set ragent_] routing $val(nn)"
    for {set to 0} {$to < $val(nn) } {incr to} {
	if {$to < $i} {
	    set hop [expr $i - 1]
	} elseif {$to > $i} {
	    set hop [expr $i + 1]
	} else {
	    set hop $i
	}
	set cmd "$cmd $to $hop"
    }
    eval $cmd
}
Step-by-step installation instructions for ns-2.26 (and ns-2.30)
Makefile.in	add noah/noah.o \ to OBJ_CC and tcl/mobility/noah.tcl \ to NS_TCL_LIB
noah/noah.{h,cc}	add noah.h and noah.cc to a new subdirectory noah/
tcl/mobility/noah.tcl	add noah.tcl to tcl/mobility/
tcl/lib/ns-lib.tcl	line 191 (for v2.29 line 197): add source ../mobility/noah.tcl
line 603ff (for v2.29 line 649ff): add
	    NOAH {
		    set ragent [$self create-noah-agent $node]
	    }
line 768ff (for v2.29 line 839ff): add
Simulator instproc create-noah-agent { node } {
    # Create a noah routing agent for this node
    set ragent [new Agent/NOAH]

    ## setup address (supports hier-addr) for noah agent
    ## and mobilenode
    set addr [$node node-addr]

    $ragent addr $addr
    $ragent node $node

    if [Simulator set mobile_ip_] {
        $ragent port-dmux [$node demux]
    }
    $node addr $addr
    $node set ragent_ $ragent
    return $ragent
}
