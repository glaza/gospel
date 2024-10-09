
AMPLITUDE = 500;

WAVEFORM = concat(
    zero(666),
    
    // One
    ramp(333, 0, AMPLITUDE),
    [-AMPLITUDE],
    zero(666),
    
    // Two
    curveUp(333, -AMPLITUDE, AMPLITUDE),
    waveDown(333, AMPLITUDE, -AMPLITUDE),
    [AMPLITUDE],
    zero(333),
    
    // Three
    [-AMPLITUDE, AMPLITUDE],
    ramp(222, AMPLITUDE, -AMPLITUDE/2),
    curveUp(222, -AMPLITUDE/2, AMPLITUDE),
    curveDown(222, AMPLITUDE, -AMPLITUDE),
    zero(333),
    
    // Four
    [AMPLITUDE],
    zero(666),
    [AMPLITUDE, -AMPLITUDE],
    zero(333),
    
    // Five
    [AMPLITUDE, -AMPLITUDE],
    flat(222, -AMPLITUDE),
    curveUp(222, -AMPLITUDE, AMPLITUDE),
    curveDown(222, AMPLITUDE, -AMPLITUDE),
    zero(333),
    
    // Six
    inverse(curveUp(222, -AMPLITUDE, AMPLITUDE)),
    switch(
        curveUp(111, -AMPLITUDE, AMPLITUDE),
        flat(111, -AMPLITUDE)
    ),
    switch(
        curveDown(111, AMPLITUDE, 0),
        inverse(curveDown(111, AMPLITUDE, 0))
    ),
    zero(333)
);

scale([1, 1, 1])
for (i = [0 : len(WAVEFORM) - 1]) {
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
        
function switch(vec1, vec2) =
    [
        for (i = [0 : 2 : len(vec1) + len(vec2)])
        ((i/2)%2)*vec1[i/2]+(((i/2)+1)%2*vec2[i/2])
    ];