import std.stdio;
import std.conv;
import helper;

void main()
{

    auto a = Point2D!double(0,2);
	auto a2 = Point2D!double(3,0);
	auto b = Point2D!double(0,0);
	auto c = Point2D!double(1,1);
    //     auto b = Point2D!double(4,0);
    //     auto v = Vect2D!(double)(a,b);
    // v.turn(3.14159/2);


    auto InfMap = new InfluenceMap!double(3,5);
    auto ast = new AStar!double();
    InfMap.PutPotential(3, 1, a);
    InfMap.PutAvgPotential(2, 1, Point2D!double(4,0));
    auto tmp = ast.FindPath(Point2D!double(0,0), Point2D!double(4,2),5,3,InfMap.Map);
//auto ggg = array_generator(3,5);
//PutPotential!double(3,1,ggg,10,10,a);
//PutPotential!double(3, 1, ggg, 10,10, b);

//PutPotential!double(3, 1, ggg, a2);

auto ff = InfMap.getSumOfVectorOnInfluenseMap!double(Point2D!double(0,0),Point2D!double(1,0));
auto dcc = InfMap.GetMinPotentialByRadius!double(2, Point2D!double(0,0));
auto ff2 = InfMap.getSumOfVectorOnInfluenseMap!double(Point2D!double(0,0),dcc);

writeln(InfMap.Map[dcc.x.to!ulong][dcc.y.to!ulong]);
writeln(InfMap.Map[2][0]);
foreach(ref rw ; InfMap.Map)
    {
        writeln(rw);
    }
// 	    auto p = Point2D!double(1,2);

//     auto p11 = Point2D!double(1,2);
//         auto p22 = Point2D!double(3,4);
//         auto p33 = p11+p22;
//         writeln(p33.dist());
//         assert(p33.x == 4);
//         assert(p33.y == 6);
//         p33+=p11;


//     auto a = Point2D!double(0,2);
// 	auto a2 = Point2D!double(3,0);
// 	auto b = Point2D!double(0,0);
// 	auto c = Point2D!double(1,1);
//     //     auto b = Point2D!double(4,0);
//     //     auto v = Vect2D!(double)(a,b);
//     // v.turn(3.14159/2);


// 	int[][] matrix = [
//     [ 1, 2, 3 ],
//     [ 4, 5, 6 ]
// ];
// assert(matrix[0][0] == 1);
// assert(matrix[0][1] == 2);


// auto ggg = array_generator(3,5);
// //PutPotential!double(3,1,ggg,10,10,a);
// //PutPotential!double(3, 1, ggg, 10,10, b);
// PutPotential!double(3, 1, ggg, a);
// //PutPotential!double(3, 1, ggg, a2);

// auto ff = getSumOfVectorOnInfluenseMap!double(Point2D!double(0,0),Point2D!double(1,0), ggg);
// auto dcc = GetMinPotentialByRadius!double(1, ggg, Point2D!double(0,0));
// auto ff2 = getSumOfVectorOnInfluenseMap!double(Point2D!double(0,0),dcc, ggg);

// writeln(ggg[dcc.x.to!ulong][dcc.y.to!ulong]);
// writeln(ggg[2][0]);
// foreach(ref rw ; ggg)
//     {
//         writeln(rw);
//     }

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