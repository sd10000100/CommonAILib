module helper.pathfind.astar;
import helper;
import std.math; 


// A*
struct PathNode(T)
{
    // Координаты точки на карте.
    Point2D!T Position;
    // Длина пути от старта (G).
    double PathLengthFromStart=10000;
    // Точка, из которой пришли в эту точку.
    PathNode CameFrom;
    // Примерное расстояние до цели (H).
    double HeuristicEstimatePathLength;

    Point2D[] path;
    // Ожидаемое полное расстояние до цели (F).
    double EstimateFullPathLength() {
        return PathLengthFromStart + HeuristicEstimatePathLength;
    }

    double EstimateFullPathLengthConst() {
        return PathLengthFromStart + HeuristicEstimatePathLength;
    }

    pure nothrow int opCmp(Complex v) {
        auto a = EstimateFullPathLengthConst();
        auto va = v.EstimateFullPathLengthConst();
        if(a == va)
            return 0;
        else if(a > va)
            return 1;
        else return -1;
    }


    // bool operator == (const PathNode &node)
    // {
    //     return floor(Position.x) == floor(node.Position.x) && floor(Position.y) == floor(node.Position.y);
    // }
};

class AStar (T) {
    alias Point2D = Point2D!T;

    bool isPointInUnit(Point2D point, Point2D unitPosition, Point2D unitSize)
    {
        return point.x >= unitPosition.x - unitSize.x / 2
            &&
            point.x <= unitPosition.x + unitSize.x / 2
            &&
            point.y >= unitPosition.y
            &&
            point.y <= unitPosition.y + unitSize.y;
    }

    double GetHeuristicPathLength(Point2D from, Point2D to)
    {
        return fabs(from.x - to.x) + fabs(from.y - to.y);
    }

    PathNode GetMinF(PathNode[] list)
    {
        PathNode minElem;
        double minVal = 10000;

        foreach(PathNode item ; list)
        {
            double temp = item.EstimateFullPathLength();
            if(temp<minVal)
            {
                minElem = item;
                minVal = temp;
            }
        }
        return minElem;
    }

    Vec2Double[] GetPathForNode(PathNode pathNode){
            return pathNode.path;
    //    std::vector<Vec2Double> result = {};
    //    PathNode* currentNode = &pathNode;
    //    while (currentNode != nullptr)
    //    {
    //        result.push_back(currentNode->Position);
    //        currentNode = currentNode->CameFrom;
    //    }
    //    std::reverse(std::begin(result), std::end(result));
    //    return result;
    }

    PathNode[] GetNeighbours(PathNode pathNode, Point2D goal,int sizeX, int sizeY)
    {
        PathNode[] result;

    // Соседними точками являются соседние по стороне клетки.
        Point2D[] neighbourPoints;

        int x = floor(pathNode.Position.x);
        int y = floor(pathNode.Position.y);
        neighbourPoints+=Point2D(x + 1, y);
        neighbourPoints+=Point2D(x - 1, y);
        neighbourPoints+=Point2D(x, y + 1);
        neighbourPoints+=Point2D(x, y - 1);

        neighbourPoints+=Point2D(x + 1, y-1);
        neighbourPoints+=Point2D(x - 1, y-1);
        neighbourPoints+=Point2D(x+1, y + 1);
        neighbourPoints+=Point2D(x-1, y + 1);

        foreach (Vec2Double point ; neighbourPoints)
        {
            // Проверяем, что не вышли за границы карты.
            if (point.x < 0 || point.x >= sizeX)
                continue;
            if (point.y < 0 || point.y >= sizeY)
                continue;
            // Проверяем, что по клетке можно ходить.
            // auto temp = game.level.tiles[point.x][point.y];
            // if ((temp == Tile::WALL))
            //     continue;
            bool isSomeUnitNear = false;
            // for(auto unit : game.units)
            // {
            //     if(unit.id!=currentUnit.id)
            //     {
            //         if(isPointInUnit(point, currentUnit.position, currentUnit.size))
            //             isSomeUnitNear = true;
            //     }
            // }
            if(isSomeUnitNear)
                continue;
            // Заполняем данные для точки маршрута.
            PathNode neighbourNode;
            neighbourNode.Position.x = point.x;
            neighbourNode.Position.y = point.y;
            neighbourNode.path = pathNode.path;
            //neighbourNode.CameFrom = &pathNode;
    //        for(auto item : pathNode.path)
    //        {
    //            neighbourNode.path.push_back(Vec2Double(item.x, item.y));
    //        }
            neighbourNode.path+=Point2D(pathNode.Position.x, pathNode.Position.y);
            neighbourNode.PathLengthFromStart = pathNode.PathLengthFromStart +1,
                    neighbourNode.HeuristicEstimatePathLength = GetHeuristicPathLength(point, goal);
            result+=neighbourNode;
        }
        return result;
    }

