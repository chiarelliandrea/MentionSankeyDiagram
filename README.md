# How to visualise Twitter mentions (Sankey Diagram)

This repo is very simple - it just shows you how to harvest Twitter data via the API and then visualise mention networks as a Sankey Diagram.
- On the left hand side, you'll see the target account you're monitoring.
- On the right hand side, you'll see all accounts mentioning your target. The size of the bars is based on the number of tweets mentioning your target account.
- Because of how the Twitter API works, this code will pick up data for the last 7-8 days.

How can you edit this code?
- First of all, you will need to input your own information for the Twitter API - get started here: https://developer.twitter.com/en/portal/dashboard
- Then, you just need to edit the value of "yourTarget" with whatever account you'd like to analyse.

The output of the process is as in the figure below:

<img src="https://github.com/chiarelliandrea/MentionSankeyDiagram/blob/main/SankeyDiagramSample_2021-02-19.png?raw=true" width="600">
