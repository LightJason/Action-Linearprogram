/*
 * @cond LICENSE
 * ######################################################################################
 * # LGPL License                                                                       #
 * #                                                                                    #
 * # This file is part of the LightJason                                                #
 * # Copyright (c) 2015-19, LightJason (info@lightjason.org)                            #
 * # This program is free software: you can redistribute it and/or modify               #
 * # it under the terms of the GNU Lesser General Public License as                     #
 * # published by the Free Software Foundation, either version 3 of the                 #
 * # License, or (at your option) any later version.                                    #
 * #                                                                                    #
 * # This program is distributed in the hope that it will be useful,                    #
 * # but WITHOUT ANY WARRANTY; without even the implied warranty of                     #
 * # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                      #
 * # GNU Lesser General Public License for more details.                                #
 * #                                                                                    #
 * # You should have received a copy of the GNU Lesser General Public License           #
 * # along with this program. If not, see http://www.gnu.org/licenses/                  #
 * ######################################################################################
 * @endcond
 */

// -----
// agent for testing linear-program actions
// @iteration 2
// @testcount 2
// -----

// initial-goal
!test.

/**
 * base test
 */
+!test <-
    !testlpmaximize;
    !testlpminimize
.


/**
 * test LP solver minimize
 */
+!testlpminimize <-
        LP = .math/linearprogram/create( 2, 2, 1, 0 );
        .math/linearprogram/valueconstraint( LP, 1, 1, 0, ">=", 1 );
        .math/linearprogram/valueconstraint( LP, 1, 0, 1, ">=", 1 );
        .math/linearprogram/valueconstraint( LP, 0, 1, 0, ">=", 1 );

        [LPValue | LPPointCount | LPPoints] = .math/linearprogram/solve( LP, "minimize", "non-negative" );
        .test/print("LP solve minimize", LPValue, LPPointCount, LPPoints);

        R = LPValue == 3.0;
        .test/result( R, "LP solver minimize incorrect" )
.


/**
 * test LP solver maximize
 */
+!testlpmaximize <-
        LP = .math/linearprogram/create( 0.8, 0.2, 0.7, 0.3, 0.6, 0.4, 0 );
        .math/linearprogram/valueconstraint( LP, 1, 0, 1, 0, 1, 0,  "=", 23 );
        .math/linearprogram/valueconstraint( LP, 0, 1, 0, 1, 0, 1,  "=", 23 );
        .math/linearprogram/valueconstraint( LP, 1, 0, 0, 0, 0, 0, ">=", 10 );
        .math/linearprogram/valueconstraint( LP, 0, 0, 1, 0, 0, 0, ">=", 8 );
        .math/linearprogram/valueconstraint( LP, 0, 0, 0, 0, 1, 0, ">=", 5 );

        [LPValue | LPPointCount | LPPoints] = .math/linearprogram/solve( LP, "maximize", "non-negative" );
        .test/print("LP solve maximize", LPValue, LPPointCount, LPPoints);

        R = LPValue == 25.800000000000004;
        .test/result( R, "LP solver maximize incorrect" )
.
