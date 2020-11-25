module helper.influence_map;

import helper;
import std.math;
import std.conv;



auto array_generator(int height,int width) {
    auto matr = new double[][](height,width);

    foreach(ref rw ; matr)
    {
        foreach(ref item ; rw)
        {
            item = 0.0;
        }
    }
    
    return matr;
}

double signedMax(double a, double b)
{
    if(abs(a)>=abs(b))
        return a;
    else return b;
}

double getSign(double x)
{
    if (x>0)
        return 1;
    else return -1;
}

void PutPotential(T)(double power, double step, double[][] matr, Point2D!T p)
{
    ulong sizeY =matr.length;
    ulong sizeX =matr[0].length;
    double s = 0;
    int x = (abs(floor((p.x).to!double))).to!int;
    int y = (abs(floor((p.y).to!double))).to!int;
    for(double l = 0;l<fabs(power);l=l+step, s++)
    {
        for(int temp = (y-s).to!int;temp<=s+y;temp++)
        {
            int tempArrMinX = (floor(x-s)).to!int;
            int tempArrMaxX = (floor(x+s)).to!int;
            if(tempArrMinX>=0 && tempArrMinX<sizeX && temp>=0 && temp<sizeY)
                matr[temp][tempArrMinX]=signedMax(matr[temp][tempArrMinX],getSign(power)*(abs(power)-l));
            if(tempArrMaxX<sizeX && tempArrMaxX>=0 && temp>=0 && temp<sizeY)
                matr[temp][tempArrMaxX]=signedMax(matr[temp][tempArrMaxX],getSign(power)*(abs(power)-l));
        }
        for(int temp = (x-s+1).to!int;temp<=s+x-1;temp++)
        {
            int tempArrMinY = (floor(y-s)).to!int;
            int tempArrMaxY = (floor(y+s)).to!int;
            if(tempArrMinY>=0 && tempArrMinY<sizeY && temp>=0 && temp<sizeX)
                matr[tempArrMinY][temp]=signedMax(matr[tempArrMinY][temp],getSign(power)*(abs(power)-l));
            if(tempArrMaxY>=0 && tempArrMaxY<sizeY  && temp>=0 && temp<sizeX)
                matr[tempArrMaxY][temp]=signedMax(matr[tempArrMaxY][temp],getSign(power)*(abs(power)-l));
        }
    }
}


// // void array_destroyer(double **ary, unsigned int dim1) {
// //     for (int i = 0; i < dim1; i++) {
// //         delete [] ary[i];
// //     }
// //     delete [] ary;
// // }

double putp(double oldV, double newV)
{
    if(oldV==80)
        return 80;
    else if(oldV == 0)
        return newV;
    else
        return (oldV+newV)/2;

}

void PutAvgPotential(T)(double power, double step, double[][] matr, Point2D!T p)
{
    ulong sizeY =matr.length;
    ulong sizeX =matr[0].length;
    double s = 0;
    int x = (abs(floor((p.x).to!double))).to!int;
    int y = (abs(floor((p.y).to!double))).to!int;
    for(double l = 0;l<fabs(power);l=l+step, s++)
    {
        for(int temp = (y-s).to!int;temp<=s+y;temp++)
        {
            int tempArrMinX = (floor(x-s)).to!int;
            int tempArrMaxX = (floor(x+s)).to!int;
            if(tempArrMinX>=0 && tempArrMinX<sizeX && temp>=0 && temp<sizeY && matr[tempArrMinX][temp]<80)
                matr[temp][tempArrMinX]=putp(matr[temp][tempArrMinX],getSign(power)*(abs(power)-l));
            if(tempArrMaxX<sizeX && tempArrMaxX>=0 && temp>=0 && temp<sizeY && matr[tempArrMaxX][temp]<80)
                matr[temp][tempArrMaxX]=putp(matr[temp][tempArrMaxX],getSign(power)*(abs(power)-l));
        }
        for(int temp = (x-s+1).to!int;temp<=s+x-1;temp++)
        {
            int tempArrMinY = (floor(y-s)).to!int;
            int tempArrMaxY = (floor(y+s)).to!int;
            if(tempArrMinY>=0 && tempArrMinY<sizeY && temp>=0 && temp<sizeX && matr[temp][tempArrMinY]<80)
                matr[tempArrMinY][temp]=putp(matr[tempArrMinY][temp],getSign(power)*(abs(power)-l));
            if(tempArrMaxY>=0 && tempArrMaxY<sizeY  && temp>=0 && temp<sizeX && matr[temp][tempArrMaxY]<80)
                matr[tempArrMaxY][temp]=putp(matr[tempArrMaxY][temp],getSign(power)*(abs(power)-l));
        }
    }
}


