# Survey-Flowcharts-or-Diagrams
 Short Description: Use of R (Graphviz and DiagrammeR) and excel to build pretty charts to visualize survey question structure and conditional logic.

>[!info]
>I use Limesurvey. Because limesurvey allows one to export a survey, I can use R to sift through the export to build a dataframe of questions within a survey. However, at this current time, I simply update a formulated excel worksheet that R pulls to create updated visuals

![ExampleClusterDiagram](https://github.com/Clover-London-Fog/Survey-Flowcharts/blob/main/Rplot.jpg?raw=true)

 ## Why was this made?
Simply put, I feel like the use of diagrams speaks for itself. To avoid keeping/sharing extensive paragraphs of what links to what, I just wanted something to show those changes -- in a more collective sense.


This allows me to make a new diagram by simply updating an excel I use to upkeep questions and sub-questions. Now, changes in the survey are not a tedious task in updated related flowcharts.



I just really needed faster, pretty, and more flexible diagrams to assist me (and others) with whatever confusion or loss of communication that may occur (within differing levels of staff).

That being said, this obviously does not mean it is perfect. Simply, a good Band-Aid for now. It IS however mountains of times better than me needing to purchase something like Microsoft Visio or making this diagram by hand. THAT is too tedious. 

So, I set this up in about the same amount of time that would take to do by hand.

Just seemed to make more sense.

## Ideas for future

- Use grepl to build node dataframe from limesurvey export, along with any conditional logic.
- update the formatting, maybe opacity and light-pleasing gradients.
- find a way to make filled white boxs behind edge descriptions (labels). Can make for neater formatting.
- Try to make it with Mermaid option? I like the default version, but still.
