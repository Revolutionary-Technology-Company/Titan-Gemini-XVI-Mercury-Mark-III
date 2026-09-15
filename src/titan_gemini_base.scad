// ============================================================================
// MODULE: TITAN GEMINI XVI MERCURY MARK III HEAVY BASE FORGING
// HARDWARE REQUIREMENT: 120-INCH CORE BOOSTER INTERFACE COMPATIBLE
// COMPLIANCE: 0.062" FRAME CEILING / ZERO-BOLT COARSE LAYOUT (DOC ENFORCED)
// ============================================================================

$fn = 240; // Maximum circular accuracy for heavy CNC lathe turning paths

// --- TITAN-SCALE DIMENSIONS PROFILE (INCHES) ---
TITAN_CORE_OD = 120.0;       // Core launch vehicle diameter (3.05 meters)
SEWER_PLATE_WALL = 1.50;     // Solid block thickness for primary load forging
SKIN_SHEET_THICK = 0.025;    // Stamped titanium cabin pressure skin base layer
FRAME_RIB_MAX = 0.062;       // Maximum allowed "Mining Hat" internal rib thickness
BUS_WAY_W = 0.3125;          // Sizing track for 16-state induction bus loops

module TitanHeavyBaseRingForging() {
    echo("CNC Track: Turning 120-Inch Titan Skirt Flange from Solid Titanium Stock");
    color("Silver")
    difference() {
        // 1. Primary heavy-wall cylinder ring blank stock (3.5" overall height)
        cylinder(h = 3.5, r = TITAN_CORE_OD / 2, center = true);
        
        // 2. Central interior borehole clearing space for payload equipment
        translate([0, 0, -2.0])
        cylinder(h = 6.0, r = (TITAN_CORE_OD / 2) - SEWER_PLATE_WALL);
        
        // 3. Upper Step Shoulder: Precision shelf to flush-weld your 0.025" cabin skins
        translate([0, 0, 1.0])
        cylinder(h = 1.0, r = (TITAN_CORE_OD / 2) - SKIN_SHEET_THICK);
        
        // 4. Four Symmetrical Split-Band Separation Grooves (90-degree offsets)
        for (slot = [0 : 90 : 270]) {
            rotate([0, 0, slot])
            translate([TITAN_CORE_OD / 2 - 0.5, -2.0, -2.0])
            cube([1.0, 4.0, 4.0]); // Machined latch pockets for booster hooks
        }
    }
}

module TitanScaleFloorMatrix() {
    echo("CNC Track: Milling 12-Spoke High-Load Radial Floor Matrix");
    color("DarkSlateGray")
    union() {
        // 12 primary structural load-spoke ribs radiating from the center core
        for (spoke = [0 : 30 : 360]) {
            rotate([0, 0, spoke])
            translate([0, -FRAME_RIB_MAX / 2, -1.0])
            cube([(TITAN_CORE_OD / 2) - SEWER_PLATE_WALL + 0.1, FRAME_RIB_MAX, 1.0]);
        }
        
        // Concentric load distribution stiffener ring tracks
        for (r_step = [TITAN_CORE_OD / 4, TITAN_CORE_OD / 3]) {
            difference() {
                translate([0, 0, -1.0]) cylinder(h = 1.0, r = r_step);
                translate([0, 0, -1.1]) cylinder(h = 1.2, r = r_step - FRAME_RIB_MAX);
            }
        }
    }
}

module SnapCircuit16StateBaseBus() {
    echo("CNC Track: Engraving 16-State Hexadecimal Bus Channels");
    color("Gold")
    translate([0, 0, 1.6]) // Embedded directly into the base ring internal lip
    difference() {
        cylinder(h = 0.04, r = (TITAN_CORE_OD / 2) - SEWER_PLATE_WALL - 0.2);
        cylinder(h = 0.10, r = (TITAN_CORE_OD / 2) - SEWER_PLATE_WALL - 0.2 - BUS_WAY_W);
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT
// ============================================================================
union() {
    TitanHeavyBaseRingForging();
    TitanScaleFloorMatrix();
    SnapCircuit16StateBaseBus();
}