bool isCorrectCoordinate(int x, int y, ulong sizeX, ulong sizeY)
{
    if(x>=0 && x<sizeX && y>=0 && y<sizeY)
        return true;
    return false;
}

double getSumOfVectorOnInfluenseMap(T)(Point2D!T fromV, Point2D!T toV, double[][] matr){
    ulong sizeY =matr.length;
    ulong sizeX =matr[0].length;
    double sum = 0;
    int sqareStartX =  fmin(floor(fromV.x.to!double).to!int, floor(toV.x.to!double).to!int).to!int;
    int sqareFinishX = fmax(ceil(fromV.x.to!double).to!int,ceil(toV.x.to!double).to!int).to!int;
    int sqareStartY = fmin(floor(fromV.y.to!double).to!int,floor(toV.y.to!double).to!int).to!int;
    int sqareFinishY = fmax(ceil(fromV.y.to!double).to!int,ceil(toV.y.to!double).to!int).to!int;

    for(int i = sqareStartX; i<=sqareFinishX;i++)
    {
        for(int j = sqareStartY; j<=sqareFinishY;j++) {
            if (isCorrectCoordinate(i, j, sizeX, sizeY) && (
                    intersect(fromV, toV, Point2D!T(size_t(i), size_t(j)), Point2D!T(size_t(i), size_t(j) + 1))
                    ||
                    intersect(fromV, toV, Point2D!T(size_t(i), size_t(j)), Point2D!T(size_t(i) + 1, size_t(j)))
                    ||
                    intersect(fromV, toV, Point2D!T(size_t(i) + 1, size_t(j)),
                              Point2D!T(size_t(i) + 1, size_t(j) + 1))
                    ||
                    intersect(fromV, toV, Point2D!T(size_t(i), size_t(j) + 1),
                              Point2D!T(size_t(i) + 1, size_t(j) + 1))
            )) {
                sum += matr[j][i];
            }
            else if(!isCorrectCoordinate(i, j, sizeX, sizeY))
            {sum +=80;}
        }
    }
    return sum;
}

Point2D!T GetMinPotentialByRadius(T)(int radius, double[][] matr,  Point2D!T source) {
    ulong sizeY =matr.length;
    ulong sizeX =matr[0].length;
    double min = 10000;
    Point2D!T minPos = source;
    // int x = int(abs(floor(source.x)));
    // int y = int(abs(floor(source.y)));

    int x = (abs(floor((source.x).to!double))).to!int;
    int y = (abs(floor((source.y).to!double))).to!int;

    for (int temp = y-radius+1; temp < y+radius; temp++) {
        int minX = x-radius;
        int maxX = x+radius;
        double minSum = getSumOfVectorOnInfluenseMap(source, Point2D!T (minX,temp), matr);
        double maxSum = getSumOfVectorOnInfluenseMap(source, Point2D!T (maxX,temp), matr);
        if(minSum<min)
        {
            min = minSum;
            minPos.x = minX;
            minPos.y = temp;
        }
        if(maxSum<min)
        {
            min = maxSum;
            minPos.x = maxX;
            minPos.y = temp;
        }
    }
    for (int temp = x-radius+1; temp < x+radius; temp++) {
        int minY = y-radius;
        int maxY = y+radius;
        double minSum = getSumOfVectorOnInfluenseMap(source, Point2D!T (temp,minY), matr);
        double maxSum = getSumOfVectorOnInfluenseMap(source, Point2D!T (temp,maxY), matr);
        if(minSum<min)
        {
            min = minSum;
            minPos.x = temp;
            minPos.y = minY;
        }
        if(maxSum<min)
        {
            min = maxSum;
            minPos.x = temp;
            minPos.y = maxY;
        }
    }
    return minPos;

}