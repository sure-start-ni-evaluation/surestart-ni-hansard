# surestart-ni-hansard
Code to clean information on Sure Start coverage using historical information from the Hansard.

The output is a cleaned table of wards in Northern Ireland with ward names and ward codes for joining onto other datasets (contained in the `data` folder). R scripts for processing the data are in the main repository folder.  

# Context

Sure Start in Northern Ireland started in 2000/01. Between 2001 - 2006, there were 25 Sure Start projects which covered wards in Northern Ireland which were selected based on deprivation and other contextual information. The exact selection rules and wards covered are unknown. In 2006, the Department of Education took over the policy lead for Sure Start and started an expansion of Sure Start which was initially intended to cover the top 20% of wards in the country by deprivation (based on the NI multiple deprivation index 2005).

To this day, there remains a lack of information regarding the original wards chosen between 2001- 2006. 

On 9 May 2006, the UK government was asked for the proportion of all children who participated in Sure Start by ward. A table of coverage was given by the Secretary of State for Northern Ireland. This table and his response was recorded in the Hansard [here](https://publications.parliament.uk/pa/cm200506/cmhansrd/vo060509/text/60509w0017.htm#0605109001518).

The Secretary of State said that:
> There are a total of 582 wards in Northern Ireland and Sure Start projects cover 107 wards.

The table itself contains 108 wards. 

# Checking

I used Levenshetein distance to match ward names to closest matches (based on offical spellings). Almost all wards matched exactly (except two). 

A manual check was completed to spot errors (e.g. there's two Crumlin in Northern Ireland):

- Camhill is almost certainly a misspelling of Carn Hill
- Churchlands is a misspelling
- Crumlin refers to Crumlin in Belfast (based on later data from the Sure Start website)