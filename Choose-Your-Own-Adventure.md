## Choose-Your-Own-Adventure

Let's spend the rest of class creating a "choose your own adventure" style text adventure game by using multiple prompts and branching if/ else conditional statements. Write a story into an HTML document on the basis of the user's responses to the prompts. The story will be a bit open-ended, but you should set up your game like so:

1. In your `projects` directory, add a new directory named `choose-your-own-adventure`.
2. Add an `index.html` file to the root of the CYOA directory and set it up according to best practices.
3. In your media AND home pages (the `index.html` document at the root of the `media` directory and your root directory), add a link to the CYOA page.
4. Create a `cyoa.js` document and link it to your CYOA `HTML` document with a `<script>` tag.
5. Use `prompt()` to lead visitors down different story paths. Something like this:

```javascript
var response = prompt("You walk into a room with a chair and a window. Type 'sit' to sit in the chair, type 'gaze' to gaze wistfully out the window and sigh");

if(response === "sit"){
    response = prompt("Here's a new prompt, with new options");
} else if (response === "gaze") {
    response = prompt("Here's a new prompt, with new options");
} else {
    alert("Please type in a valid input! Refresh the page to try again.");
}
```

Try to add some options that include responses for multiple options using the `||` and `&&` operators. Good luck! When you like your story, be sure to `add`, `commit`, and `push` your commits to GitHub, then `deploy` your changes to your live site.
