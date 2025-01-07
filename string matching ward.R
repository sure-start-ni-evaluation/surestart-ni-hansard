## Goal: enter the Sure Start wards and compare to nearest fit then manual checks

library(tidyverse)
library(RecordLinkage)

### input/ output

## Ward list from here 
wards_df <- 
  readxl::read_xls('data/raw/NIMDM_2010_Results_Ward_0.xls', sheet = 2)

## the checking function
## takes characters and output closest 
check_names_char <-
  function(checkThis, checkList, nClosestToShow = 2){
    ## lowercase
    lower_x = checkThis %>% tolower()
    lower_checkList = checkList %>% tolower()
    
    dist = levenshteinSim(lower_x, str2 = lower_checkList)
    data.frame(
      checkThis = checkThis,
      #        perfectMatch = tolower(x) %in% tolower(checkList),
      bestMatch = checkList[which.max(dist)],
      bestMatchId = which.max(dist),
      bestScore = max(dist), 
      others = checkList[(dist %>% order(decreasing = T))[2:(1 + nClosestToShow)]] %>% paste(collapse = "|") #next two best        
    )
    
    
  }
  
# check_names_char('dave', c(letters[1:26])) ## Don't run example


# step 1: get hansard list -----------------------------------------------

ss_hansard_df <-
  'data/raw/sure start wards (hansard 2006).csv' %>% 
  read_csv()

check_ss <- 
  ss_hansard_df$Ward %>% 
  map_df(
    .f = check_names_char,
    checkList = wards_df$`WARD NAME`
  )


## get LDG and name
check_ss <-
  check_ss %>%
  mutate(
    bestLGD = wards_df$`LGD NAME`[bestMatchId],
    bestCode = wards_df$`WARD CODE`[bestMatchId]
  )

check_ss <-
  check_ss %>%
  rename(
    hansard_ward = checkThis
  )

## join back to the hansard list ward coverage
check_ss <-
  check_ss %>%
  mutate(
    hansard_2006_coverage = 
      ss_hansard_df$`Percentage of children that are on Sure Start schemes`
  )


## Step 3: export and check
check_ss %>% 
  arrange(bestScore) %>%
  write_csv('data/hansard best matches (for checking).csv')
