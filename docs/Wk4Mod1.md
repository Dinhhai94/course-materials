## Building a Bookstore Part 2

Remember our billion-dollar Bookstore Hack-A-Thon? This week, we're going to connect the Bookstore to an honest-to-goodness RESTful JSON API. Good Luck:

1. Start where you left off with Part One of our bookstore project. We should have a number of books set up in an Array, plus a `form` element that can be used to add a new book to the existing product list. Remember, book Array (and Objects) should take the form:

   ```javascript
   const books = [
     {
       "id": 1,
       "name": "Lasagna: A Retrospective",
       "author": "Garfield"
       "picture_url": "http://graphics8.nytimes.com/images/2015/10/15/   dining/15RECIPE20DIN/15RECIPE20DIN-articleLarge.jpg",
       "price": 24,
       "selling_points": [
           "Lasagna is delicious.",
           "The essential guide to Italian casseroles of all types.",
           "Real G's move silent, like Lasagna. -Lil Wayne"
       ]
     },
     // plus a few more Objects
   ];
   ```

2. Make sure that you have functional components that can be rendered with a single `render` function. Something like:

   ```javascript
   function render(state) {
     root.innerHTML = `
       ${Navigation()}
       ${Header()}
       ${Content(state)}
       ${Form()}
       ${Footer()}
     `;
   }

   render(books);
   ```

3. At this point, `Content` should be able to handle the Array of `books`. Last time, we didn't know about loops of any kind, so the `Book` component looked something like:

   ```javascript
   import Book from "./Book";

   export default function Content(books) {
     return `
       <div id="content">
         ${Book(books[0])}
         ${Book(books[1])}
         ${Book(books[2])}
       </div>
     `;
   }
   ```

   Let's refactor this to use `.map` and `.join`, e.g.:

   ```javascript
   import Book from "./Book";

   function mapBooks(books) {
     return books.map(book => Book(book)).join("");
   }

   export default function Content(books) {
     return `
       <div id="content">
         ${mapBooks(books)}
       </div>
     `;
   }
   ```

   Now we can have an _unlimited_ number of books, just like our favorite big-box bookstores!

4. We can do the same thing with the `sellingPoints` Array in our `Book` component. HINT:

   ```javascript
   function mapSellingPoints(sellingPoints) {
     return sellingPoints.map(point => `<li>${point}</li>`).join("");
   }

   export default function Book(book) {
     return `
       <div>
         <h1>${book.name}</h1>
         <h2>${book.author}</h2>
         <h3>${book.price}</h3>
         <ol>
           ${mapSellingPoints(book.sellingPoints)}        
         </ol>
         <img src="${book.pictureUrl}">
       </div>
     `;
   }
   ```

5. Now that we're a bit more comfortable with Array superpowers like `.forEach`, `.map`, and `.join`, we can introduce a String superpower called `.split()`. This function can be called on any String to "split" that String into an Array of smaller strings. Let's turn our users' `sellingPoints` into a _comma-separated_ Array of `sellingPoints` on form submit. That would be something like:

   ```javascript
   // other form submit event stuff here

   sellingPoints: data[4].value.split(",");

   // even more form submit stuff here
   ```

6. Our last iteration of the form `submit` event handler was a bit repetetive. How can it be refactored to make our `newProduct` construction a bit more `DRY`? HINT:

   ```javascript
   document
     .querySelector('form')
     .addEventListener(
       'submit',
       (event) => {
         const newProduct = event
           .target
           .elements
           .reduce(
             (acc, product) => {
               if(product.name === 'sellingPoints'){
                 acc.sellingPoints = product.value.split(',');
               }
               else {
                 acc[product.name] = product.value;
               }

               return acc;
             }
             {},
           )
         }

         books.push(newProduct);

         render(books);
       );
   ```

Now, _that_ is a fancy event handler. Make sure you understand it before we get much farther in this Hack-A-Thon!

7. This is a lot of work for three books. What's the advantage to doing all of this work in JavaScript? While we could argue about the quality of the developer experience in JavaScript-land vs HTML-land, one thing is certain: if we want to use _external_ data instead of hard-coded book Objects, we need to use JavaScript. More specifically, we need to use AJAX.

