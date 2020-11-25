import std.stdio;
import std.conv;
import helper;

void main()
{
	    auto p = Point2D!double(1,2);

    auto p11 = Point2D!double(1,2);
        auto p22 = Point2D!double(3,4);
        auto p33 = p11+p22;
        writeln(p33.dist());
        assert(p33.x == 4);
        assert(p33.y == 6);
        p33+=p11;


    auto a = Point2D!double(0,2);
	auto a2 = Point2D!double(3,0);
	auto b = Point2D!double(0,0);
	auto c = Point2D!double(1,1);
    //     auto b = Point2D!double(4,0);
    //     auto v = Vect2D!(double)(a,b);
    // v.turn(3.14159/2);


	int[][] matrix = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ]
];
assert(matrix[0][0] == 1);
assert(matrix[0][1] == 2);


auto ggg = array_generator(3,5);
//PutPotential!double(3,1,ggg,10,10,a);
//PutPotential!double(3, 1, ggg, 10,10, b);
PutPotential!double(3, 1, ggg, a);
//PutPotential!double(3, 1, ggg, a2);

auto ff = getSumOfVectorOnInfluenseMap!double(Point2D!double(0,0),Point2D!double(1,0), ggg);
auto dcc = GetMinPotentialByRadius!double(1, ggg, Point2D!double(0,0));
auto ff2 = getSumOfVectorOnInfluenseMap!double(Point2D!double(0,0),dcc, ggg);
// // PutAvgPotential!double(6.5, 0.5, ggg, 10,10, b);
// for(int x=0;x<5;x++){
//     for(int y=0;y<3;y++){
//     write((ggg[y][x]).to!string~" ");
//     }
// 	writeln();
// }
writeln(ggg[dcc.x.to!ulong][dcc.y.to!ulong]);

writeln(ggg[2][0]);
foreach(ref rw ; ggg)
    {
        writeln(rw);
    }

	writeln("Edit source/app.d to start your project.");
}

unittest{

    auto p = Point2D!double(1,2);

    auto p11 = Point2D!double(1,2);
        auto p22 = Point2D!double(3,4);
        auto p33 = p11+p22;
        writeln(p33.dist());
        assert(p33.x == 4);
        assert(p33.y == 6);
        p33+=p11;


    auto a = Point2D!double(0,0);
        auto b = Point2D!double(4,0);
        auto v = Vect2D!(double)(a,b);
    v.turn(3.14159/2);


auto ggg = array_generator(10,10);
PutPotential!double(3,1,ggg,10,10,a);
// PutPotential!double(6.5, 0.5, ggg, 10,10, b);
// for(int i=0;i<10;i++){
//     // for(int j=0;j<5;j++){
//     // write((ggg[i][j]).to!string~" ");
//     // }
//     writeln(ggg[i]);
// }
foreach(ref rw ; matr)
    {
        writeln(rw);
    }


}