# Choose-Your-Own-Adventure

Write a story into an HTML document on the basis of the user's responses to the prompts. The story will be a bit open-ended, but you should set up your game like so:

1. In your `projects` directory, add a new directory named `choose-your-own-adventure`.
2. Add an `index.html` file to the root of the CYOA directory and set it up according to best practices.
3. In your project page (the `index.html` document at the root of the `projects` directory), add a link to the CYOA page.
4. Create a `cyoa.js` document and link it to your CYOA `HTML` document with a `<script>` tag.
5. Use `prompt()` to lead visitors down different story paths. Something like this:

```javascript
let response = prompt("You walk into a room with a chair and a window. Type 'sit' to sit in the chair, type 'gaze' to gaze wistfully out the window and sigh");

if(response === "sit"){
    response = prompt("Here's a new prompt, with new options");
} else if (response === "gaze") {
    response = prompt("Here's a new prompt, with new options");
} else {
    alert("Please type in a valid input! Refresh the page to try again.");
}
```

---

## Testing Your Choose-Your-Own-Adventure Choices

At this point, we should have a single `runStory` function that looks something like this:

```javascript
function runStory( branch ){
    const chapter = story[branch];
    const choices = chapter.choices;
    let isValidChoice = false;
    let choice;

    if( choices ){
        choice = prompt( chapter.text );

        for( let i = 0; i < choices.length; i++ ){
            if( choice === choices[i] ){
                isValidChoice = true;
            }
        }

        if( isValidChoice ){
            runStory( choice );
        }
        else{
            runStory( branch );
        }
    }
    else{
        document
            .querySelector( "#output" )
            .textContent = chapter.text;
    }
};
```

While this works, it has a complexity (or number of possible branches) of more than 4. This is tough to read and tough to debug. How can we reduce the complexity of this function through `return` values?

1. Let's start with choice validation. How can we wrap up the choice-checking logic in a function that `return`s a single Boolean value? How about:

```javascript
function validateChoice( choice, choices ){
  let isValidChoice = false;

  for( let i = 0; i < choices.length; i++ ){
      if( choice === choices[i] ){
          isValidChoice = true;
      }
  }

  return isValidChoice;
}
```

2. Once we've re-written our `validateChoice` logic, we can refactor `runStory` into something like this:

```javascript
function runStory( branch ){
    const chapter = story[branch];
    const choices = chapter.choices;
    let choice;

    if( choices ){
        choice = prompt( chapter.text );

        if( validateChoice( choice, choices ) ){
            runStory( choice );
        }
        else{
            runStory( branch );
        }
    }
    else{
        document
            .querySelector( "#output" )
            .textContent = chapter.text;
    }
};

```

Notice how we're able to use the `return`ed value from `validateChoice` as the truthy (or falsey) value in our second `if` statement. That should knock down our complexity a notch while letting us abstract away our choice logic for the future. Now we can manipulate our choice-checking logic however we'd like without touching our original `runStory` function. Pretty cool! But what else can we do to make this function simpler?

How about getting rid of the nested `if` statement entirely? Let's try it!

```javascript
function handleChoices( choices ){
    const choice = prompt( chapter.text );

    if( validateChoice( choice, choices ) ){
        runStory( choice );
    }
    else{
        runStory( branch );
    }
}

function runStory( branch ){
    const chapter = story[branch];
    const choices = chapter.choices;

    if( choices ){
        handleChoices( choices );
    }
    else{
        document
            .querySelector( "#output" )
            .textContent = chapter.text;
    }
};
```

Now we have the additional mental overhead of multiple functions, with the added benefit of clearer intent and less per-function complexity. What do you think?
