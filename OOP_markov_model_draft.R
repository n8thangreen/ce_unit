for (i in 1:n_treatments) {
  
  age <- init_age
  c_state <- state_costs[[i]]
  pop <- start_pop
  
  for (j in 2:n_cycles) {
    # single step forward
    prob_matrix <- prob_matrix |> next_period(age)
    pop <- pop |> next_period(prob_matrix)
    c_state.next_period()

    # append latest values
    pop_matrix[, cycle = j, treatment = i] <- pop
    c_state_matrix[treatment = i, ] <- c_state
    
    cycle_costs[i, ] <- c_state.total()
    
    age <- age + 1
  }
  
  total_costs[i] <- sum(cycle_costs[treatment = i, -1])
}

