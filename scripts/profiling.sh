PROFILING_ENABLE=0

if [[ "$PROFILING_ENABLE" == "1" ]]; then
  zmodload zsh/datetime
  prof_start=$EPOCHREALTIME
  echo "Profiling enabled. Log: ~/.zshrc_profile.log" > ~/.zshrc_profile.log
fi

# Function to log timestamps for each executed command
profile_command() {
  if [[ "$PROFILING_ENABLE" == "1" ]]; then
    zmodload zsh/datetime
    local now=$EPOCHREALTIME
    local duration=$(echo "$now - $prof_start" | bc)
    echo "[${duration}s] $1" >> ~/.zshrc_profile.log
    prof_start=$now
  fi
}