# Build-a-Number-Guessing-Game
A simple Bash number guessing game where players try to guess a random number between 1 and 1000. It tracks your stats, like games played and best score, using a PostgreSQL database.


**Number Guessing Game**

This is a simple Bash-based Number Guessing Game that allows users to guess a randomly generated secret number between 1 and 1000. The game tracks the user's performance, including the total number of games played and the number of guesses it took to win the game. It stores this information in a PostgreSQL database.

The game features:
- User-friendly prompts to guess the secret number.
- Real-time feedback for guesses (higher/lower).
- A PostgreSQL database to save and retrieve user statistics.
- Automatically updates user stats after each game, including tracking best performance.

### Technologies used:
- **Bash**
- **PostgreSQL**

---

## Number Guessing Game

This project is a Bash script that lets users play a number guessing game. The game will prompt the user to guess a secret number between 1 and 1000, give feedback on whether the guess is higher or lower, and store user performance statistics in a PostgreSQL database.

### Features:
- Randomly generates a number between 1 and 1000 for each game session.
- Gives users hints if their guess is too high or too low.
- Tracks the number of guesses made by the player.
- Stores user data and performance metrics in a PostgreSQL database.
  - Tracks the total number of games played by the user.
  - Records the number of guesses made in the player's best game (i.e., fewest guesses).

### Setup and Installation:

#### 1. Clone the repository:
```bash
git clone https://github.com/yourusername/number-guessing-game.git
cd number-guessing-game
```

#### 2. Setup the PostgreSQL database:
Make sure PostgreSQL is installed and running on your machine. You will also need to create the database and table used by the game.

- Create a database called `number_guess`:
```sql
CREATE DATABASE number_guess;
```

- Switch to the `number_guess` database:
```bash
\c number_guess
```

- Create the `users` table:
```sql
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  games_played INT NOT NULL,
  best_game INT
);
```

#### 3. Modify the Bash script:
Ensure that the `PSQL` command in the script is correctly set up with the PostgreSQL username and database name. In this example, it uses the user `freecodecamp` and the database `number_guess`. Update it as needed for your environment:
```bash
PSQL="psql --username=your_postgres_username --dbname=number_guess -t --no-align -c"
```

#### 4. Run the script:
Make the script executable and run it:
```bash
chmod +x number_guessing_game.sh
./number_guessing_game.sh
```

### How to Play:
1. The game starts by asking for your username. If you're a returning player, it will display your game history. If you're a new player, it will create a new record for you.
2. You will be prompted to guess a number between 1 and 1000.
3. The game will provide feedback whether the guess is too high, too low, or correct.
4. When the secret number is guessed, the game ends, and your performance is recorded.
5. After each round, the game updates your total games played and checks if you achieved a new "best game" with fewer guesses.

### Example Gameplay:

```bash
$ ./number_guessing_game.sh
Enter your username:
john_doe
Welcome back, john_doe! You have played 3 games, and your best game took 5 guesses.
Guess the secret number between 1 and 1000:
500
It's lower than that, guess again:
250
It's higher than that, guess again:
375
It's lower than that, guess again:
...
You guessed it in 7 tries. The secret number was 312. Nice job!
```

### Future Enhancements:
- Add difficulty levels with different ranges of numbers.
- Track more player statistics, such as average guesses per game.
- Create a leaderboard for players with the fewest guesses.

---

### License
This project is licensed under the MIT License.
