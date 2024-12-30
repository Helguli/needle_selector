// Constant values for the needle selector


// You may want to modify theese if you want to adapt it to another machine
needle_spacing = 6.5; // Distance between the center of two needles 6.5 mm on the LK150
needle_width = 6;     // Width of the needle / comb tooth


// You do not want to modify theese...
needle_width_difference = needle_spacing - needle_width; // spacing - width
selector_length = 10;       // Comb tooth length, 10 mm
thickness = 2.55;           // Thickness of the comb
depth = 1.6;                // Thickness of the thinnest part
selector_body_width = 18;   // Width of the comb body
spike_width = 4;            // Width of the spike (that triangle thing at the end of the first and last tooth
spike_length = 2;           // Length of the spike
spike_thickness = depth;    // Thickness of the spike = thinnest part
$fn = 96;
diff = needle_width / 2 - needle_width / 2 * cos(180 / $fn);
