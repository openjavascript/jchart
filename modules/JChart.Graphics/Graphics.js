;(function(define, _win) { 'use strict'; define( [ 'JC.BaseMVC', 'Raphael' ], function(){

    Raphael.fn.triangle = function(x, y, size) {
      var half = size / 2, path = ["M", x, y - size ];
      path = path.concat(["L", (x + size), (y + half)]);
      path = path.concat(["L", (x - size), (y + half)]);
      return this.path(path.concat(["z"]).join(" ")).attr( 'fill', '#fff' );
    };

    Raphael.fn.legendLine = function( rx, ry, rwidth, rheight, csize ) {
      var half = ( rwidth - csize ) / 2
        , chalf = csize / 2
        , path = ["M", rx, ry ]
        ;

      path = path.concat( ["L", rx + half, ry ] );
      path = path.concat( ["C"
                            , rx + half + chalf, ry - chalf
                            , rx +  half + chalf, ry - chalf
                            , rx + half + csize, ry ] );

      path = path.concat( [ "L", rx + rwidth,  ry ] );

      path = path.concat( [ "L", rx + rwidth, ry + rheight  ] );
      path = path.concat( [ "L", rx + rwidth - half, ry + rheight  ] );

      path = path.concat( ["C"
                            , rx + half + chalf, ry + rheight + chalf
                            , rx + half + chalf, ry + rheight + chalf
                            , rx + half, ry + rheight ] );
      path = path.concat( [ "L", rx, ry + rheight ] );
      /*

      */
      path = path.concat( [ "L", rx, ry ] );

      return this.path(path.concat(["z"]).join(" "))
          .attr( 'fill', '#9c9c9c' )
          .attr( 'stroke', '#9c9c9c' );
          ;
    };

});}( typeof define === 'function' && define.amd ? define : 
        function ( _name, _require, _cb ) { 
            typeof _name == 'function' && ( _cb = _name );
            typeof _require == 'function' && ( _cb = _require ); 
            _cb && _cb(); 
        }
        , window
    )
);
