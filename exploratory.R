

### LIBRARIES #################################################################
library(dplyr);
library(rlang);

options(stringsAsFactors = FALSE);
rm( list = ls(all.names = TRUE));
### MAIN ######################################################################

delays <- read.csv('data/delays.csv');

# add timestamp
delays <- delays %>% 
    mutate(
        timestamp = as.POSIXct( paste(Date, Time), format = '%Y/%m/%d %H:%M')
        );


delay.summary <- delays %>% 
    group_by(Code) %>%
    summarize(
        count = n(), 
        mean.delay = mean(Min.Delay), 
        min.delay = min(Min.Delay),
        median.delay = median(Min.Delay),
        max.delay = max(Min.Delay)
        ) %>%
    ungroup() %>%
    filter(count > 20 & max.delay > 0) %>%
    arrange(-count);


par(mfrow = c(3, 4));

# plot delays over time
for( code in delay.summary$Code[1:12] ) {
    
    code.data <- delays %>% 
        filter(Code == code);
    
    graphics::hist(
        code.data$Min.Delay, 
        main = code
        );
    # 
    # graphics::plot(
    #     Min.Delay ~ timestamp,
    #     code.data,
    #     pch = 19,
    #     main = code
    #     );
}




