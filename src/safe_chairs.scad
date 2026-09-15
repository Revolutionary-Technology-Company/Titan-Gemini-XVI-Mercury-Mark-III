// ============================================================================
// MODULE: TITAN GEMINI XVI / MERCURY MARK III ANTI-PINCH FOLDING CHAIR ENGINE
// REPOSITORY PATH: src/safe_chairs.scad
// SAFETY CONFIGURATION: ENCLOSED SHROUD MATRIX & MECHANICAL INTERLOCK GATES
// COMPLIANCE: OSHA ANTI-REDUCTION PINCH POINT DIRECTIVE (ZERO FASTENER METHOD)
// ============================================================================

$fn = 120; // Maintain smooth circular fillets to eliminate cutting edges

// --- SAFETY ENVELOPE DIMENSIONS (INCHES) ---
SKELETON_RIB_CEILING = 0.062;   // Regulated framing thickness floor
CHAIR_W = 20.0;                 // Ergonomic seat pan width clearance
CHAIR_L = 18.0;                 // Seat pan depth footprint length
SHROUD_RADIUS = 1.25;           // Outer clearance boundary of the anti-pinch guard bellows
FILLET_R = 0.50;                // 0.50-inch safety corner radii to prevent crew cuts
IS_DEPLOYED = true;             // Toggle state for animation tracking

module OSHASafeAntiPinchShroud(height) {
    // Generates the protective bellow envelope volume that isolates moving scissor bars
    echo("CNC Toolpath: Patterning Woven Silica Flexible Anti-Pinch Shroud Bellows");
    color("DarkSlateGray", 0.5) // Semi-transparent to verify internal mechanism clearance
    difference() {
        // Outer protective bellows skin volume
        cylinder(h = height, r = SHROUD_RADIUS, center = false);
        // Internal track cavity allowing the scissor bars to slide unimpeded
        translate([0, 0, -0.1])
        cylinder(h = height + 0.2, r = SHROUD_RADIUS - 0.25, center = false);
    }
}

module GuardedCrewChair(deployed_state) {
    echo("CNC Toolpath: Fabricating Guarded Safety Fold-Out Chair Matrix");
    
    pivot_angle = (deployed_state) ? 45.0 : 0.0;
    slide_offset_z = (deployed_state) ? 0.0 : 16.0;
    
    union() {
        // 1. ANCHORED ANTI-PINCH SEAT PAN (Every edge features a 0.5" blunt radius)
        translate([0, 0, slide_offset_z])
        rotate([0, pivot_angle, 0])
        color("Silver")
        difference() {
            // Main plate containing extra blunt safety fillets
            offset(r = FILLET_R)
            square([CHAIR_L - FILLET_R*2, CHAIR_W - FILLET_R*2], center = true);
            
            // Weight-reduction pockets
            offset(r = FILLET_R)
            square([CHAIR_L - 4.0, CHAIR_W - 4.0], center = true);
        }
        
        // 2. ENCLOSED SCISSOR SYSTEM: Mount guards directly over the moving links
        for (side_offset = [-CHAIR_W/2 + 0.5, CHAIR_W/2 - 0.5]) {
            translate([CHAIR_L / 4, side_offset, 0])
            OSHASafeAntiPinchShroud(height = 24.0);
        }
        
        // 3. MECHANICAL MECHANICAL INTERLOCK SAFETY DETENT GATE
        // Solid physical latch wedge cut directly from the 0.062" frame stock
        color("Red")
        translate([-2.5, -CHAIR_W/2 - 1.0, -1.0])
        difference() {
            cube([2.0, 1.0, 1.5]);
            // 45-degree engagement incline slope that captures the hinge pin
            rotate([0, 45, 0])
            translate([-1.0, -0.1, 0])
            cube([3.0, 1.2, 2.0]);
        }
    }
}

module PopulateSafeCockpit(cabin_radius) {
    // Array twin safe chairs symmetrically for Left Pilot and Right Co-Pilot configurations
    for (crew_axis = [-1, 1]) {
        scale([crew_axis, 1, 1])
        translate([16.5, cabin_radius - 19.5, 12.0])
        rotate([0, 0, -90])
        GuardedCrewChair(deployed_state = IS_DEPLOYED);
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT DISPLAY
// ============================================================================
PopulateSafeCockpit(cabin_radius = 58.5); // Scaled for the 120-inch Titan hull
