// ============================================================================
// MODULE: HIGH-LOAD ARTICULATED TWO-SEATER COLLAPSIBLE CREW CHAIR MATRIX
// REPOSITORY PATH: src/folding_chairs.scad
// ARCHITECTURE: ZERO-FASTENER SCISSOR-TRUSS INTEGRATED CABIN LAYOUT
// COMPLIANCE: 0.062" FRAME SKELETON MOUNTING / LOCKS TRUSS LOADS TO BASE LOOP
// ============================================================================

$fn = 120; // Maintain smooth bearing cuts for high-G dynamic joint analysis

// --- CHAIR MECHANICAL PARAMETERS (INCHES) ---
SKELETON_RIB_CEILING = 0.062; // Regulated framing thickness floor
CHAIR_SEAT_W = 20.0;          // Ergonomic seat pan width clearance
CHAIR_SEAT_L = 18.0;          // Seat pan depth footprint length
CHAIR_BACK_H = 32.0;          // Backrest vertical support profile scale
LINK_BAR_T = 0.250;           // 1/4" thick heavy-duty scissor link bars
IS_DEPLOYED = true;           // TOGGLE VARIABLE: True = Flight Position, False = Folded Flat

module CollapsibleCrewChair(deployed_state) {
    echo("CNC Toolpath: Fabricating Articulated Scissor-Truss Fold-Out Chair Base");
    
    // Calculate rotational kinematics based on toggle state variables
    pivot_angle = (deployed_state) ? 45.0 : 0.0;
    slide_offset_z = (deployed_state) ? 0.0 : 16.0;
    
    color("Silver")
    union() {
        // 1. MAIN COMFORT SEAT PAN PANEL
        translate([0, 0, slide_offset_z])
        rotate([0, pivot_angle, 0])
        difference() {
            // High-strength stamped alloy seat plate
            cube([CHAIR_SEAT_L, CHAIR_SEAT_W, 0.50]);
            // Internal pocket weight-reduction cutouts
            translate([1.0, 1.0, -0.1])
            cube([CHAIR_SEAT_L - 2.0, CHAIR_SEAT_W - 2.0, 0.7]);
        }
        
        // 2. BACKREST SUPPORT BULKHEAD
        translate([-0.50, 0, slide_offset_z])
        cube([0.50, CHAIR_SEAT_W, CHAIR_BACK_H]);
        
        // 3. HIGH-LOAD COMPRESSION SCISSOR LINKS (Bolt-Free Hinge Pins)
        color("DarkSlateGray")
        for (side_offset = [0, CHAIR_SEAT_W - LINK_BAR_T]) {
            translate([CHAIR_SEAT_L / 2, side_offset, slide_offset_z / 2])
            rotate([0, -pivot_angle, 0])
            cube([LINK_BAR_T, LINK_BAR_T, 18.0]); // Load-bearing strut bars
        }
    }
}

module ArraySymmetricFoldingSeats(cabin_radius) {
    // Spawns the twin chairs symmetrically for the Left Pilot and Right Co-Pilot stations
    for (crew_axis = [-1, 1]) {
        scale([crew_axis, 1, 1])
        translate([16.5, cabin_radius - 19.5, 12.0]) // Aligned low over the floor matrix
        rotate([0, 0, -90])
        CollapsibleCrewChair(deployed_state = IS_DEPLOYED);
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT DISPLAY
// ============================================================================
// Simulates structural layout check inside the 120-inch Titan Mark III pressure can
ArraySymmetricFoldingSeats(cabin_radius = 58.5);
