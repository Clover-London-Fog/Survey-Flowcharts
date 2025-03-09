library(DiagrammeR)
library(readxl)

## Create Automatic Flowchart with Dataframe pulled from Excel



#  Dataframes built in excel: 

  #  Nodes (node + subnodes_Mrecord), Edges, Edges FROM subnodes. Dataframes are built in excel using formulas that reference other sheets....

  #  Node dataframe: ID, Cluster (dropdown list), Label, Code Label, VizLabel*, style, color, Shape**, fixedSize(T/F), VizCluster***
      #  VizLavel* Pulls from a table in excel of created subnodes. Filters for sub-nodes related to an ID, then builds an MRecord label; ex: "FavoritePie|{<f0> Cherry | <f1> Apple | <f2> Berry}"
      #  Shape** IF no subnodes exist for this ID, then box, else Mrecord
      # VizCluster*** Based on the dropdown list, pulls related styling, text, color, etc...
      #  I used \n to workaround and style the cluster subgrph.
      #  ex: " Pie Information'\nstyle=filled\ncolor='Beige "... ends the item with ' and works good
  # Edge and Subnode Edge Dataframe. Edge has several columns to adjust styling. Subedge is the same, but has an additional column to join columns into one line:
      # ex: 6:f0--'4' [color = 'Goldenrod', label = 'Sub Node Edge', arrowhead = 'vee'] 

RegNodes<- read_xlsx(
  path = "Framework Data Frame.xlsx"
  ,sheet = 1) #  Node dataframe, with related subnodes and cluster styling
RegEdges<- read_xlsx(
  path = "Framework Data Frame.xlsx"
  ,sheet = 2) # Edges -- Regular edges only, no subnodes (+ styling, etc)
SubEdges<- read_xlsx(
  path = "Framework Data Frame.xlsx"
  ,sheet = 3) # Edges -- FROM subnodes to regular nodes (+ styling, etc)

CLUSTERS<-gsub("\\n","\n",RegNodes$VizCluster,fixed = T)
## Do this since excel reads a typed "\n" as a "\\n"

TEST_DF<- create_node_df(
  n=nrow(RegNodes)
  , label = RegNodes$VizLabel
  , shape = RegNodes$Shape
  , style = RegNodes$style
  , color = RegNodes$color
  , cluster = CLUSTERS
  , fixedsize = RegNodes$fixedsize
  #, type = "lower"
) #All clusters, nodes, and subnodes will now be styled and formatted


TEST_EDGES <- create_edge_df(
  from = RegEdges$fromID
  ,to = RegEdges$toID
  , color = RegEdges$color
  , arrowhead = RegEdges$arrowhead
  , label = RegEdges$label
  #, penwidth = RegEdges$PenWidth
)



REPLACED<- paste(SubEdges$paste,collapse = "\n") # collapse all subedges into one
REPLACED<-paste("] \n",REPLACED,"\n}") # put the stuff before and after to gsub properly

# we do this to gsub since I do not belive there is a subnode option within the functions for this package yet

create_graph(graph_name = "Example"
             , directed = TRUE
             , attr_theme = "tb" #top to bottom? I forgot
)%>%
  add_nodes_from_table(TEST_DF,label_col = label)%>% # Use nodes dataframe
  add_edges_from_table(TEST_EDGES,from,to,id_external)%>% # Use Normal Edges dataframe
  add_global_graph_attrs("layout","dot","graph")%>%
  add_global_graph_attrs("label"," SURVEY IS FORMATTED EXAMPLE ","graph")%>%
  add_global_graph_attrs("labelloc","t","graph")%>% # I forgot again
  add_global_graph_attrs(attr = "overlap"
                         , value = "false", 
                         attr_type = "graph")%>%
  add_global_graph_attrs("fixedsize","false","node")%>%
  add_global_graph_attrs("fontcolor","black","node")%>% # to avoid grey font
  generate_dot()%>% #cat()%>% #remove # to render dot before gsub of subnode edges
  gsub("] \n}",REPLACED,.,fixed = T)%>%
  #cat()#%>% #remove to see dot text
grViz() 

#  creates diagram, done
