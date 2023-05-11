#  MIPS Datapath Simulator Game

## Background & Summary

Earlier this semester, we set out to create a mobile iOS game to facilitate learning the MIPS datapath for a variety ofinstructions. 
Learning from common experience and popular studies (like the one completed at Texas A&M University regarding Calculus), 
we believed that a fast-paced, dynamic gameplay would be the best way to achieve this goal. 
As such, we worked this semester to build a MIPS simulator built around the concept of dragging elements onto a 
workbench before connecting them together appropriately in a given length of time.
    

From the beginning, we knew that this would be a grand task that would take a broad scope of planning and general knowledge to carry 
out. Due to the nature of the MIPS ISA’s core instruction set being 58 instructions, we knew that we would be unable to complete a 
full one-to-one simulator. Consequently, we were unable to successfully complete the full implementation of all instructions in our 
application. 
    
Perhaps the biggest shortcoming of our application is the user interface. Despite setting out with the best intentions, working out 
the geometry for scaling and zooming a dynamic MIPS datapath is a massively complex task. Furthermore, given the free-place 
nature of the elements, the geometry involved in computing proper paths for connections between elements without colliding 
with other objects proved to be a nearly impossible task. As such, we chose to focus on the UI for a single datapath element: the 
ALU. Placing a single ALU on the game workbench within a game, a player is able to test all of the key connection functionalities 
of the game:
[1] Input connections cannot be selected prior to another output being selected.
[2] An output cannot be connected to another output.
[3] An input, once connected to an output, retains its connection, and it cannot be connected to another element.


Because the state of the UI makes the inner mechanics of this game effectively un testable, this document provides a walk through 
of the mechanisms at play in simulating the MIPS architecture, providing input validation, and for verifying accuracy of answers at
the end of a game.


