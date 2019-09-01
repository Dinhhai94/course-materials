# Hack-a-thon \#2: Building a Bookstore

## Building a Bookstore Part 1

Today is the day we finally _MONETIZE_! Our billion-dollar idea: we're going head-to-head with Amazon's book store. This will be a group project using the same GitHub workflow that we used for the Student Showcase website.

## Step 1: Set up a GitHub repo

1. Fork and clone your integration manager/instructor's boilerplate for this project, and make sure that your remotes are set up correctly for the GitHub workflow!
2. If you or your team needs to review, take a look at the student showcase.

## Step 2: Self-Reflection

The following lists the core web development skills that you should feel comfortable using in your project thus far:

1. Using Markdown to create a README.md file introducing your project.
2. Pushing to GitHub and seeing it rendered on your repository's main page.
3. Creating an HTML document using the following HTML tags:
   * `<html>`, `<head>`, `<title>`, `<body>`
   * header and paragraph tags
   * bold and italic tags
   * `<div>` and `<span>`
   * ordered and unordered lists
   * images and links
4. Using a style attribute on an HTML element, then a `<style>` tag in the head, then a `<link>` tag to a separate `.css` document to include CSS styles in your page.
5. Refactoring your code to use classes and ids.
6. Using complex CSS selectors
7. Using `position`s `fixed`, `absolute`, and `sticky` to position elements
8. Creating an HTML form incorporating various inputs \(`text, password, email, textarea, radio, checkbox, submit`, etc\)
9. Making your form live using Formspree
10. Using `display: flex` to build dynamic containers in 2 dimensions
11. Using the CSS grid system to lay out your page
12. Using built-in global functions like `console.log`
13. Setting and retrieving values from JavaScript variables and complex data types like Arrays and Objects
14. Using `document.querySelector()` in conjunction with `.textContent` and `.innerHTML` to retrieve and place content on the page
15. Using `if`, `else if` and `else` to implement branching logic
16. Using logical and \(`&&`\), logical or \(`||`\), and boolean negation \(`!`\)
17. Composing functions with `return` values
18. Using basic `event`s to help users interact with your page

## Step 3: Coding!

Let's go through the following steps, dividing up tasks as a team, to get this new mega-store launched. Good luck:

1. To start, make sure you've properly forked and set up your project repo.
2. Create `Navigation`, `Header`, `Content`, and `Footer` components to inject into a `div` with an `id` of `root`. Use `parcel` and the module system to organize these components! You should be able to create the entire application with a single `render` function.
3. Now add some content to the header and footer components.
4. Add layout CSS using `position`s and/or `grid`.
5. Add some css styles to make each component stand out.
6. Create a `<form>` element that will allow a user to input a new book \(eventually\). Make sure that each field has a `name` attribute that's _exactly the same_ as the corresponding property listed above \(you'll see why in a minute\).
7. Now take all the information about our books and make them into JavaScript Objects. Create variables `book1`, `book2`, etc. Set each equal to an object with keys `name`, `author`, and `pictureUrl`, which hold string values, `price` and `id`, which holds a number value, and `sellingPoints`, which is an Array of Strings. EXAMPLE:

   ```javascript
   const book1 = {
       "id": 1,
       "name": "Lasagna: A Retrospective",
       "author": "Garfield"
       "pictureUrl": "http://graphics8.nytimes.com/images/2015/10/15/   dining/15RECIPE20DIN/15RECIPE20DIN-articleLarge.jpg",
       "price": 24,
       "sellingPoints": [
           "Lasagna is delicious.",
           "The essential guide to Italian casseroles of all types.",
           "Real G's move silent, like Lasagna. -Lil Wayne"
       ]
   }
   ```

8. Create a `Book` stateless functional component that takes in a book Object \(like the one above\) and outputs that book's information in card-like markup.
9. Make sure that the `Book` component has corresponding styles!
10. `import` the `Book` component into your `Content` component, using it to transform each `book` Object into useable markup. What are the limitations of this approach?
11. Instead of `import`-ing `Book` into `Content`, let's feed all of the book Objects into `Content` in `index.js`. How could you organize those book Objects into a single complex data type to give to `Content`? And how could we handle that complex data type in `Content`
12. Now let's make this form work! We'll do that by hooking into the `submit` event:

    ```javascript
    document
       .querySelector('form')
       .addEventListener(
           'submit',
           (event) => {
               const data = event.target.elements;
               const newProduct = {
                   'name': data[0].value,
                   'author': data[1].value,
                   'pictureURL': data[2].value,
                   'price': data[3].value,

                   // we'll learn how to handle sellingPoints next
                   'sellingPoints': []
               };

               // this might be a hint for number 11
               booksArray[booksArray.length] = newProduct;

               render(booksArray);
           }
       );
    ```

In whatever time remains, make sure that this bookstore looks as good as we can make it!

