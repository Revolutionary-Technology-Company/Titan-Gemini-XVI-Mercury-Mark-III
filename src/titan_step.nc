( ============================================================================ )
( CNC TOOLPATH: 120-INCH TITAN ADAPTER RING DOUBLE-SEAM POCKET SHELF           )
( REGULATORY REQUIREMENT: DOC-APPROVED SEWER-PLATE THICKNESS (1.50" WALL)     )
( CONFIGURATION: COMPRESSION WELD TRACK STEP FOR 0.025" STAMPED ALLOY SKINS    )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z4.0 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 02: 2.000" DIAMETER HEAVY-DUTY SEWER-PLATE FACING MILL WITH INDEXABLE CARBIDE INSERTS )
T02 M06 ( Execute Automated Mechanical Tool Change Sequence )
S950 M03 ( Engage Spindle Drive: 950 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant to Prevent Titanium Tears )

( --- HEAVY CNC PROFILE SHOULDER STEPPING ROUTINE --- )
G00 X60.000 Y-4.000 ( Rapid Drive to Outer 60-Inch Flange Edge Starting Alignment Vector )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

( --- ROUGHING RADIAL INFED STEP 1 --- )
G01 Z-0.125 F10.0 ( Controlled Depth Engagement Plunge Move Into 1.50" Solid Forging )
G02 X60.000 Y-4.000 I-60.000 J4.000 F6.5 ( Automated 360-Degree Face Turning Step Cut )

( --- ROUGHING RADIAL INFED STEP 2 --- )
G01 Z-0.250 F10.0 ( Deeper Vertical Axis Plunge Pass to Reach Flange Joint Baseline )
G02 X60.000 Y-4.000 I-60.000 J4.000 F6.5 ( Complete Secondary High-Torque Facing Circle )

( --- FINAL COMPLIANCE FINISHING PASS --- )
G01 Z-0.375 F8.0 ( Final Pocket Depth Entry - Cutting the Seam Weld Track )
G02 X60.000 Y-4.000 I-60.000 J4.000 F5.0 ( Ultra-Precision Surface Shaving Turn Pass )

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z4.000 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )
