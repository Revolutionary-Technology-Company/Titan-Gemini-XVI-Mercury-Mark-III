// ============================================================================
// MODULE: TITAN GEMINI XVI AVIONICS CHASSIS HOUSING CARD BAY
// REPOSITORY PATH: src/avionics_bay.scad
// HARDWARE REQUIREMENT: INTEGRATED SLIDE-CHANNELS (ZERO-BOLT FLANGE DESIGN)
// COMPLIANCE: 0.062" SKELETON WALL THICKNESS RATIO CEILING (DOC ENFORCED)
// ============================================================================

$fn = 120; // Maintain crisp edge radii for precise snap-fit PCB slider slots

// --- AVIONICS BAY CONFIGURATION CONSTANTS (INCHES) ---
SKELETON_CEILING = 0.062;    // Regulated "Mining Hat" structural framework floor
CHASSIS_WIDTH = 14.5;        // Width of the central motherboard bay housing
CHASSIS_HEIGHT = 16.0;       // Vertical clearance profile for multi-layer card stacks
PCB_SLOT_W = 0.093;          // Standard width of heavy-duty 2oz/3oz gold-lattice PCB boards
PCB_SLOT_D = 0.125;          // Depth of the tracking channel cut into the casing walls
NUM_SLOTS = 4;               // Number of parallel card bays in the stack

module MultiLayerAvionicsCardBay() {
    echo("CNC Toolpath: Milling Zero-Fastener Avionics Card Bay Casing; Slots =", NUM_SLOTS);
    
    color("DarkSlateGray")
    difference() {
        // 1. Primary raw solid titanium-aluminum block stock (Enforces structural rigidity)
        cube([CHASSIS_WIDTH, 6.0, CHASSIS_HEIGHT], center = true);
        
        // 2. Central hollowing pass to clear out weight-reduction interior volume
        cube([CHASSIS_WIDTH - 1.0, 5.8, CHASSIS_HEIGHT - 1.0], center = true);
        
        // 3. PARALLEL CNC SLIDER CHANNELS: Carving the vertical tracks for the KiCad boards
        for (slot = [0 : 1 : NUM_SLOTS - 1]) {
            slot_offset_y = -2.0 + (slot * 1.25);
            
            // Left-Side Vertical Tracking Slot
            translate([-CHASSIS_WIDTH / 2 + PCB_SLOT_D / 2, slot_offset_y, 0])
            cube([PCB_SLOT_D + 0.01, PCB_SLOT_W, CHASSIS_HEIGHT + 0.1], center = true);
            
            // Right-Side Vertical Tracking Slot
            translate([CHASSIS_WIDTH / 2 - PCB_SLOT_D / 2, slot_offset_y, 0])
            cube([PCB_SLOT_D + 0.01, PCB_SLOT_W, CHASSIS_HEIGHT + 0.1], center = true);
        }
    }
}

module IntegratedChassisMounts(cabin_radius) {
    // Hooks your finished avionics casing block directly to the 0.062" internal stringer ribs
    translate([0, cabin_radius - 2.5, 20.0]) // Positioned safely low on the cabin wall skeleton
    union() {
        MultiLayerAvionicsCardBay();
        
        // Bottom running weight-bearing step flange
        translate([0, -3.0, -CHASSIS_HEIGHT / 2 - SKELETON_CEILING])
        color("Silver")
        cube([CHASSIS_WIDTH + 1.0, 1.5, SKELETON_CEILING * 4], center = true);
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT DISPLAY
// ============================================================================
// Simulates the internal electronics rack installation audit
IntegratedChassisMounts(cabin_radius = 58.5); // Scaled for the 120-inch Titan hull
