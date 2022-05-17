#include <iostream>
using namespace std;

struct node
{
    int vertex;
    node *next;
};
bool *Visited;
bool cycles = false;
class Graph
{
private:
    int n; // number of vertices
    int e; // number of edges
    node *headnodes;

public:
    Graph(int nodes) // constructor
    {
        n = nodes;
        headnodes = new node[n]; // create an array of n nodes
        for (int i = 0; i < n; i++)
        {
            headnodes[i].vertex = i;
            headnodes[i].next = 0;
        }
    }

    void create()
    {
        int v1, v2;
        cout << "Enter number of edges: ";
        cin >> e;
        for (int i = 0; i < e; i++)
        {
            cout << "Enter number of vertices to connect from (0-" << n - 1 << "): ";
            cin >> v1 >> v2;
            addEdge(v1, v2);
            addEdge(v2, v1);
        }
    }

    void addEdge(int v1, int v2)
    {
        node *newNode = new node;
        newNode->vertex = v2;
        newNode->next = headnodes[v1].next;
        headnodes[v1].next = newNode;
    }

    void DFS(int father, int v)
    {
        Visited[v] = true;
        node *adjnode = headnodes[v].next;
        while (adjnode) // visit all vertices adjacent to v
        {
            if (!Visited[adjnode->vertex])      // if not visited
                DFS(v, adjnode->vertex);        // when we call dfs, we pass the current vertex as the father
            else if (father != adjnode->vertex) // if the vertex is visited and it is not the father
            {
                cycles = true;
            }
            adjnode = adjnode->next;
        }
    }

    void printGraph()
    {
        node *tempNode = new node;
        cout << "Cycle: ";
        for (int i = 0; i < n; i++)
        {
            tempNode = &headnodes[i];
            cout << "( ";
            while (tempNode != NULL)
            {
                cout << tempNode->vertex << ' ';
                tempNode = tempNode->next;
            }
            cout << ")  ";
        }
        cout << endl;
    }
};

int main()
{
    int n;
    cout << "Please enter number of vertices: ";
    cin >> n;
    Visited = new bool[n];
    int Nmbrcmpnts = 0; // components counter
    Graph G(n);         // constructor
    G.create();         // create the graph
    G.printGraph();     // print the graph
    for (int i = 0; i < n; i++)
        Visited[i] = false;
    for (int j = 0; j < n; j++)
    {
        for (int k = 0; k < n; k++)
        {
            if (!Visited[k])
            {
                G.DFS(0, k);
                Nmbrcmpnts++;
            }
        }
    }

    if (cycles)
    {
        cout << "Graph does contain cycle" << endl;
    }
    else
    {
        cout << "Graph does NOT contain cycle" << endl;
    }
    cout << "Number of Connected Components: " << Nmbrcmpnts << endl;

    return 0;
}