    Entity find(PathNode target, PathNode[] entities, int elemCount){

        for (int i = 0; i < elemCount; i++) {
            if(entities[i].Position.x==target.Position.x && entities[i].Position.y==target.Position.y)
            {
                return entities[i];
            }
            
        }
        return null;
    }

    Point2D[] FindPath(Point2D from, Point2D to, int _width, int _height/*const Game &game, const Unit &currentUnit*/)
    {
        PathNode[] Idle = {};
        PathNode[] visited = {};

        from.x = floor(from.x);
        from.y = floor(from.y);

        to.x = floor(to.x);
        to.y = floor(to.y);


        int width = _width;
        int height = _height;

        // Шаг 2.
        PathNode startNode = PathNode();
        startNode.CameFrom = nullptr;
        startNode.path = {};
        startNode.Position = from;
        startNode.PathLengthFromStart = 0,
        startNode.HeuristicEstimatePathLength = GetHeuristicPathLength(from, to);

        Idle+=startNode;

        while (Idle.size()> 0) {

    //        std::cerr<<"Idle size: "<< Idle.size()<<'\n';
    //        std::cerr<<"visited size: "<< visited.size()<<'\n';

            PathNode currentNode = GetMinF(Idle);
            if (floor(currentNode.Position.x) == floor(to.x) && floor(currentNode.Position.y) == floor(to.y)) {
                return GetPathForNode(currentNode);
            }
            // Шаг 5.

            //Idle = removeItemFromList(currentNode, Idle);
            Idle = Idle[1..$];//.pop_front();
            visited+=currentNode;

            // Шаг 6.
            auto neighs = GetNeighbours(currentNode, to, width, height/*, game, currentUnit*/);
            foreach (PathNode neighbourNode ; neighs) {
                // Шаг 7.
    //            if (GetCountByPosition(neighbourNode.Position, visited, game) > 0)
    //                continue;
                auto visitedNodeIter = find(neighbourNode, visited, visited.size());
                //
                if(visitedNodeIter!=visited.end())
                    continue;
                auto idleNodeIter = find(neighbourNode, find, find.size());



                // Шаг 8.
                if (idleNodeIter == Idle.end())
                    Idle.push_back(neighbourNode);
                else if (idleNodeIter.PathLengthFromStart > neighbourNode.PathLengthFromStart) {
                    // Шаг 9.

                    idleNodeIter.CameFrom = &neighbourNode;
                    idleNodeIter.path = {};
                    //neighbourNode.CameFrom = &pathNode;
                    foreach(Point2D item ; neighbourNode.path)
                    {
                        idleNodeIter.path+=Point2D(item.x, item.y);
                    }
                    idleNodeIter.path+=Point2D(neighbourNode.Position.x, neighbourNode.Position.y);
                    //neighbourNode.CameFrom = &pathNode;

                    idleNodeIter.PathLengthFromStart = neighbourNode.PathLengthFromStart;
                    //Idle.push_back(*openNode);
                }
            }

        }
        // Шаг 10.
        return {};
    }


};

