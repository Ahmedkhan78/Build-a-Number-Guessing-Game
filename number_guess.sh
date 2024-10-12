#!/bin/bash

# PSQL command for querying the database
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Function to play the guessing game
play_game() {
  SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
  NUMBER_OF_GUESSES=0
  
  echo "Guess the secret number between 1 and 1000:"

  while true; do
    read GUESS
    
    # Check if input is a valid integer
    if ! [[ "$GUESS" =~ ^[0-9]+$ ]]; then
      echo "That is not an integer, guess again:"
      continue
    fi

    ((NUMBER_OF_GUESSES++))

    if [[ $GUESS -lt $SECRET_NUMBER ]]; then
      echo "It's higher than that, guess again:"
    elif [[ $GUESS -gt $SECRET_NUMBER ]]; then
      echo "It's lower than that, guess again:"
    else
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      break
    fi
  done

  # Update user's statistics in the database
  update_user_stats
}

# Function to update user stats after a game
update_user_stats() {
  # Get current user's stats from the database
  USER_STATS=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")
  
  IFS="|" read GAMES_PLAYED BEST_GAME <<< "$USER_STATS"
  NEW_GAMES_PLAYED=$(( GAMES_PLAYED + 1 ))

  # Check if it's a new best game or if the current best_game is NULL
  if [[ -z $BEST_GAME ]] || [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]; then
    NEW_BEST_GAME=$NUMBER_OF_GUESSES
  else
    NEW_BEST_GAME=$BEST_GAME
  fi

  # Update the user's stats in the database
  UPDATE_STATS=$($PSQL "UPDATE users SET games_played=$NEW_GAMES_PLAYED, best_game=$NEW_BEST_GAME WHERE username='$USERNAME'")
}

# Main script logic
echo "Enter your username:"
read USERNAME

# Check if user exists in the database
USER_DATA=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -n $USER_DATA ]]; then
  # If the user exists, extract and print the user data
  IFS="|" read USERNAME GAMES_PLAYED BEST_GAME <<< "$USER_DATA"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  # If the user doesn't exist, insert new user into the database
  INSERT_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, NULL)")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
fi

# Start the game
play_game