We've set up an API to query at https://api.savvycoders.com/books that will return an Array of `book` Objects structured identically to the ones we've been hard-coding up to this point. See if you can render the bookstore with data from this API. HINT:

```javascript
axios // don't forget to npm install this!
  .get("https://api.savvycoders.com/books")
  .then(response => render(response.data));
```

9. This all works great for just books, but what if we wanted to add music to our store? We'll need another refactor! How could we re-organize our product data to account for the differences between types of products? Let's try adding our `books` Array to a new `products` Object that includes `books` and `albums` Arrays. HINT:

   ```javascript
   const products = {
     books: [book1, book2],
     albums: [album1, album2] // albums should be identical to book objects
   };
   ```

10. You'll be happy to see that there is an `/albums` route in our Savvy Coders API, too. But how do we render _both_ `books` and `albums` on initial page load? We could delay rendering _anything_ until we get both `books` and `albums`, but that doesn't make things better for our users. We could also delay rendering _*all* products_ until we have both books and albums, but that also delays our time-to-first-meaningful-interaction, irritating users. What if we rendered whatever came back first from our API, then re-render whenever the second batch comes in? Then we can use our `products` Object as a `state` store and do the following:

   ```javascript
   const products = {
     books: [],
     albums: []
   };

   axios.get("https://api.savvycoders.com/books").then(response => {
     response.data.forEach(book => products.books.push(book));

     render(products);
   });

   axios.get("https://api.savvycoders.com/albums").then(response => {
     response.data.forEach(album => products.albums.push(album));

     render(products);
   });

   render(products); // this should be the first render
   ```

   You should also need to modify the `Content`

11. If everything went as planned, you should have a variety of different products rendered on the page! But now our `form` is broken again... we'll push _every_ product to the `books` Array, which wouldn't make much sense. Let's add an `input` of type `radio` to let users choose between types of `book` or `album`, then modify our form's `submit` event handler to account for the new field. It should be a one-line change! HINT:

   ```javascript
   // form submit event stuff

   // notice the String interpolation!
   product[`${newProduct.type}s`].push(newProduct);

   // even more form submit event stuff
   ```

12. Now let's let users filter between Books and Albums when they click on the `books` and `albums` links in the `Navigation` component. What might that look like? HINT:

   ```javascript
   const links = document.querySelectorAll("#navigation a");

   links[0].addEventListener("click", event => {
     const filteredProducts = {
       // why do we need to do this?
       books: products.books,
       albums: []
     };

     event.preventDefault();

     render(filteredProducts);
   });

   links[1].addEventListener("click", event => {
     const filteredProducts = {
       books: [],
       albums: products.albums
     };

     event.preventDefault();

     render(filteredProducts);
   });
   ```

13. Now our bookstore has quite a few features! It's missing _one last thing_ (besides, you know, a checkout system, or a business plan): notice that new books that we add don't yet persist beyond page refreshes. We can still pull down data from our API, but that data doesn't reflect any of the work that we've done so far! Let's fix that with a `POST` request to our API in the form's event handler. What does this do?

   ```javascript
   // form submit stuff here

   const pluralizedType = `${newProduct.type}s`;

   products[pluralizedType].push(newProduct);

   axios.post(`https://api.savvycoders.com/${pluralizedType}`,    newProduct);

   // more form submit stuff here
   ```

Once this is done, we should be able to persist our product data between page refreshes. Go team!

14. In the time remaining (or as extra credit on your own), see if you can implement some of the following features:

   - Can you filter `products` by `title` using a Search `input` and a `keyup` event listener?
   - Can you delete books from the front end on `click`?
   - Can you delete books from the back-end database using a `DELETE` request (e.g. `axios.delete`)?
   - Can you add the ability to edit books on the front end?
   - Can you persist book edits to the API using a `PATCH` request (e.g. `axios.patch`)?
   - Can you add loading indicators using Font Awesome spinners and fa-spin?
