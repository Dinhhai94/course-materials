
# Rock-Paper-Scissors

### Exercise 1
#### the Math Object

We've been using Objects pretty frequently already. Every time you've typed `document.querySelector()` or `console.log()`, you've been accessing functions that are attached to the `document` and `console` objects, respecively. These are built into the browser, and we can use any of the pre-built properties on these Objects using dot notation.

There are lots of additional Objects that come packaged within JavaScript, too. One of them is called `Math`. Try out the following in a console:

```javascript
    Math
    Math.PI
    Math.E
    Math.pow(9, 2)
    Math.random()
    Math.floor(7.2)
    Math.ceil(7.2)
    Math.ceil( Math.random() * 10 )
    Math.ceil( Math.random() * 10 )
```

### Portfolio Project 2 (Bonus)
#### Rock, Paper, Scissors

Use `prompt()` to create a Rock, Paper, Scissors game for visitors to your portfolio.

1. Ask for input until the user enters either "R", "P", or "S". HINT:

```javascript
const userChoice = prompt("Choose Rock, Paper, or Scissors by typing 'R', 'P', or 'S'");
```
2. Use `Math.random()` to choose a play for the computer after you've gathered input. HINT:

```javascript
const rng = Math.random();
const computerChoice = "R";

if(rng > 0.66) {
    computerChoice = "P";
} else if (rng > 0.33) {
    computerChoice = "S";
}
```
3. Tell the user what the outcome of the hand was with an `alert()`. There are _lots_ of ways to compare hands, try out a few! HINT (as an example):

```javascript
const userWins = "You win!";
const computerWins = "The computer wins!";

if(computerChoice !== userChoice){
    if(computerChoice === "R"){
        if (userChoice === "S") {
            alert(computerWins);
        } else {
            alert(userWins);
        }
    } else if (computerChoice === "P") {
        if( userChoice === "R") {
            alert(computerWins);
        } else {
            alert(userWins);
        }
    } else {
        if( userChoice === "P") {
            alert(computerWins);
        } else {
            alert(userWins);
        }
    }
} else {
    alert('Tie!');
}
```
4. Use a `while` loop to repeat the process five times. HINT:

```javascript
const userWins = "You win!";
const computerWins = "The computer wins!";
const roundCounter = 0;

const gameRound = function(){
    const userChoice = prompt("Choose Rock, Paper, or Scissors by typing 'R', 'P', or 'S'");
    const computerChoice = "R";
    const rng = Math.random();

    if(rng > 0.66) {
        computerChoice = "P";
    } else if (rng > 0.33) {
        computerChoice = "S";
    }

    if(computerChoice !== userChoice){
        if(computerChoice === "R"){
            if (userChoice === "S") {
                alert(computerWins);
            } else {
                alert(userWins);
            }
        } else if (computerChoice === "P") {
            if( userChoice === "R") {
                alert(computerWins);
            } else {
                alert(userWins);
            }
        } else {
            if( userChoice === "P") {
                alert(computerWins);
            } else {
                alert(userWins);
            }
        }
    } else {
        alert('Tie!');
    }
};

while (roundCounter < 5) {
    gameround();
    roundCounter++;
}

```
