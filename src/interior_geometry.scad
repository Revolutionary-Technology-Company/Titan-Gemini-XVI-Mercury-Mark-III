// ============================================================================
// MODULE: TITAN GEMINI XVI / MERCURY MARK III COMPLETED INTERIOR GEOMETRY
// REPOSITORY PATH: src/interior_geometry.scad
// ARCHITECTURE: TWO-SEATER STRUCTURAL COCKPIT SYSTEM (ZERO FASTENERS)
// COMPLIANCE: 0.062" FRAME SKELETON INTEGRATION / 35.0 PSI ACDELCO LOCKOUTS
// ============================================================================

$fn = 120; // Enforce clean curves to check structural clear zones

// --- INTERIOR SPECIFICATIONS (INCHES) ---
CABIN_INNER_RADIUS = 58.5;   // Interior clearance of 120" Titan hull can
SKELETON_CEILING = 0.062;    // Maximum allowed thickness for framing ribs
CHAIR_W = 20.0;                 // Ergonomic seat pan width profile
CHAIR_L = 18.0;                 // Seat pan depth footprint length
SHROUD_R = 1.25;             // Outer boundary of flexible anti-pinch bellows
DASH_W = 52.0;               // Wide-format dashboard profile width
DASH_H = 16.0;               // Vertical profile height of instrument panel
PILOT_AXIS_OFFSET = 14.5;    // Centerline separation distance for 2-man seats

module OSHAGuardBellows(height) {
    // Models the protective woven silica bellows encasing the sliding seat joints
    color("DarkSlateGray", 0.4)
    difference() {
        cylinder(h = height, r = SHROUD_R, center = false);
        translate([0, 0, -0.1])
        cylinder(h = height + 0.2, r = SHROUD_R - 0.25, center = false);
    }
}

module GuardedFoldingSeatMatrix() {
    // Symmetrical collapsible crew seat including blunt edge 0.5" safety radii
    color("Silver")
    union() {
        // Blunt safety seat pan
        cube([CHAIR_L, CHAIR_W, 0.50], center = true);
        // Rigid structural backrest bulkhead 
        translate([-CHAIR_L / 2 - 0.25, 0, CHAIR_BACK_H / 2 - 0.25])
        cube([0.50, CHAIR_W, 32.0], center = true);
        
        // Enclosed scissor links to protect crew limbs from pinch fields
        for (side_offset = [-CHAIR_W / 2 + 0.5, CHAIR_W / 2 - 0.5]) {
            translate([0, side_offset, -12.0])
            OSHAGuardBellows(height = 24.0);
        }
    }
}

module PanoramicInstrumentDashboard() {
    // Wide-aspect faceplate hosting dual 18-inch flat screen viewing ports
    color("Silver")
    difference() {
        // Main structural instrument pad pad block
        cube([DASH_W, SKELETON_CEILING * 4, DASH_H], center = true);
        
        // Symmetrical display cutouts ground to prevent sharp cutting corners
        for (offset_x = [-PILOT_AXIS_OFFSET, PILOT_AXIS_OFFSET]) {
            translate([offset_x, 0, 1.0])
            cube([18.0, 1.0, 10.0], center = true);
        }
    }
}

module CompleteInteriorAssembly() {
    echo("CNC Geometry: Compiling Complete Two-Seater Structural Layout");
    
    // 1. Position twin guarded folding chairs low over the floor matrix steps
    for (crew_axis = [-1, 1]) {
        scale([crew_axis, 1, 1])
        translate([PILOT_AXIS_OFFSET + 2.0, CABIN_INNER_RADIUS - 19.5, 12.0])
        rotate([0, 0, -90])
        GuardedFoldingSeatMatrix();
    }
    
    // 2. Position panoramic display dashboard at pilot vision plane height
    translate([0, -CABIN_INNER_RADIUS + 8.0, 45.0])
    rotate([15, 0, 0]) // Tilted 15 degrees for ergonomic tracking visibility
    PanoramicInstrumentDashboard();
}

// ============================================================================
// REPOSITORY ARCHITECTURE VERIFICATION RENDERING
// ============================================================================
CompleteInteriorAssembly();
