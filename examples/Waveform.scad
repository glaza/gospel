
AMPLITUDE = 10;

WAVEFORM = concat(
    zero(399),
    
    // One
    ramp(99, 0, AMPLITUDE),
    [-AMPLITUDE],
    zero(299),
    
    // Two
    curveUp(149, -AMPLITUDE, AMPLITUDE),
    waveDown(249, AMPLITUDE, -AMPLITUDE),
    [AMPLITUDE],
    zero(99),
    
    // Three
    [-AMPLITUDE, AMPLITUDE],
    ramp(149, AMPLITUDE, -AMPLITUDE/2),
    curveUp(124, -AMPLITUDE/2, AMPLITUDE),
    curveDown(124, AMPLITUDE, -AMPLITUDE),
    zero(199),
    
    // Four
    [AMPLITUDE],
    zero(199),
    [AMPLITUDE, -AMPLITUDE],
    zero(199),
    
    // Five
    [AMPLITUDE, -AMPLITUDE],
    flat(149, -AMPLITUDE),
    curveUp(124, -AMPLITUDE, AMPLITUDE),
    curveDown(124, AMPLITUDE, -AMPLITUDE),
    zero(99),
    
    // Six
    inverse(curveUp(199, -AMPLITUDE, AMPLITUDE)),
    switch(
        curveUp(99, -AMPLITUDE, AMPLITUDE),
        flat(99, -AMPLITUDE)
    ),
    switch(
        curveDown(99, AMPLITUDE, 0),
        inverse(curveDown(99, AMPLITUDE, 0))
    ),
    zero(99),
    
    // Seven
    [-AMPLITUDE, AMPLITUDE],
    ramp(199, AMPLITUDE, 0),
    [-AMPLITUDE/2, AMPLITUDE/2],
    ramp(199, 0, -AMPLITUDE),
    zero(99),
    
    // Eight
    switch(
        curveUp(99, 0, 0.8*AMPLITUDE),
        inverse(curveUp(99, 0, 0.8*AMPLITUDE))
    ),
    switch(
        curveDown(99, 0.8*AMPLITUDE, 0),
        inverse(curveDown(99, 0.8*AMPLITUDE, 0))
    ),
    switch(
        curveUp(99, 0, AMPLITUDE),
        inverse(curveUp(99, 0, AMPLITUDE))
    ),
    switch(
        curveDown(99, AMPLITUDE, 0),
        inverse(curveDown(99, AMPLITUDE, 0))
    ),
    zero(99),
    
    // Nine
    switch(
        curveUp(99, 0, AMPLITUDE),
        inverse(curveUp(99, 0, AMPLITUDE))
    ),
    switch(
        flat(99, AMPLITUDE),
        curveDown(99, -AMPLITUDE, 0)
    ),
    inverse(curveDown(199, -AMPLITUDE, AMPLITUDE)),
    zero(300)
);

scale([1, 1, 1])
for (i = [0 : len(WAVEFORM) - 1]) {
//    if (i > 4990)
//    echo(i, WAVEFORM[i]);
    
    translate([i, 0, 0])
    scale([1, WAVEFORM[i], 1])
    square(1);
}

function flat(range, value) =
    [for (i = [0 : range - 1]) value];
    
function zero(range) =
    flat(range, 0);
    
function ramp(range, start, end) =
    [for (i = [0 : range]) i * (end - start) / range + start];
    
function curveUp(range, start, end) =
    [for (i = [0 : range]) (end-start)*sqrt(1-((i/range-1)*(i/range-1)))+start];
    
function curveDown(range, start, end) =
    [for (i = [0 : range]) (start-end)*sqrt(1-(i/range*i/range))+end];

function inverse(vec) =
    [for (i = [0 : len(vec) - 1]) -vec[i]];

function waveDown(range, start, end) =
    [for (i = [0 : range]) (start-end)*(1+cos(180*i/range))/2+end];
        
function switch(vec1, vec2) = [
    for (i = [0 : 2 : len(vec1) + len(vec2) - 2])
    ((i/2)%2)*vec1[i/2]+(((i/2)+1)%2*vec2[i/2])
];