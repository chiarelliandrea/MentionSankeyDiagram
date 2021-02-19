library(rtweet)
library(networkD3)

appname <- "YourInfoHere"

api_key <- "YourInfoHere"
api_secret <- "YourInfoHere"
api_token <- "YourInfoHere"
api_token_secret <- "YourInfoHere"

twitter_token <- create_token(
  app <- appname,
  consumer_key <- api_key,
  consumer_secret <- api_secret,
  access_token <- api_token,
  access_secret <- api_token_secret)

yourTarget <- "@rschconsulting"

mentions <- search_tweets(yourTarget, n=10000, token = twitter_token, lang= "en")

data_for_network <- mentions$screen_name
data_for_network <- data.frame(data_for_network)
data_for_network <- cbind(data_for_network, rep(yourTarget, nrow(data_for_network)))

names(data_for_network)[1] <- "mentioner"
names(data_for_network)[2] <- "mentioned"

# Build a list of nodes
mentioner <- data_for_network$mentioner
mentioned <- data_for_network$mentioned
nodes <- c(mentioner, mentioned)

nodes <- as.data.frame(unique(nodes))
nodes <- nodes %>% rowid_to_column("id")
names(nodes)[2] <- "label"

# Build a list of edges
retweet_network <- data_for_network %>%  
  group_by(mentioner, mentioned) %>%
  summarise(weight = n()) %>% 
  ungroup()

names(retweet_network)[1] <- "mentioner"
names(retweet_network)[2] <- "mentioned"

edges <- retweet_network %>% 
  left_join(nodes, by = c("mentioned" = "label")) %>% 
  rename(from = id)

edges <- edges %>% 
  left_join(nodes, by = c("mentioner" = "label")) %>% 
  rename(to = id)

# Create the network
nodes_d3 <- mutate(nodes, id = id - 1)
edges_d3 <- mutate(edges, from = from - 1, to = to - 1)
nodes_d3 <- as.data.frame(nodes_d3) # This is needed to avoid the warning "Links is a tbl_df. Converting to a plain data frame."
edges_d3 <- as.data.frame(edges_d3) 

sankeyNetwork(Links = edges_d3, Nodes = nodes_d3, Source = "from",
              Target = "to", Value = "weight", NodeID = "label",
              fontSize = 12, nodeWidth = 30)