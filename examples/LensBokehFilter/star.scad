module star(p=5, r1=4, r2=10) {
  s = [for(i=[0:p*2]) 
    [
      (i % 2 == 0 ? r1 : r2)*cos(180*i/p),
      (i % 2 == 0 ? r1 : r2)*sin(180*i/p)
    ]
  ];
    
  polygon(s);
}
