plotRanks <- function(df, rank_col, time_col, data_col, color_col = NA, labels_offset=0.1, arrow_len=0.1, ...){
  
  time_vec <- df[ ,time_col]
  unique_dates <- unique(time_vec)
  unique_dates <- unique_dates[order(unique_dates)]
  
  rank_ls <- lapply(unique_dates, function(d){
    temp_df <- df[time_vec == d, ]
    temp_df <- temp_df[order(temp_df[ ,data_col], temp_df[ ,rank_col]), ]
    temp_d <- temp_df[ ,data_col]
    temp_rank <- temp_df[ ,rank_col]
    if(is.na(color_col)){
      temp_color = rep("blue", length(temp_d))
    }else{
      temp_color = temp_df[ ,color_col]
    }
    temp_rank <- temp_df[ ,rank_col]
    
    temp_ls <- list(temp_rank, temp_d, temp_color)
    names(temp_ls) <- c("ranking", "data", "color")
    temp_ls
  })
  
  first_rank <- rank_ls[[1]]$ranking
  first_data <- rank_ls[[1]]$data
  first_length <- length(first_rank)
  
  y_max <- max(sapply(rank_ls, function(l) length(l$ranking)))
  plot(rep(1, first_length), 1:first_length, pch=20, cex=0.8, 
       xlim=c(0, length(rank_ls) + 1), ylim = c(1, y_max), xaxt = "n", xlab = NA, ylab="Ranking", ...)
  
  text_paste <- paste(first_rank, "\n", "(", first_data, ")", sep = "")
  text(rep(1 - labels_offset, first_length), 1:first_length, text_paste)
  axis(1, at = 1:(length(rank_ls)), labels = unique_dates)
  
  for(i in 2:length(rank_ls)){
    j = i - 1
    ith_rank <- rank_ls[[i]]$ranking
    ith_data <- rank_ls[[i]]$data
    jth_color <- rank_ls[[j]]$color
    jth_rank <- rank_ls[[j]]$ranking
    ith_length <- length(ith_rank)
    jth_length <- length(jth_rank)
    points(rep(i, ith_length), 1:ith_length, pch = 20, cex = 0.8)
    i_to_j <- match(jth_rank, ith_rank)
    arrows(rep(i - 0.98, jth_length), 1:jth_length, rep(i - 0.02, ith_length), i_to_j
           , length = 0.1, angle = 10, col = jth_color)
    offset_choice <- ifelse(length(rank_ls) == 2, i + labels_offset, i - labels_offset)
    text_paste <- paste(ith_rank, "\n", "(", ith_data, ")", sep = "")
    text(rep(offset_choice, ith_length), 1:ith_length, text_paste)
  }
}


data(presidents)
years <- rep(1945:1974, 4)
n <- length(presidents)
q1 <- presidents[seq(1, n, 4)]
q2 <- presidents[seq(2, n, 4)]
q3 <- presidents[seq(3, n, 4)]
q4 <- presidents[seq(4, n, 4)]
quarters <- c(q1, q2, q3, q4)
q_label  <- c(rep("Q1", n / 4), rep("Q2", n / 4), rep("Q3", n / 4), rep("Q4", n / 4))
q_colors <- c(Q1 = "blue", Q2 = "red", Q3 = "green", Q4 = "orange")
q_colors <- q_colors[match(q_label, names(q_colors))]

new_prez <- data.frame(years, quarters, q_label, q_colors)
new_prez <- na.omit(new_prez)

plotRanks(new_prez[new_prez$years %in% 1960:1970, ], "q_label", "years", "quarters", "q_colors")
mtext("Morris", side=1, line=2, cex.lab=0.4)
