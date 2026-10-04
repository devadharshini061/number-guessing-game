#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$((1 + RANDOM % 1000))

echo "Enter your username:"
read USERNAME

USER_INFO=$($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."

  USER_ID=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME') RETURNING user_id")
  GAMES_PLAYED=0
  BEST_GAME=""
else
  IFS='|' read USER_ID GAMES_PLAYED BEST_GAME <<< "$USER_INFO"

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
