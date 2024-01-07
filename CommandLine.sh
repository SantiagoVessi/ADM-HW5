python3 -c '
import json
import networkx as nx

# Read graph data from JSON file
with open("graph_data.json", "r") as infile:
    data = json.load(infile)

# Create a graph from the JSON data
cit_G = nx.node_link_graph(data)

print("Q1 Is there any node that acts as an important connector between the different parts of the graph?")
print("Loading...")

# Calculate betweenness centrality for each node
betweenness = nx.betweenness_centrality(cit_G)

# Find the nodes with the highest betweenness centrality
critical_node = sorted(betweenness, key=betweenness.get, reverse=True)[0]

print("Node with highest betweenness centrality:", critical_node)

print("--------------------------------------------")
print("Q2 How does the degree of citation vary among the graph nodes?")

# Calculate the degree for each node
degrees = dict(cit_G.degree())

# Calculate the average degree
num_nodes = len(cit_G.nodes())
total_degree = sum(degrees.values())
average_degree = total_degree / num_nodes

print("Average degree of nodes:", average_degree)

print("--------------------------------------------")
print("Q3 What is the average length of the shortest path among nodes?")

# Calculate the average shortest path length for each strongly connected component
component_avg_lengths = []
for component in nx.strongly_connected_components(cit_G):
    subgraph = cit_G.subgraph(component)
    avg_length = nx.average_shortest_path_length(subgraph)
    component_avg_lengths.append(avg_length)

# Calculate the overall average shortest path length
overall_avg_length = sum(component_avg_lengths) / len(component_avg_lengths)

print("Overall average shortest path length among nodes:", overall_avg_length)

'