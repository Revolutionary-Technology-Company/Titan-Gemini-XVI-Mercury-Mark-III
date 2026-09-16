// ============================================================================
// MODULE: TITAN GEMINI XVI / MERCURY MARK III FINAL COMPREHENSIVE ASSEMBLY
// REPOSITORY PATH: src/mark3_final_assembly.scad
// ARCHITECTURE: FULL-SCALE COMPILATION - ALL MISSING INTERNAL ELEMENTS POPULATED
// COMPLIANCE: 0.062" SKELETON WALL THICKNESS TRACE STANDARD (ZERO-FASTENER METHOD)
// ============================================================================

$fn = 120; // High resolution triangulation for structural clearance analysis

// --- MASTER SYSTEM CONSTANTS (INCHES) ---
TITAN_BASE_OD = 120.0;       // Core booster attachment diameter
CAPSULE_TOP_OD = 24.0;       // Apex parachute deck flange diameter
CORE_HEIGHT = 135.0;         // Extended Conical Height of Capsule Can
FORGING_WALL = 1.50;         //DOC-Approved "Sewer Plate" heavy ring solid thickness
FRAME_MAX_CEILING = 0.062;   // Regulated "Mining Hat" internal rib thickness floor
SKIN_SHEET_THICK = 0.025;    // Stamped Titanium Shell Base Sheet
PILOT_SEAT_OFFSET = 14.5;    // Centerline separation distance for 2-man seats

use <mark3_complete_assembly.scad>
use <safe_chairs.scad>
use <interior_geometry.scad>

module PressurizedCabinCanister() {
    // Generates the core airtight "Titanium Can" pressure vessel volume
    echo("Milling Inner Pressure Can. Base Sheet Thickness =", SKIN_SHEET_THICK);
    difference() {
        cylinder(h = CORE_HEIGHT, r1 = TITAN_BASE_OD/2, r2 = CAPSULE_TOP_OD/2, center = false);
        translate([0, 0, -0.1])
        cylinder(h = CORE_HEIGHT + 0.2, r1 = (TITAN_BASE_OD/2) - SKIN_SHEET_THICK, r2 = (CAPSULE_TOP_OD/2) - SKIN_SHEET_THICK, center = false);
    }
}

module InternalSkeletonGrid() {
    // Patterns the dense vertical stringers and horizontal Z-frames
    echo("Milling Internal 0.062\" Honeycomb Grid Reinforcement");
    color("DarkSlateGray")
    union() {
        // 36 primary vertical hat-stringers to distribute launch G-forces uniformly
        for (rib = [0 : 10 : 360]) {
            rotate([0, 0, rib])
            translate([TITAN_BASE_OD/2 - FRAME_MAX_CEILING, -0.5, 0])
            rotate([0, -atan(((TITAN_BASE_OD/2)-(CAPSULE_TOP_OD/2))/CORE_HEIGHT), 0])
            cube([FRAME_MAX_CEILING, 1.0, CORE_HEIGHT * 1.1]);
        }
    }
}

// ============================================================================
// REPOSITORY ARCHITECTURE UNIFIED ASSEMBLY RENDER
// ============================================================================
union() {
    // 1. Primary Pressure Vessel Envelope (Your flanged, seam-welded structure)
    color("LightBlue", 0.3) PressurizedCabinCanister();
    InternalSkeletonGrid();
    
    // 2. Heavy 120" Base Adapter Forging Ring
    translate([0, 0, -2.0]) HeavyTitanBaseRing();
    translate([0, 0, -0.25]) TitanScaleFloorMatrix();
    
    // 3. Symmetrical Dual-Seat Guarded Folding Chairs
    for (crew_axis = [-1, 1]) {
        scale([crew_axis, 1, 1])
        translate([PILOT_SEAT_OFFSET + 2.0, (TITAN_BASE_OD / 2) - 19.5, 12.0])
        rotate([0, 0, -90])
        GuardedCrewChair(deployed_state = true);
    }
    
    // 4. Panoramic Instrument Panel & Dual Overhead Ingress Hatches
    translate([0, -(TITAN_BASE_OD / 2) + 8.0, 45.0])
    rotate() 
    PanoramicInstrumentDashboard();
    
    SymmetricOverheadHatchFrame();
}
