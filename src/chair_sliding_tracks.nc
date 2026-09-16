( ============================================================================ )
( CNC TOOLPATH: HIGH-LOAD VERTICAL SLIDING TRACKS FOR COLLAPSIBLE CHAIRS       )
( REPOSITORY FILENAME: src/chair_sliding_tracks.nc                            )
( STRUCTURAL COMPLIANCE: 0.062" MAXIMUM SKELETON WALL RATIO CEILING           )
( HARDWARE BASE: 5-AXIS GANTRY MILL / HIGH-PRESSURE FLOOD COOLANT HIGH-FEED    )
( CONFIGURATION: COMPRESSION TRUSS SLIDER FOR 605 LBS PAYLOAD VELOCITY LOADS   )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z3.5 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Height Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 11: 0.1875" THREE-FLUTE COATED CARBIDE HIGH-PERFORMANCE SLOTTING ENDMILL )
T11 M06 ( Execute Automated Mechanical Tool Change Sequence )
S2600 M03 ( Engage Spindle Drive: 2600 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant System Pump Line Flow )

( ============================================================================ )
( STAGE 1: ROUTING TRACK CHANNELS FOR THE LEFT SEAT (COMMAND PILOT STATION)    )
( ============================================================================ )
G00 X16.500 Y39.000 ( Rapid Drive to Left-Seat Core Frame Anchor Center Line )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F10.0 ( Plunge Cutter to Maximum Regulated Framework Depth Baseline )
G03 X16.500 Y39.000 I0.0625 J0.0 F6.5 ( Helical Spiral Core Peeling Entry Wave Toolpath )

( Carve the 24-Inch Vertical Sliding Slot Down the Frame Rib )
G01 Z-24.000 F5.5 ( Controlled Down-Feed Cut to Bottom Step Limit Wall )
G00 Z3.500 ( Rapid Vertical Lift Clear of Left Channel )

( ============================================================================ )
( STAGE 2: ROUTING TRACK CHANNELS FOR THE RIGHT SEAT (CO-PILOT STATION)        )
( ============================================================================ )
G00 X-16.500 Y39.000 ( Rapid Cross-Over Travel to Right-Seat Mirror Slot Target )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F10.0 ( Engage Mill to Framing Floor Level )
G03 X-16.500 Y39.000 I0.0625 J0.0 F6.5 ( Mirror Helical Spiral Entry Wave )

( Carve Mirror 24-Inch Vertical Sliding Slot Down the Frame Rib )
G01 Z-24.000 F5.5 ( Controlled Down-Feed Cut to Bottom Step Limit Wall )

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z3.500 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )
